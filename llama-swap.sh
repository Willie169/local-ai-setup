#!/usr/bin/env bash

brew tap mostlygeek/llama-swap
brew trust mostlygeek/llama-swap
brew install llama-swap
cat >~/.config/systemd/user/llama-swap.service <<EOF
[Unit]
Description=llama-swap

[Service]
Environment="HF_HOME=$HOME/hf-models"
WorkingDirectory=$HOME/.local-llm-setup/llama-swap
ExecStart=/home/linuxbrew/.linuxbrew/bin/llama-swap -config config.yaml
Restart=always
RestartSec=5

[Install]
WantedBy=default.target
EOF
systemctl --user daemon-reload
systemctl --user enable --now llama-swap
