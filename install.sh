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
hf download unsloth/Qwen3.5-9B-GGUF Qwen3.5-9B-Q4_K_M.gguf
hf download unsloth/Qwen3.5-9B-GGUF mmproj-BF16.gguf
hf download unsloth/Qwen3.5-4B-GGUF Qwen3.5-4B-Q4_K_M.gguf
hf download unsloth/Qwen3.5-4B-GGUF mmproj-BF16.gguf
hf download unsloth/Qwen3.5-2B-GGUF Qwen3.5-2B-Q4_K_M.gguf
hf download unsloth/Qwen3.5-2B-GGUF mmproj-BF16.gguf
hf download unsloth/gemma-4-12B-it-qat-GGUF gemma-4-12B-it-qat-UD-Q4_K_XL.gguf
hf download unsloth/gemma-4-12B-it-qat-GGUF mmproj-BF16.gguf
hf download unsloth/gemma-4-12B-it-qat-GGUF mtp-gemma-4-12B-it.gguf
hf download unsloth/gemma-4-E4B-it-qat-GGUF gemma-4-E4B-it-qat-UD-Q4_K_XL.gguf
hf download unsloth/gemma-4-E4B-it-qat-GGUF mmproj-BF16.gguf
hf download unsloth/gemma-4-E4B-it-qat-GGUF mtp-gemma-4-E4B-it.gguf
hf download unsloth/gemma-4-E2B-it-qat-GGUF gemma-4-E2B-it-qat-UD-Q4_K_XL.gguf
hf download unsloth/gemma-4-E2B-it-qat-GGUF mmproj-BF16.gguf
hf download unsloth/gemma-4-E2B-it-qat-GGUF mtp-gemma-4-E2B-it.gguf
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
conda create --name comfyui python=3.13 -y
conda activate comfyui
git clone https://github.com/Comfy-Org/ComfyUI.git
cd ~/ComfyUI || exit
pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu130
pip install -r requirements.txt
cd ~/ComfyUI/custom_nodes || exit
git clone https://github.com/crystian/comfyui-crystools.git
cd comfyui-crystools || exit
pip install -r requirements.txt
cd ~/ComfyUI/custom_nodes || exit
git clone https://github.com/city96/ComfyUI-GGUF.git
cd ComfyUI-GGUF || exit
pip install -r requirements.txt
cd ~/ComfyUI/custom_nodes || exit
git clone https://github.com/DarioFT/ComfyUI-Qwen3-TTS.git
cd ComfyUI-Qwen3-TTS || exit
pip install -r requirements.txt
cd ~/ComfyUI || exit
hf download stable-diffusion-v1-5/stable-diffusion-v1-5 v1-5-pruned-emaonly.safetensors --local-dir ~/ComfyUI/models/checkpoints
hf download unsloth/FLUX.2-klein-4B-GGUF flux-2-klein-4b-Q4_K_M.gguf --local-dir ~/ComfyUI/models/unet
hf download black-forest-labs/FLUX.2-klein-4B vae/diffusion_pytorch_model.safetensors --local-dir ~/ComfyUI/models
hf download Comfy-Org/z_image_turbo --include 'split_files/text_encoders' --local-dir ~/ComfyUI/models
hf download city96/stable-diffusion-3.5-medium-gguf sd3.5_medium-Q4_K_M.gguf --local-dir ~/ComfyUI/models/unet
hf download Comfy-Org/ace_step_1.5_ComfyUI_files checkpoints/ace_step_1.5_turbo_aio.safetensors --local-dir ~/ComfyUI/models
hf download Qwen/Qwen3-TTS-Tokenizer-12Hz --local-dir ~/ComfyUI/models/Qwen3-TTS/Qwen3-TTS-Tokenizer-12Hz
hf download Qwen/Qwen3-TTS-12Hz-0.6B-CustomVoice --local-dir ~/ComfyUI/models/Qwen3-TTS/Qwen3-TTS-12Hz-0.6B-CustomVoice
hf download Qwen/Qwen3-TTS-12Hz-0.6B-Base --local-dir ~/ComfyUI/models/Qwen3-TTS/Qwen3-TTS-12Hz-0.6B-Base
conda deactivate
cat >~/.config/systemd/user/comfyui.service <<EOF
[Unit]
Description=ComfyUI

[Service]
WorkingDirectory=$HOME/ComfyUI
ExecStart=$HOME/conda/envs/comfyui/bin/python main.py
Restart=always
RestartSec=5

[Install]
WantedBy=default.target
EOF
systemctl --user daemon-reload
systemctl --user enable --now comfyui
