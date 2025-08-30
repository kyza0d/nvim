--- author kyza0d
--- version 0.7.0
--- website https://kyza.dev

if vim.g.vscode then return end

require('globals')

require('editor.keymaps')
require('editor.options')
require('editor.autocmds')

package.path =
  fmt('%s/.luarocks/share/lua/5.1/?/init.lua;%s/.luarocks/share/lua/5.1/?.lua;', vim.fn.expand('$HOME'), vim.fn.expand('$HOME'))
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

require('lazy').setup({
  'nvim-lua/plenary.nvim',
  'neovim/nvim-lspconfig',
  {
    'echasnovski/mini.icons',
    config = function(_)
      require('mini.icons').setup(icons.mini)
      require('mini.icons').mock_nvim_web_devicons()
    end,
  },
  { import = 'plugins' },
  { import = 'plugins.editing' },
}, {
  rocks = {
    hererocks = true,
  },
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
  change_detection = {
    notify = false,
  },
})

opt.background = 'dark'

-- ky.pcall('theme failed to load because', vim.cmd.colorscheme, 'xeno-latte')
-- ky.pcall('theme failed to load because', vim.cmd.colorscheme, 'xeno-pink-haze')
ky.pcall('theme failed to load because', vim.cmd.colorscheme, 'xeno-lily-pad')
-- ky.pcall('theme failed to load because', vim.cmd.colorscheme, 'xeno-golden-hour')

require('editor.ui.statusline').init()
require('config.diagnostics').setup()

if vim.g.neovide then require('editor.ui.neovide') end

--- Based off of several configs 🫡
--- https://github.com/akinsho/dotfiles/
--- https://github.com/MariaSolOs/dotfiles
--- https://github.com/folke/dot/
--- https://github.com/b0o/nvim-conf
--- https://github.com/glepnir/nvim

--- Resources for finding plugins / inspiration
--- https://github.com/rockerBOO/awesome-neovim/blob/main/README.md
--- https://reddit.com/r/neovim
