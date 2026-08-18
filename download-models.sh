#!/usr/bin/env bash

export HF_HOME="$HOME/hf-models"
hf download unsloth/Qwen3.5-9B-GGUF Qwen3.5-9B-Q4_K_M.gguf
hf download unsloth/Qwen3.5-9B-GGUF mmproj-BF16.gguf
hf download unsloth/Qwen3.5-4B-GGUF Qwen3.5-4B-Q4_K_M.gguf
hf download unsloth/Qwen3.5-4B-GGUF mmproj-BF16.gguf
hf download unsloth/Qwen3.5-2B-GGUF Qwen3.5-2B-Q4_K_M.gguf
hf download unsloth/Qwen3.5-2B-GGUF mmproj-BF16.gguf
hf download unsloth/gemma-4-12B-it-qat-GGUF gemma-4-12B-it-qat-UD-Q4_K_XL.gguf
hf download unsloth/gemma-4-12B-it-qat-GGUF mmproj-BF16.gguf
hf download unsloth/gemma-4-E4B-it-qat-GGUF gemma-4-E4B-it-qat-UD-Q4_K_XL.gguf
hf download unsloth/gemma-4-E4B-it-qat-GGUF mmproj-BF16.gguf
hf download unsloth/gemma-4-E2B-it-qat-GGUF gemma-4-E2B-it-qat-UD-Q4_K_XL.gguf
hf download unsloth/gemma-4-E2B-it-qat-GGUF mmproj-BF16.gguf
