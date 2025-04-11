--- author kyza0d
--- version 0.7.0
--- website https://kyza.dev

require('globals')
require('ui')
require('options')
require('icons')

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if vim.g.vscode then return end

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

vim.opt.rtp:prepend(lazypath)
if vim.env.NVIM then return require('lazy').setup({ { 'willothy/flatten.nvim', config = true } }) end

require('lazy').setup({
  { import = 'plugins' },
}, {
  change_detection = { notify = false },
  performance = {
    cache = { enabled = true },
    defaults = { lazy = true },
    checker = { enabled = false },
    rtp = {
      -- stylua: ignore
      disabled_plugins = {
        "gzip", 'netrw',"netrwPlugin",
        "rplugin", "tarPlugin",
        "tutor", "zipPlugin",
      },
    },
  },
  rocks = {
    hererocks = true,
  },
})

opt.background = 'dark'
-- lunaperche
-- carbonfox
-- dayfox
ky.pcall('theme failed to load because', vim.cmd.colorscheme, 'carbonfox')

if vim.g.neovide then require('config.neovide') end

require('statusline').init()

--- Based off of several configs 🫡
--- https://github.com/akinsho/dotfiles/
--- https://github.com/MariaSolOs/dotfiles
--- https://github.com/folke/dot/
--- https://github.com/b0o/nvim-conf
--- https://github.com/glepnir/nvim
--- Resources for finding plugins / inspiration
--- https://github.com/rockerBOO/awesome-neovim/blob/main/README.md
--- https://reddit.com/r/neovim
