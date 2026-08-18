# local-llm-setup

This repo contains my local LLM setup.

Add to `~/.bashrc`:
```
export HF_TOKEN=<your_huggingface_token>
. "$HOME/.local-llm-setup/bashrc.sh"
```

## llama.cpp

The script uses CUDA backend.
```
./llama-cpp.sh
```

## Download Models

```
export HF_TOKEN=<your_huggingface_token>
./download-models.sh
```

## llama-swap

```
./llama-swap.sh
```

TODO model config from bashrc to llama swap, open notebook.
