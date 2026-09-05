#!/usr/bin/env bash

cd ~ || exit
rm -rf ~/.local-ai-setup
git clone https://github.com/Willie169/local-ai-setup.git ~/.local-ai-setup
. ~/.local-ai-setup/bashrc.sh
sudo apt update
sudo DEBIAN_FRONTEND=noninteractive apt install cmake build-essential ninja-build libgomp1 git libssl-dev jq python3 python3-venv python3-pip -y -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-overwrite"
uv tool install huggingface_hub
mkdir ~/hf-models
export HF_HOME="$HOME/hf-models"
git clone https://github.com/ggml-org/llama.cpp.git
cd llama.cpp || exit
cmake -B build -DGGML_CUDA=ON
cmake --build build --config Release
cd ~ || exit
brew tap mostlygeek/llama-swap
brew trust mostlygeek/llama-swap
brew install llama-swap
. _update_llm_models
cat >~/.config/systemd/user/llama-swap.service <<EOF
[Unit]
Description=llama-swap

[Service]
Environment="HF_HOME=$HOME/hf-models"
Environment="PATH=$HOME/llama.cpp/build/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"
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
conda create -n comfyui python=3.13 -y
git clone https://github.com/Comfy-Org/ComfyUI.git
_update_comfyui
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
