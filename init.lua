-------------------------------------------------------------------------
-- Author: <hi@kyza2.dev>
-- URL: https://github.com/kyza2/nvim
-------------------------------------------------------------------------

-- Inserpation taken from several configs
-----------------------------------------------------------------
-- https://github.com/akinsho/dotfiles/tree/main/.config/nvim
-- https://github.com/folke/dot/tree/master/nvim
-- https://github.com/b0o/nvim-conf
-- https://github.com/glepnir/nvim
-----------------------------------------------------------------

-- Global namespace
require('globals')

-- Set leader as Space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

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

create_autocmd({ 'BufEnter' }, {
  callback = function()
    if vim.bo.filetype ~= 'neo-tree' then vim.o.statusline = "%{%v:lua.require('statusline').active()%}" end
  end,
})

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
        "gzip", "netrwPlugin",
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

require('options')
require('keymaps')
require('autocmds')

require('utils.colorscheme').apply()

vim.opt.shadafile = 'NONE'
vim.opt.shadafile = ''
