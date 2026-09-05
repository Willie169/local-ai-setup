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

_update_llm_models() {
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
}

update_llm_models() {
  update_local_ai_setup
  . ~/.local-ai-setup/bashrc.sh
  _update_llm_models
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
    mkdir -p ~/ComfyUI-models
    hf download unsloth/FLUX.2-klein-4B-GGUF flux-2-klein-4b-Q4_K_M.gguf --local-dir ~/ComfyUI-models/FLUX.2-klein-4B-GGUF
    ln -sf ~/ComfyUI-models/FLUX.2-klein-4B-GGUF/flux-2-klein-4b-Q4_K_M.gguf ~/ComfyUI/models/unet/flux-2-klein-4b-Q4_K_M.gguf
    hf download Comfy-Org/vae-text-encorder-for-flux-klein-4b split_files/vae/flux2-vae.safetensors --local-dir ~/ComfyUI-models/vae-text-encorder-for-flux-klein-4b
    ln -sf ~/ComfyUI-models/vae-text-encorder-for-flux-klein-4b/split_files/vae/flux2-vae.safetensors ~/ComfyUI/models/vae/flux2-vae.safetensors
    hf download Comfy-Org/vae-text-encorder-for-flux-klein-4b split_files/text_encoders/qwen_3_4b.safetensors --local-dir ~/ComfyUI-models/vae-text-encorder-for-flux-klein-4b
    ln -sf ~/ComfyUI-models/vae-text-encorder-for-flux-klein-4b/split_files/text_encoders/qwen_3_4b.safetensors ~/ComfyUI/models/text_encoders/qwen_3_4b.safetensors
    hf download Comfy-Org/ace_step_1.5_ComfyUI_files checkpoints/ace_step_1.5_turbo_aio.safetensors --local-dir ~/ComfyUI-models/ace_step_1.5_ComfyUI_files/checkpoints
    ln -sf ~/ComfyUI-models/ace_step_1.5_ComfyUI_files/checkpoints/ace_step_1.5_turbo_aio.safetensors ~/ComfyUI/models/checkpoints/ace_step_1.5_turbo_aio.safetensors
    mkdir -p ~/ComfyUI/models/Qwen3-TTS
    hf download Qwen/Qwen3-TTS-Tokenizer-12Hz --local-dir ~/ComfyUI-models/Qwen3-TTS-Tokenizer-12Hz
    ln -sf ~/ComfyUI-models/Qwen3-TTS-Tokenizer-12Hz ~/ComfyUI/models/Qwen3-TTS/Qwen3-TTS-Tokenizer-12Hz
    hf download Qwen/Qwen3-TTS-12Hz-0.6B-Base --local-dir ~/ComfyUI-models/Qwen3-TTS-12Hz-0.6B-Base
    ln -sf ~/ComfyUI-models/Qwen3-TTS-12Hz-0.6B-Base ~/ComfyUI/models/Qwen3-TTS/Qwen3-12Hz-0.6B-Base
    hf download Qwen/Qwen3-TTS-12Hz-0.6B-CustomVoice --local-dir ~/ComfyUI-models/Qwen3-TTS-12Hz-0.6B-CustomVoice
    ln -sf ~/ComfyUI-models/Qwen3-TTS-12Hz-0.6B-CustomVoice ~/ComfyUI/models/Qwen3-TTS/Qwen3-TTS-12Hz-0.6B-CustomVoice
    mkdir -p ~/ComfyUI-models/whisper
    mkdir -p ~/ComfyUI/models/stt/whisper
    conda run -n comfyui -- python -c '
from pathlib import Path
from whisper import _download, _MODELS

_download(_MODELS["small"], str(Path("~/ComfyUI-models/whisper").expanduser()), False)
'
    ln -sf ~/ComfyUI-models/whisper/small.pt ~/ComfyUI/models/stt/whisper/small.pt

    # hf download Comfy-Org/Wan_2.1_ComfyUI_repackaged --include split_files/text_encoders --local-dir ~/ComfyUI/models
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
