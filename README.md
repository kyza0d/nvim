● Kyza's NeoVim

  A minimal yet powerful Neovim configuration focused on developer 
  productivity and notetaking.

  For full keybindings, check out /plugin/keymaps.lua and
  /lua/config/whichkey.lua.

  Installation

  1. Clone this repository into your Neovim config directory:
  git clone https://github.com/kyza0d/nvim ~/.config/nvim
  2. Start Neovim - lazy.nvim will automatically install all plugins:
  nvim

  Prerequisites

  - Neovim 0.9.0 or higher
  - A Nerd Font installed and configured in your terminal
  - Recommended tools: git, ripgrep, fd, npm/node

  Customization

  - Global configuration: lua/globals.lua and lua/options.lua
  - Plugin configuration: lua/plugins/*.lua
  - Keymaps: plugin/keymaps.lua
  - LSP servers: lua/servers.lua

  Credits

  Built with inspiration from:
  - https://github.com/akinsho/dotfiles/
  - https://github.com/MariaSolOs/dotfiles
  - https://github.com/folke/dot/
  - https://github.com/b0o/nvim-conf
  - https://github.com/glepnir/nvim
