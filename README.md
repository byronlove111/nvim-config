# nvim-config

Neovim configuration built on lazy.nvim. No LazyVim framework. Clean and minimal.

## Features

- Plugin manager: lazy.nvim
- Theme: Catppuccin Mocha
- AI chat: codecompanion.nvim (configured for local LLM via llama.cpp)
- Inline AI suggestions: Supermaven
- LSP: clangd (C/C++), ts_ls (JS/TS), pyright (Python), lua_ls
- Formatter: conform.nvim (clang-format, prettier, black, stylua)
- Linter: nvim-lint
- File explorer: neo-tree
- Fuzzy finder: telescope.nvim
- Syntax highlighting: nvim-treesitter

## Requirements

```bash
# macOS
brew install neovim git curl ripgrep fd node lazygit

# Ubuntu/Debian
sudo apt install neovim git curl ripgrep fd-find nodejs npm unzip
```

Neovim 0.10 or later is required.

## Installation

```bash
# Backup existing config if needed
mv ~/.config/nvim ~/.config/nvim.bak

# Clone
git clone https://github.com/byronlove111/nvim-config ~/.config/nvim

# Launch nvim — plugins install automatically
nvim
```

On first launch, lazy.nvim installs all plugins and Mason installs the LSP servers. Wait for it to finish, then restart nvim.

## AI with local LLM (optional)

This config uses [codecompanion.nvim](https://github.com/olimorris/codecompanion.nvim) pointed at a local llama.cpp server on `http://127.0.0.1:8080`.

Example server startup script for Qwen2.5-Coder via llama.cpp:

```bash
#!/bin/bash

MODEL_PATH="$HOME/models/qwen-coder-7b/qwen2.5-coder-7b-instruct-q5_k_m.gguf"
PORT=8080
CONTEXT_SIZE=16384
GPU_LAYERS=99

llama-server \
  -m "$MODEL_PATH" \
  --port $PORT \
  -ngl $GPU_LAYERS \
  -c $CONTEXT_SIZE \
  --host 127.0.0.1 \
  --metrics
```

Start the server before opening nvim, then use `<leader>aa` to open the chat.

To use a different model, update `plugins/codecompanion.lua` with your endpoint and model name.

## Key mappings

Leader key is `Space`.

| Key | Action |
|-----|--------|
| `Space aa` | Toggle AI chat |
| `Space ai` | Inline AI assistant |
| `Space e` | File explorer |
| `Space ff` | Find files |
| `Space fg` | Live grep |
| `Space us` | Toggle Supermaven suggestions |
| `gd` | Go to definition |
| `K` | Hover documentation |
| `Space ca` | Code actions |
| `Space rn` | Rename symbol |
