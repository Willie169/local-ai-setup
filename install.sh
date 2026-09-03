#!/usr/bin/env bash

sudo apt update
sudo DEBIAN_FRONTEND=noninteractive apt install cmake build-essential ninja-build libgomp1 git libssl-dev jq python3 python3-venv python3-pip -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
git clone https://github.com/Willie169/local-ai-setup.git ~/.local-ai-setup
uv tool install huggingface_hub
mkdir ~/hf-models
export HF_HOME="$HOME/hf-models"
cd ~ || exit
git clone https://github.com/ggml-org/llama.cpp.git
cd llama.cpp || exit
cmake -B build -DGGML_CUDA=ON
cmake --build build --config Release
cd ~ || exit
hf download hf://unsloth/Qwen3.5-9B-GGUF/Qwen3.5-9B-Q4_K_M.gguf
hf download hf://unsloth/Qwen3.5-9B-GGUF/mmproj-BF16.gguf
hf download hf://unsloth/Qwen3.5-4B-GGUF/Qwen3.5-4B-Q4_K_M.gguf
hf download hf://unsloth/Qwen3.5-4B-GGUF/mmproj-BF16.gguf
hf download hf://unsloth/Qwen3.5-2B-GGUF/Qwen3.5-2B-Q4_K_M.gguf
hf download hf://unsloth/Qwen3.5-2B-GGUF/mmproj-BF16.gguf
hf download hf://unsloth/gemma-4-12B-it-qat-GGUF/gemma-4-12B-it-qat-UD-Q4_K_XL.gguf
hf download hf://unsloth/gemma-4-12B-it-qat-GGUF/mmproj-BF16.gguf
hf download hf://unsloth/gemma-4-12B-it-qat-GGUF/mtp-gemma-4-12B-it.gguf
hf download hf://unsloth/gemma-4-E4B-it-qat-GGUF/gemma-4-E4B-it-qat-UD-Q4_K_XL.gguf
hf download hf://unsloth/gemma-4-E4B-it-qat-GGUF/mmproj-BF16.gguf
hf download hf://unsloth/gemma-4-E4B-it-qat-GGUF/mtp-gemma-4-E4B-it.gguf
hf download hf://unsloth/gemma-4-E2B-it-qat-GGUF/gemma-4-E2B-it-qat-UD-Q4_K_XL.gguf
hf download hf://unsloth/gemma-4-E2B-it-qat-GGUF/mmproj-BF16.gguf
hf download hf://unsloth/gemma-4-E2B-it-qat-GGUF/mtp-gemma-4-E2B-it.gguf
brew tap mostlygeek/llama-swap
brew trust mostlygeek/llama-swap
brew install llama-swap
cat >~/.config/systemd/user/llama-swap.service <<EOF
[Unit]
Description=llama-swap

[Service]
Environment="HF_HOME=$HOME/hf-models"
WorkingDirectory=$HOME/.local-ai-setup/llama-swap
ExecStart=/home/linuxbrew/.linuxbrew/bin/llama-swap -config config.yaml
Restart=always
RestartSec=5

[Install]
WantedBy=default.target
EOF
systemctl --user daemon-reload
systemctl --user enable --now llama-swap
npm i -g --ignore-scripts @earendil-works/pi-coding-agent
pi install npm:@danielmeneses/pi-llama-swap
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
docker compose pull
cd ~ || exit
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
hf download hf://stable-diffusion-v1-5/stable-diffusion-v1-5/v1-5-pruned-emaonly.safetensors --local-dir ~/ComfyUI/storage-models/models/checkpoints
hf download hf://unsloth/FLUX.2-klein-4B-GGUF/flux-2-klein-4b-Q4_K_M.gguf --local-dir ~/ComfyUI/storage-models/models/unet
hf download hf://black-forest-labs/FLUX.2-klein-4B/vae/diffusion_pytorch_model.safetensors --local-dir ~/ComfyUI/storage-models/models/vae
hf download hf://Comfy-Org/z_image_turbo/split_files/text_encoders/qwen_3_4b.safetensors --local-dir ~/ComfyUI/storage-models/models/text_encoders
mv ~/ComfyUI/storage-models/models/text_encoders/split_files/text_encoders/qwen_3_4b.safetensors ~/ComfyUI/storage-models/models/text_encoders/
rm -rf ~/ComfyUI/storage-models/models/text_encoders/split_files
hf download hf://city96/stable-diffusion-3.5-medium-gguf/sd3.5_medium-Q4_K_M.gguf --local-dir ~/ComfyUI/storage-models/models/unet
hf download hf://Serveurperso/ACE-Step-1.5-GGUF/acestep-v15-sft-Q4_K_M.gguf --local-dir ~/ComfyUI/storage-models/models/unet
hf download hf://Qwen/Qwen3-TTS-Tokenizer-12Hz --local-dir ~/ComfyUI/storage-models/models/TTS/Qwen3-TTS/Qwen3-TTS-Tokenizer-12Hz
hf download hf://Qwen/Qwen3-TTS-12Hz-0.6B-CustomVoice --local-dir ~/ComfyUI/storage-models/models/TTS/Qwen3-TTS/Qwen3-TTS-12Hz-0.6B-CustomVoice
hf download hf://Qwen/Qwen3-TTS-12Hz-0.6B-Base --local-dir ~/ComfyUI/storage-models/models/TTS/Qwen3-TTS/Qwen3-TTS-12Hz-0.6B-Base
