# local-llm-setup

This repo contains my local LLM setup.

## llama.cpp

TODO

### Runtime

```
CUDA_SCALE_LAUNCH_QUEUES=4x GGML_CUDA_ENABLE_UNIFIED_MEMORY=1
```

## Download

```
mkdir ~/hf-models
```
Put to `~/.bashrc`:
```
export HF_HOME="$HOME/hf-models"
```

```
export HF_HOME="$HOME/hf-models"
hf download unsloth/Qwen3.5-9B-GGUF Qwen3.5-9B-Q4_K_M.gguf
hf download unsloth/Qwen3.5-9B-GGUF mmproj-F16.gguf
hf download unsloth/Qwen3.5-4B-GGUF Qwen3.5-4B-Q4_K_M.gguf
hf download unsloth/Qwen3.5-4B-GGUF mmproj-F16.gguf
hf download unsloth/Qwen3.5-2B-GGUF Qwen3.5-2B-Q4_K_M.gguf
hf download unsloth/Qwen3.5-2B-GGUF mmproj-F16.gguf
hf download unsloth/gemma-4-12B-it-qat-GGUF gemma-4-12B-it-qat-UD-Q4_K_XL.gguf
hf download unsloth/gemma-4-12B-it-qat-GGUF mmproj-F16.gguf
hf download unsloth/gemma-4-E4B-it-qat-GGUF gemma-4-E4B-it-qat-UD-Q4_K_XL.gguf
hf download unsloth/gemma-4-E4B-it-qat-GGUF mmproj-F16.gguf
hf download unsloth/gemma-4-E2B-it-qat-GGUF gemma-4-E2B-it-qat-UD-Q4_K_XL.gguf
hf download unsloth/gemma-4-E2B-it-qat-GGUF mmproj-F16.gguf
```

### Aliases

```
alias qwen-think-cli='CUDA_SCALE_LAUNCH_QUEUES=4x GGML_CUDA_ENABLE_UNIFIED_MEMORY=1 llama cli -hf unsloth/Qwen3.8-27B-GGUF:Q4_K_M --temp 1.0 --top-p 0.95 --top-k 20 --min-p 0.0 --presence-penalty 0.0 --repeat-penalty 1.0 -rea on'

alias qwen-think-serve='CUDA_SCALE_LAUNCH_QUEUES=4x GGML_CUDA_ENABLE_UNIFIED_MEMORY=1 llama serve -hf unsloth/Qwen3.8-27B-GGUF:Q4_K_M --temp 1.0 --top-p 0.95 --top-k 20 --min-p 0.0 --presence-penalty 0.0 --repeat-penalty 1.0 -rea on'
alias qwen-nothink-cli='CUDA_SCALE_LAUNCH_QUEUES=4x GGML_CUDA_ENABLE_UNIFIED_MEMORY=1 llama cli -hf unsloth/Qwen3.8-27B-GGUF:Q4_K_M --temp 0.7 --top-p 0.80 --top-k 20 --min-p 0.0 --presence-penalty 1.5 --repeat-penalty 1.0 -rea off'
alias qwen-nothink-serve='CUDA_SCALE_LAUNCH_QUEUES=4x GGML_CUDA_ENABLE_UNIFIED_MEMORY=1 llama serve -hf unsloth/Qwen3.8-27B-GGUF:Q4_K_M --temp 0.7 --top-p 0.80 --top-k 20 --min-p 0.0 --presence-penalty 1.5 --repeat-penalty 1.0 -rea off'
```
