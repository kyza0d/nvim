# Kyza's Neovim Config

A minimal, modular Neovim configuration with a focus on aesthetics and user experience.

## Features

- Modular configuration with lazy loading
- Custom statusline with context-aware information
- Elegant colorscheme based on Carbonfox with custom highlights
- Smart bufferline with grouping capabilities
- File explorer with Neo-tree
- Fuzzy finding with FZF
- LSP integration with completion and diagnostics
- Treesitter for better syntax highlighting
- Avante integration for AI assistance

## Requirements

- Neovim 0.9+
- A [Nerd Font](https://www.nerdfonts.com/) for icons
- Optional: Kitty terminal or Neovide GUI

## Key Mappings

### General

| Mapping | Mode | Description |
|---------|------|-------------|
| `<Space>` | Normal | Leader key |
| `<S-s>` | Normal | Save file |
| `<S-q>` | Normal | Close buffer |
| `<S-x>` | Normal | Delete buffer |
| `<C-h/j/k/l>` | Normal, Terminal | Navigate windows |
| `<C-S-h/j/k/l>` | Normal, Terminal | Resize windows |
| `<C-CR>` | Normal | Switch between last two buffers |
| `<C-v>` | Normal, Visual | Paste from clipboard |
| `<C-c>` | Visual | Copy to clipboard |
| `<M-\>` | Normal | Toggle terminal |

### File Navigation

| Mapping | Mode | Description |
|---------|------|-------------|
| `<c-f>` | Normal | Find files |
| `<c-g>` | Normal | Live grep |
| `<c-.>` | Normal | LSP code actions |
| `<leader>ff` | Normal | Git files |
| `<leader>fb` | Normal | Grep in current buffer |
| `<leader>fr` | Normal | Resume last search |
| `<M-e>` | Normal | Toggle Neo-tree |

### LSP

| Mapping | Mode | Description |
|---------|------|-------------|
| `gd` | Normal | Go to definition |
| `gD` | Normal | Go to type definition |
| `gr` | Normal | Find references |
| `<C-space>` | Normal | Show hover information |
| `<cr>d` | Normal | Toggle diagnostics |

### Buffer Navigation

| Mapping | Mode | Description |
|---------|------|-------------|
| `<S-l>` | Normal | Next buffer |
| `<S-h>` | Normal | Previous buffer |
| `!` | Normal | Go to buffer 1 |
| `@` | Normal | Go to buffer 2 |
| `#` | Normal | Go to buffer 3 |
| `<leader>bp` | Normal | Pin buffer |

### Editing

| Mapping | Mode | Description |
|---------|------|-------------|
| `<S-k>` | Normal | Toggle code block join/split |
| `s` | Visual | Surround selection |
| `<M-n>` | Normal | Find next occurrence of word under cursor |
| `<M-p>` | Normal | Find previous occurrence of word under cursor |
| `<M-h/l>` | Normal, Visual | Jump to start/end of line |
| `<M-o>` | Normal, Visual | Jump to matching bracket |

### Folding

| Mapping | Mode | Description |
|---------|------|-------------|
| `zh` | Normal | Toggle fold at cursor |
| `zl` | Normal | Toggle all nested folds at cursor |
| `zH` | Normal | Close all folds |
| `zL` | Normal | Open all folds |

## Plugins

This configuration includes a curated selection of plugins for enhanced productivity, including:

- lazy.nvim (plugin manager)
- neo-tree.nvim (file explorer)
- fzf-lua (fuzzy finder)
- nvim-treesitter (syntax)
- bufferline.nvim (tabline)
- gitsigns.nvim (git integration)
- lspconfig & mason.nvim (LSP)
- blink.cmp (completion)
- nvim-surround (text manipulation)
- avante.nvim (AI assistance)

## Structure

```
├── init.lua                  # Entry point
├── lua/
│   ├── globals.lua           # Global functions and variables
│   ├── ui.lua                # UI-related settings
│   ├── icons.lua             # Icon definitions
│   ├── options.lua           # Vim options
│   ├── config/               # Plugin configurations
│   ├── plugins/              # Plugin specifications
│   ├── statusline/           # Custom statusline
│   └── utils/                # Utility functions
└── plugin/                   # Plugin settings
```
