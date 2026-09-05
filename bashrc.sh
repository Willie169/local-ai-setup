#!/usr/bin/env bash

export PATH="$HOME/llama.cpp/build/bin:${PATH:-}"
export HF_HOME="$HOME/hf-models"
export CUDA_SCALE_LAUNCH_QUEUES=4x
export GGML_CUDA_ENABLE_UNIFIED_MEMORY=1

update_local_ai_setup() {
  (
    cd ~/.local-ai-setup || exit
    git reset --hard
    git pull --rebase
    git clean -fd
  )
}

_update_llama_cpp() {
  (
    cd llama.cpp || exit
    rm -rf build
    git reset --hard
    git pull --rebase
    git clean -fd
    cmake -B build -DGGML_CUDA=ON
    cmake --build build --config Release
  )
}

update_llama_cpp() {
  update_local_ai_setup
  . ~/.local-ai-setup/bashrc.sh
  _update_llama_cpp
}

_update_comfyui() {
  (
    cd ~/ComfyUI || exit
    git reset --hard
    git pull --rebase
    git clean -fd
    local repos=(
      "Willie169/ComfyUI-Crystools"
      "city96/ComfyUI-GGUF"
      "DarioFT/ComfyUI-Qwen3-TTS"
      "yuvraj108c/ComfyUI-Whisper"
    )
    cat >~/ComfyUI/user/environment.yml <<'EOF'
name: comfyui
channels:
  - conda-forge
  - pytorch
  - pypi
dependencies:
  - python=3.13
  - pip
  - pip:
      - torch --extra-index-url https://download.pytorch.org/whl/cu130
      - torchvision --extra-index-url https://download.pytorch.org/whl/cu130
      - torchaudio --extra-index-url https://download.pytorch.org/whl/cu130
      - -r ../requirements.txt
EOF
    for repo in "${repos[@]}"; do
      local d="${repo#*/}"
      echo "      - -r ../custom_nodes/$d/requirements.txt" >>~/ComfyUI/user/environment.yml
      if [[ -d ~/ComfyUI/custom_nodes/"$d" ]]; then
        cd ~/ComfyUI/custom_nodes/"$d" || continue
        git reset --hard
        git pull --rebase
        git clean -fd
      else
        cd ~/ComfyUI/custom_nodes || continue
        git clone "https://github.com/$repo.git"
      fi
    done
    cd ~/ComfyUI || exit
    conda env update -f user/environment.yml --prune
    hf download stable-diffusion-v1-5/stable-diffusion-v1-5 v1-5-pruned-emaonly.safetensors --local-dir ~/ComfyUI/models/checkpoints
    hf download unsloth/FLUX.2-klein-4B-GGUF flux-2-klein-4b-Q4_K_M.gguf --local-dir ~/ComfyUI/models/unet
    hf download black-forest-labs/FLUX.2-klein-4B vae/diffusion_pytorch_model.safetensors --local-dir ~/ComfyUI/models
    hf download Comfy-Org/z_image_turbo --include 'split_files/text_encoders' --local-dir ~/ComfyUI/models
    hf download city96/stable-diffusion-3.5-medium-gguf sd3.5_medium-Q4_K_M.gguf --local-dir ~/ComfyUI/models/unet
    hf download Comfy-Org/ace_step_1.5_ComfyUI_files checkpoints/ace_step_1.5_turbo_aio.safetensors --local-dir ~/ComfyUI/models
    hf download Qwen/Qwen3-TTS-Tokenizer-12Hz --local-dir ~/ComfyUI/models/Qwen3-TTS/Qwen3-TTS-Tokenizer-12Hz
    hf download Qwen/Qwen3-TTS-12Hz-0.6B-CustomVoice --local-dir ~/ComfyUI/models/Qwen3-TTS/Qwen3-TTS-12Hz-0.6B-CustomVoice
    hf download Qwen/Qwen3-TTS-12Hz-0.6B-Base --local-dir ~/ComfyUI/models/Qwen3-TTS/Qwen3-TTS-12Hz-0.6B-Base
    mkdir -p ~/ComfyUI/models/stt/whisper
    conda run -n comfyui -- python -c '
from pathlib import Path
from whisper import _download, _MODELS

_download(_MODELS["small"], str(Path("~/ComfyUI/models/stt/whisper").expanduser()), False)
'
  )
}

update_comfyui() {
  update_local_ai_setup
  . ~/.local-ai-setup/bashrc.sh
  _update_comfyui
  systemctl --user restart comfyui
}

whisper() {
  conda run -n comfyui -- whisper "$@"
}
