#!/usr/bin/env bash

export HF_HOME="$HOME/hf-models"

update_llm() {
  (
    cd ~/.local-llm-setup || exit
    git reset --hard
    git pull --rebase
    git clean -fd
  )
}

alias cli-qwen3.5-9b-think='CUDA_SCALE_LAUNCH_QUEUES=4x GGML_CUDA_ENABLE_UNIFIED_MEMORY=1 llama cli -hf unsloth/Qwen3.5-9B-GGUF:Q4_K_M --temp 1.0 --top-p 0.95 --top-k 20 --min-p 0.0 --presence-penalty 1.5 --repeat-penalty 1.0'
alias serve-qwen3.5-9b-think='CUDA_SCALE_LAUNCH_QUEUES=4x GGML_CUDA_ENABLE_UNIFIED_MEMORY=1 llama serve -hf unsloth/Qwen3.5-9B-GGUF:Q4_K_M --temp 1.0 --top-p 0.95 --top-k 20 --min-p 0.0 --presence-penalty 1.5 --repeat-penalty 1.0'
alias cli-qwen3.5-9b-think-code='CUDA_SCALE_LAUNCH_QUEUES=4x GGML_CUDA_ENABLE_UNIFIED_MEMORY=1 llama cli -hf unsloth/Qwen3.5-9B-GGUF:Q4_K_M --temp 0.6 --top-p 0.95 --top-k 20 --min-p 0.0 --presence-penalty 0.0 --repeat-penalty 1.0'
alias serve-qwen3.5-9b-think-code='CUDA_SCALE_LAUNCH_QUEUES=4x GGML_CUDA_ENABLE_UNIFIED_MEMORY=1 llama serve -hf unsloth/Qwen3.5-9B-GGUF:Q4_K_M --temp 0.6 --top-p 0.95 --top-k 20 --min-p 0.0 --presence-penalty 0.0 --repeat-penalty 1.0'
alias cli-qwen3.5-9b-instruct='CUDA_SCALE_LAUNCH_QUEUES=4x GGML_CUDA_ENABLE_UNIFIED_MEMORY=1 llama cli -hf unsloth/Qwen3.5-9B-GGUF:Q4_K_M --temp 0.7 --top-p 0.8 --top-k 20 --min-p 0.0 --presence-penalty 1.5 --repeat-penalty 1.0'
alias serve-qwen3.5-9b-instruct='CUDA_SCALE_LAUNCH_QUEUES=4x GGML_CUDA_ENABLE_UNIFIED_MEMORY=1 llama serve -hf unsloth/Qwen3.5-9B-GGUF:Q4_K_M --temp 0.7 --top-p 0.8 --top-k 20 --min-p 0.0 --presence-penalty 1.5 --repeat-penalty 1.0'
alias cli-qwen3.5-9b-instruct-rea='CUDA_SCALE_LAUNCH_QUEUES=4x GGML_CUDA_ENABLE_UNIFIED_MEMORY=1 llama cli -hf unsloth/Qwen3.5-9B-GGUF:Q4_K_M --temp 1.0 --top-p 1.0 --top-k 40 --min-p 0.0 --presence-penalty 2.0 --repeat-penalty 1.0'
alias serve-qwen3.5-9b-instruct-rea='CUDA_SCALE_LAUNCH_QUEUES=4x GGML_CUDA_ENABLE_UNIFIED_MEMORY=1 llama serve -hf unsloth/Qwen3.5-9B-GGUF:Q4_K_M --temp 1.0 --top-p 1.0 --top-k 40 --min-p 0.0 --presence-penalty 2.0 --repeat-penalty 1.0'
alias cli-qwen3.5-4b-think='CUDA_SCALE_LAUNCH_QUEUES=4x GGML_CUDA_ENABLE_UNIFIED_MEMORY=1 llama cli -hf unsloth/Qwen3.5-4B-GGUF:Q4_K_M --temp 1.0 --top-p 0.95 --top-k 20 --min-p 0.0 --presence-penalty 1.5 --repeat-penalty 1.0'
alias serve-qwen3.5-4b-think='CUDA_SCALE_LAUNCH_QUEUES=4x GGML_CUDA_ENABLE_UNIFIED_MEMORY=1 llama serve -hf unsloth/Qwen3.5-4B-GGUF:Q4_K_M --temp 1.0 --top-p 0.95 --top-k 20 --min-p 0.0 --presence-penalty 1.5 --repeat-penalty 1.0'
alias cli-qwen3.5-4b-think-code='CUDA_SCALE_LAUNCH_QUEUES=4x GGML_CUDA_ENABLE_UNIFIED_MEMORY=1 llama cli -hf unsloth/Qwen3.5-4B-GGUF:Q4_K_M --temp 0.6 --top-p 0.95 --top-k 20 --min-p 0.0 --presence-penalty 0.0 --repeat-penalty 1.0'
alias serve-qwen3.5-4b-think-code='CUDA_SCALE_LAUNCH_QUEUES=4x GGML_CUDA_ENABLE_UNIFIED_MEMORY=1 llama serve -hf unsloth/Qwen3.5-4B-GGUF:Q4_K_M --temp 0.6 --top-p 0.95 --top-k 20 --min-p 0.0 --presence-penalty 0.0 --repeat-penalty 1.0'
alias cli-qwen3.5-4b-instruct='CUDA_SCALE_LAUNCH_QUEUES=4x GGML_CUDA_ENABLE_UNIFIED_MEMORY=1 llama cli -hf unsloth/Qwen3.5-4B-GGUF:Q4_K_M --temp 0.7 --top-p 0.8 --top-k 20 --min-p 0.0 --presence-penalty 1.5 --repeat-penalty 1.0'
alias serve-qwen3.5-4b-instruct='CUDA_SCALE_LAUNCH_QUEUES=4x GGML_CUDA_ENABLE_UNIFIED_MEMORY=1 llama serve -hf unsloth/Qwen3.5-4B-GGUF:Q4_K_M --temp 0.7 --top-p 0.8 --top-k 20 --min-p 0.0 --presence-penalty 1.5 --repeat-penalty 1.0'
alias cli-qwen3.5-4b-instruct-rea='CUDA_SCALE_LAUNCH_QUEUES=4x GGML_CUDA_ENABLE_UNIFIED_MEMORY=1 llama cli -hf unsloth/Qwen3.5-4B-GGUF:Q4_K_M --temp 1.0 --top-p 1.0 --top-k 40 --min-p 0.0 --presence-penalty 2.0 --repeat-penalty 1.0'
alias serve-qwen3.5-4b-instruct-rea='CUDA_SCALE_LAUNCH_QUEUES=4x GGML_CUDA_ENABLE_UNIFIED_MEMORY=1 llama serve -hf unsloth/Qwen3.5-4B-GGUF:Q4_K_M --temp 1.0 --top-p 1.0 --top-k 40 --min-p 0.0 --presence-penalty 2.0 --repeat-penalty 1.0'
alias cli-qwen3.5-2b-non-think-text='CUDA_SCALE_LAUNCH_QUEUES=4x GGML_CUDA_ENABLE_UNIFIED_MEMORY=1 llama cli -hf unsloth/Qwen3.5-2B-GGUF:Q4_K_M --temp 1.0 --top-p 1.0 --top-k 20 --min-p 0.0 --presence-penalty 2.0 --repeat-penalty 1.0'
alias serve-qwen3.5-2b-non-think-text='CUDA_SCALE_LAUNCH_QUEUES=4x GGML_CUDA_ENABLE_UNIFIED_MEMORY=1 llama serve -hf unsloth/Qwen3.5-2B-GGUF:Q4_K_M --temp 1.0 --top-p 1.0 --top-k 20 --min-p 0.0 --presence-penalty 2.0 --repeat-penalty 1.0'
alias cli-qwen3.5-2b-non-think-vl='CUDA_SCALE_LAUNCH_QUEUES=4x GGML_CUDA_ENABLE_UNIFIED_MEMORY=1 llama cli -hf unsloth/Qwen3.5-2B-GGUF:Q4_K_M --temp 0.7 --top-p 0.8 --top-k 20 --min-p 0.0 --presence-penalty 1.5 --repeat-penalty 1.0'
alias serve-qwen3.5-2b-non-think-vl='CUDA_SCALE_LAUNCH_QUEUES=4x GGML_CUDA_ENABLE_UNIFIED_MEMORY=1 llama serve -hf unsloth/Qwen3.5-2B-GGUF:Q4_K_M --temp 0.7 --top-p 0.8 --top-k 20 --min-p 0.0 --presence-penalty 1.5 --repeat-penalty 1.0'
alias cli-qwen3.5-2b-think='CUDA_SCALE_LAUNCH_QUEUES=4x GGML_CUDA_ENABLE_UNIFIED_MEMORY=1 llama cli -hf unsloth/Qwen3.5-2B-GGUF:Q4_K_M --temp 1.0 --top-p 0.95 --top-k 20 --min-p 0.0 --presence-penalty 1.5 --repeat-penalty 1.0'
alias serve-qwen3.5-2b-think='CUDA_SCALE_LAUNCH_QUEUES=4x GGML_CUDA_ENABLE_UNIFIED_MEMORY=1 llama serve -hf unsloth/Qwen3.5-2B-GGUF:Q4_K_M --temp 1.0 --top-p 0.95 --top-k 20 --min-p 0.0 --presence-penalty 1.5 --repeat-penalty 1.0'
alias cli-qwen3.5-2b-think-code='CUDA_SCALE_LAUNCH_QUEUES=4x GGML_CUDA_ENABLE_UNIFIED_MEMORY=1 llama cli -hf unsloth/Qwen3.5-2B-GGUF:Q4_K_M --temp 0.6 --top-p 0.95 --top-k 20 --min-p 0.0 --presence-penalty 0.0 --repeat-penalty 1.0'
alias serve-qwen3.5-2b-think-code='CUDA_SCALE_LAUNCH_QUEUES=4x GGML_CUDA_ENABLE_UNIFIED_MEMORY=1 llama serve -hf unsloth/Qwen3.5-2B-GGUF:Q4_K_M --temp 0.6 --top-p 0.95 --top-k 20 --min-p 0.0 --presence-penalty 0.0 --repeat-penalty 1.0'
