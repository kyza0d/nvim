--- author kyza0d
--- version 0.7.0
--- website https://kyza.dev

require('globals')

require('editor.keymaps')
require('editor.options')
require('editor.autocmds')
require('editor.ui.colors')

package.path = fmt('%s/.luarocks/share/lua/5.1/?/init.lua;%s/.luarocks/share/lua/5.1/?.lua;', vim.fn.expand('$HOME'), vim.fn.expand('$HOME'))
package.cpath = fmt('%s/.luarocks/lib/lua/5.1/?/so', vim.fn.expand('$HOME'))

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
if vim.env.NVIM then return require('lazy').setup({ {
  'willothy/flatten.nvim',
  config = true,
} }) end

require('lazy').setup({
  'nvim-lua/plenary.nvim',
  'neovim/nvim-lspconfig',
  { import = 'plugins' },
  { import = 'plugins.editing' },
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

ky.pcall('theme failed to load because', vim.cmd.colorscheme, 'carbonfox')
-- ky.pcall('theme failed to load because', vim.cmd.colorscheme, 'text-to-colorscheme')

require('editor.ui.statusline').init()

--- Based off of several configs 🫡
--- https://github.com/akinsho/dotfiles/
--- https://github.com/MariaSolOs/dotfiles
--- https://github.com/folke/dot/
--- https://github.com/b0o/nvim-conf
--- https://github.com/glepnir/nvim

--- Resources for finding plugins / inspiration
--- https://github.com/rockerBOO/awesome-neovim/blob/main/README.md
--- https://reddit.com/r/neovim

if vim.g.neovide then require('editor.ui.neovide') end
