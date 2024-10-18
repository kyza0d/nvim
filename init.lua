--- author kyza0d
--- version 0.0.0
--- website https://kyza.dev

require('globals')

require('ui')
require('options')
require('icons')

package.path = fmt('%s/.luarocks/share/lua/5.1/?/init.lua;%s/.luarocks/share/lua/5.1/?.lua;', vim.fn.expand('$HOME'), vim.fn.expand('$HOME'))

package.cpath = fmt('%s/.luarocks/lib/lua/5.1/?/so', vim.fn.expand('$HOME'))

-- Set leader to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set up plugin manager
--- @url https://github.com/folke/lazy.nvim

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if vim.g.vscode then return end

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

-- If opening from inside neovim terminal then do not load other plugins
if vim.env.NVIM then return require('lazy').setup({ { 'willothy/flatten.nvim', config = true } }) end

-- Lazy load plugins
require('lazy').setup({
  { import = 'plugins' },
  {
    { 'andweeb/presence.nvim', event = 'BufRead', opts = {}, enabled = false },
    { dir = '/home/kyza/Plugins/themes/summer-time/' },
    { dir = '~/Plugins/themes/ashes.nvim', version = '*' },
    { dir = '/home/kyza/Plugins/themes/neowal/', opts = {} },
  },
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
})

require('keymaps')
require('autocmds')
require('lsp')

-- Unique config for neovide
if vim.g.neovide then require('neovide') end

opt.background = 'dark'
-- ky.pcall('theme failed to load because', vim.cmd.colorscheme, 'caret')
-- ky.pcall('theme failed to load because', vim.cmd.colorscheme, 'dawnfox')
ky.pcall('theme failed to load because', vim.cmd.colorscheme, 'text-to-colorscheme')

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
