#!/usr/bin/env bash

mkdir ~/open-notebook
cat >~/open-notebook/docker-compose.yml <<EOF
services:
  surrealdb:
    image: surrealdb/surrealdb:v2
    command: start --log info --user root --pass root rocksdb:/mydata/mydatabase.db
    user: root
    network_mode: host
    volumes:
      - ./surreal_data:/mydata
    restart: always

  open_notebook:
    image: lfnovo/open_notebook:v1-latest
    network_mode: host
    environment:
      - OPEN_NOTEBOOK_ENCRYPTION_KEY=change-me-to-a-secret-string
      - SURREAL_URL=ws://localhost:8000/rpc
      - SURREAL_USER=root
      - SURREAL_PASSWORD=root
      - SURREAL_NAMESPACE=open_notebook
      - SURREAL_DATABASE=open_notebook
    volumes:
      - ./notebook_data:/app/data
    depends_on:
      - surrealdb
    restart: always
EOF
cd ~/open-notebook || exit
docker compose pull
cd ~ || exit
cat >~/.config/systemd/user/open-notebook.service <<EOF
[Unit]
Description=Open Notebook
Requires=docker.service
After=docker.service

[Service]
WorkingDirectory=$HOME/open-notebook
ExecStart=/usr/bin/docker compose up
ExecStop=/usr/bin/docker compose stop
Restart=always
RestartSec=5

[Install]
WantedBy=default.target
EOF
systemctl --user daemon-reload
systemctl --user enable --now open-notebook
