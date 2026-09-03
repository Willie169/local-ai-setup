#!/usr/bin/env bash

mkdir ~/ComfyUI-Docker
cd ~/ComfyUI-Docker || exit
cat >docker-compose.yml <<'EOF'
services:
  comfyui:
    init: true
    container_name: comfyui-cu130
    image: "yanwk/comfyui-boot:cu130-slim-v2"
    pull_policy: daily
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - "8188:8188"
    volumes:
      - "./storage-cache/dot-cache:/root/.cache"
      - "./storage-cache/dot-config:/root/.config"
      - "./storage-nodes/dot-local:/root/.local"
      - "./storage-nodes/custom_nodes:/root/ComfyUI/custom_nodes"
      - "./storage-models/models:/root/ComfyUI/models"
      - "./storage-models/hf-hub:/root/.cache/huggingface/hub"
      - "./storage-models/torch-hub:/root/.cache/torch/hub"
      - "./storage-user/input:/root/ComfyUI/input"
      - "./storage-user/output:/root/ComfyUI/output"
      - "./storage-user/user-profile:/root/ComfyUI/user"
      - "./storage-user/user-scripts:/root/user-scripts"
    environment:
      - CLI_ARGS=--listen
      - HF_TOKEN
    security_opt:
      - "label=type:nvidia_container_t"
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              device_ids: ["0"]
              capabilities: [gpu]
EOF
sudo docker compose pull
sudo chown -R "$USER":"$USER" storage-models
mkdir -p storage-models/checkpoints
cd ~ || exit
hf download stable-diffusion-v1-5/stable-diffusion-v1-5 v1-5-pruned-emaonly.safetensors --local-dir ~/ComfyUI-Docker/storage-models/checkpoints
hf download Comfy-Org/z_image_turbo split_files/text_encoders/qwen_3_4b.safetensors --local-dir ~/ComfyUI-Docker/storage-models/checkpoints
mv ~/ComfyUI-Docker/storage-models/checkpoints/split_files/text_encoders/qwen_3_4b.safetensors ~/ComfyUI-Docker/storage-models/checkpoints/
rm -r ~/ComfyUI-Docker/storage-models/checkpoints/split_files
hf download Comfy-Org/z_image_turbo split_files/diffusion_models/z_image_turbo_bf16.safetensors --local-dir ~/ComfyUI-Docker/storage-models/checkpoints
mv ~/ComfyUI-Docker/storage-models/checkpoints/split_files/diffusion_models/z_image_turbo_bf16.safetensors ~/ComfyUI-Docker/storage-models/checkpoints/
rm -r ~/ComfyUI-Docker/storage-models/checkpoints/split_files
hf download Comfy-Org/z_image_turbo split_files/vae/ae.safetensors --local-dir ~/ComfyUI-Docker/storage-models/checkpoints
mv ~/ComfyUI-Docker/storage-models/checkpoints/split_files/vae/ae.safetensors ~/ComfyUI-Docker/storage-models/checkpoints/
rm -r ~/ComfyUI-Docker/storage-models/checkpoints/split_files
sudo tee /etc/systemd/system/comfyui.service >/dev/null <<EOF
[Unit]
Description=ComfyUI
Requires=docker.service
After=docker.service

[Service]
WorkingDirectory=$HOME/ComfyUI-Docker
ExecStart=/usr/bin/docker compose up
ExecStop=/usr/bin/docker compose stop
Restart=always
RestartSec=5

[Install]
WantedBy=default.target
EOF
sudo systemctl daemon-reload
sudo systemctl enable --now comfyui
