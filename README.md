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
./download.sh
```

### Aliases

```
source ~/.local-llm-setup/aliases.sh
```




bashrc

```
rm -rf ~/.local-llm-setup
git clone --depth=1 https://github.com/Willie169/local-llm-setup ~/.local-llm-setup
```

update

```
update_llm() {
  (
    cd ~/.local-llm-setup || exit
    git reset --hard
    git pull --rebase
    git clean -fd
  )
}
```
