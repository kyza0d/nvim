--- Personal Neovim configuration

--------------------------------------------
--- @url https://github.com/kyza2k/nvim
--------------------------------------------

--- Inserpation taken from several configs
--------------------------------------------
--- @url https://github.com/akinsho/dotfiles/
--- @url https://github.com/folke/dot/
--- @url https://github.com/b0o/nvim-conf
--- @url https://github.com/glepnir/nvim
--------------------------------------------

if vim.g.neovide then
  vim.g.disable_icons = true

  vim.g.neovide_transparency = 0.92
  vim.g.transparency = 0.92

  local alpha = function() return string.format('%x', math.floor(255 * vim.g.transparency or 0.7)) end
  vim.g.neovide_background_color = '#0f1117' .. alpha()

  vim.g.neovide_refresh_rate = 120
  vim.g.neovide_scale_factor = 0.9

  vim.g.neovide_scroll_animation_length = 0.5

  vim.g.neovide_cursor_trail_size = 0.83
  vim.g.neovide_cursor_animation_length = 0.02
  vim.g.neovide_cursor_antialiasing = true
end

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
require('lazy').setup({
  require('plugins.appearence'),
  require('plugins.completion'),
  require('plugins.widgets'),
  require('plugins.editor'),
  require('plugins.git'),
  require('plugins.lsp'),
  require('plugins.motions'),
  require('plugins.pickers'),
  require('plugins.syntax'),
  require('plugins.themes'),
  require('plugins.tools'),

  -- Discord Rich Presence
  --- @url https://github.com/andweeb/presence.nvim
  {
    'andweeb/presence.nvim',
    event = 'BufReadPre',
    opts = {
      auto_update = true,
    },

    enabled = false,
  },

  {
    --------------------------------------------
    -- ⚠️  Plugins in development
    --------------------------------------------

    -- Themes
    { dir = '/home/kyza/Plugins/summer-time/', lazy = false },
    { dir = '/home/kyza/Plugins/byte-theme/', lazy = false },
    { dir = '/home/kyza/Plugins/neowal/', lazy = false },
    { dir = '/home/kyza/Plugins/byte-theme/', lazy = false },

    -- Terminal Emulation
    {
      dir = '/home/kyza/Plugins/vortex.nvim/',
      config = function() require('vortex').setup({}) end,
      lazy = false,
      enabled = false,
    },

    -- Colorscheme manager
    {
      dir = '/home/kyza/Plugins/harmony.nvim/',
      config = function() require('config.harmony') end,
      -- event = 'VeryLazy',
      lazy = false,
      enabled = true,
    },

    -- Color utilities
    {
      dir = '/home/evan/Plugins/color-space.nvim/',
      config = function() require('config.color-space') end,
      enabled = false,
    },
  },
}, {
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
require('servers')

require('persistence').load()

-- Load colorscheme
vim.api.nvim_cmd({ cmd = 'colorscheme', args = { ky.load_cache('colorscheme', 'default') } }, {})

-- Disable shada
vim.opt.shadafile = 'NONE'
vim.opt.shadafile = ''
