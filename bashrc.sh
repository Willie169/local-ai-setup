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

update_comfyui() {
  (
    cd ~/ComfyUI || exit
    git reset --hard
    git pull --rebase
    git clean -fd
    cd ~/ComfyUI/custom_nodes || exit
    shopt -s nullglob
    for d in *; do
      test -d ~/ComfyUI/"$d/.git" || continue
      cd ~/ComfyUI/"$d" || continue
      git reset --hard
      git pull --rebase
      git clean -fd
    done
    cd ~/ComfyUI || exit
    conda env update -f user/environment.yml --prune
  )
}
