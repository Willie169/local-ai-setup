#!/usr/bin/env bash

mkdir ~/ComfyUI
cd ~/ComfyUI || exit
cat >docker-compose.yml <<'EOF'
services:

  comfyui:
    init: true
    container_name: comfyui-megapak
    image: "yanwk/comfyui-boot:cu130-megapak-pt211"
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
      - CLI_ARGS=
    security_opt:
      # - "label=type:nvidia_container_t"
      - "label=disable"
      - "seccomp=unconfined"
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              device_ids: ['0']
              capabilities: [gpu]
EOF
sudo docker compose pull
cd ~ || exit
chmod 777 ~/ComfyUI
chmod u+s ~/ComfyUI
hf download hf://stable-diffusion-v1-5/stable-diffusion-v1-5/v1-5-pruned-emaonly.safetensors --local-dir ~/ComfyUI/storage-models/models/checkpoints
hf download hf://unsloth/FLUX.2-klein-4B-GGUF/flux-2-klein-4b-Q4_K_M.gguf --local-dir ~/ComfyUI/storage-models/models/checkpoints
hf download hf://city96/stable-diffusion-3.5-medium-gguf/sd3.5_medium-Q4_K_M.gguf --local-dir ~/ComfyUI/storage-models/models/checkpoints
hf download hf://Serveurperso/ACE-Step-1.5-GGUF/acestep-v15-sft-Q4_K_M.gguf --local-dir ~/ComfyUI/storage-models/models/checkpoints
hf download hf://Qwen/Qwen3-TTS-Tokenizer-12Hz --local-dir ~/ComfyUI/storage-models/models/TTS/Qwen3-TTS/Qwen3-TTS-Tokenizer-12Hz
hf download hf://Qwen/Qwen3-TTS-12Hz-1.7B-CustomVoice --local-dir ~/ComfyUI/storage-models/models/TTS/Qwen3-TTS/Qwen3-TTS-12Hz-1.7B-CustomVoice
hf download hf://Qwen/Qwen3-TTS-12Hz-1.7B-VoiceDesign --local-dir ~/ComfyUI/storage-models/models/TTS/Qwen3-TTS/Qwen3-TTS-12Hz-1.7B-VoiceDesign
hf download hf://Qwen/Qwen3-TTS-12Hz-1.7B-Base --local-dir ~/ComfyUI/storage-models/models/TTS/Qwen3-TTS/Qwen3-TTS-12Hz-1.7B-Base
hf download hf://Qwen/Qwen3-TTS-12Hz-0.6B-CustomVoice --local-dir ~/ComfyUI/storage-models/models/TTS/Qwen3-TTS/Qwen3-TTS-12Hz-0.6B-CustomVoice
hf download hf://Qwen/Qwen3-TTS-12Hz-0.6B-Base --local-dir ~/ComfyUI/storage-models/models/TTS/Qwen3-TTS/Qwen3-TTS-12Hz-0.6B-Base
sudo tee /etc/systemd/system/comfyui.service >/dev/null <<EOF
[Unit]
Description=ComfyUI
Requires=docker.service
After=docker.service

[Service]
WorkingDirectory=$HOME/ComfyUI
ExecStart=/usr/bin/docker compose up
ExecStop=/usr/bin/docker compose stop
Restart=always
RestartSec=5

[Install]
WantedBy=default.target
EOF
sudo systemctl daemon-reload
sudo systemctl enable --now comfyui
