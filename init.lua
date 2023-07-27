-- Personal Neovim configuration
--------------------------------------------
-- Author: <hi@kyza2.dev>
--- @url https://github.com/kyza2/nvim
--------------------------------------------

-- Inserpation taken from several configs
--------------------------------------------
--- @url https://github.com/akinsho/dotfiles/
--- @url https://github.com/folke/dot/
--- @url https://github.com/b0o/nvim-conf
--- @url https://github.com/glepnir/nvim
--------------------------------------------

-- Global namespace
require('globals')

-- Set leader to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set up plugin manager
--- @url https://github.com/folke/lazy.nvim

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

-- Clone lazy.nvim if it doesn't exist
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end

-- Add lazy.nvim to runtimepath
vim.opt.rtp:prepend(lazypath)

-- Lazy load plugins
require('lazy').setup(require('plugins'), {
  change_detection = {
    notify = false,
  },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      -- stylua: ignore
      disabled_plugins = {
        "gzip", 'netrw',"netrwPlugin",
        "rplugin", "tarPlugin",
        "tutor", "zipPlugin",
      },
    },
  },
  defaults = {
    lazy = true,
  },
  checker = {
    enabled = false,
  },
})

-- Load config
require('options')
require('keymaps')
require('autocmds')

-- Load colorscheme
vim.api.nvim_cmd({ cmd = 'colorscheme', args = { ky.load_cache('colorscheme', 'default') } }, {})

-- Disable shada
vim.opt.shadafile = 'NONE'
vim.opt.shadafile = ''
