--- Personal Neovim configurationini
--- @author kyza_
--- @version 0.0.1
--- @website kyza.dev

--- Based off of several configs 🫡
--- @url https://github.com/akinsho/dotfiles/
--- @url https://github.com/folke/dot/
--- @url https://github.com/b0o/nvim-conf
--- @url https://github.com/glepnir/nvim
--- @url https://github.com/MariaSolOs/dotfiles

package.path = package.path .. ';' .. vim.fn.expand('$HOME') .. '/.luarocks/share/lua/5.1/?/init.lua;'
package.path = package.path .. ';' .. vim.fn.expand('$HOME') .. '/.luarocks/share/lua/5.1/?.lua;'

if vim.g.vscode then return end

if vim.g.neovide then
  vim.g.transparency = 1.00
  vim.g.neovide_transparency = 1.00

  local alpha = function() return string.format('%x', math.floor(255 * (vim.g.transparency or 0.7))) end
  vim.g.neovide_background_color = '#0f1117' .. alpha()

  vim.g.neovide_refresh_rate = 144
  vim.g.neovide_scale_factor = 0.9

  vim.g.neovide_scroll_animation_length = 0.1

  vim.g.neovide_cursor_trail_size = 0.84
  vim.g.neovide_cursor_animation_length = 0.05
  vim.g.neovide_cursor_antialiasing = true

  vim.g.neovide_cursor_vfx_mode = 'pixiedust'
  vim.g.neovide_cursor_vfx_particle_density = 10.0

  vim.cmd([[
      set guicursor=n-c:block-Cursor
            \,v:block-CursorIM
            \,i-ci:ve-ver25-Cursor
            \,r-cr:block-rCursor
            \,o:hor50
            \,sm:block-blinkwait175-blinkoff150-blinkon175
  ]])
  -- vim.opt.guicursor = 'n-v-c-sm:hor80,i-ci-ve:hor25,r-cr-o:hor20'
end

-- Global namespace
require('globals')
reload('options')

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
  { import = 'plugins' },
  {
    --------------------------------------------
    -- ⚠️  Plugins in development
    --------------------------------------------

    {
      dir = '/home/kyza/Plugins/scratch.nvim',
      dependencies = { 'MunifTanjim/nui.nvim' },
      event = 'BufReadPre',
      opts = {
        default_width = 0.60, -- 30% of the window width
        default_height = 0.48, -- 40% of the window height
        position = {
          row = '83%',
          col = '90%',
        },
      },
    },

    -- -- Colorscheme manager
    {
      dir = '/home/kyza/Plugins/harmony.nvim/',
      config = function() require('config.harmony') end,
      event = 'ColorScheme',
      enabled = true,
    },

    { dir = '/home/kyza/Plugins/summer-time/' },
    { dir = '/home/kyza/Plugins/neowal/' },
  },
  -- Themes
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

require('neodev').setup({})

reload('keymaps')
reload('autocmds')
reload('servers')

require('utils.marks')

create_autocmd({ 'BufEnter' }, {
  callback = function()
    if vim.bo.filetype ~= 'neo-tree' then vim.o.statusline = "%{%v:lua.reload('config.statusline').render()%}" end
  end,
})

-- Load colorscheme
vim.cmd.colorscheme(ky.read_cache('colorscheme', 'default'))

-- -- Disable shada
vim.opt.shadafile = 'NONE'
vim.opt.shadafile = ''
