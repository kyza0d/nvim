--------------------------------------------
-- Motions / Keystrokes
--------------------------------------------

return {
  -- Keystroke-based commands
  --- @url https://github.com/folke/which-key.nvim
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function() require('config.whichkey') end,
  },

  -- Surround motions
  --- @url https://github.com/kylechui/nvim-surround
  {
    'kylechui/nvim-surround',
    config = function() require('nvim-surround').setup({}) end,
    event = 'VeryLazy',
  },

  -- Align motions
  --- @url https://github.com/Vonr/align.nvim
  'Vonr/align.nvim',

  --------------------------------------------
  -- UI, Appearance
  --------------------------------------------

  -- Distraction-free writing
  --- @url https://github.com/Pocco81/true-zen.nvim
  {
    'Pocco81/true-zen.nvim',
    opts = {
      modes = {
        minimalist = {
          options = {
            statuscolumn = '  ',
            cmdheight = 0,
          },
        },
      },
    },
    event = 'VeryLazy',
  },

  -- Indent Lines
  --- @url https://github.com/lukas-reineke/indent-blankline.nvim
  {
    'lukas-reineke/indent-blankline.nvim',
    enabled = false,
    event = 'BufReadPost',
    init = function()
      vim.g.indent_blankline_char = icons.editor.indent
      vim.g.indent_blankline_context_char = icons.editor.indent
      vim.g.indent_blankline_filetype_exclude = { 'toggleterm', 'telescope' }
      vim.g.indent_blankline_show_trailing_blankline_indent = true
    end,
    opts = {
      show_current_context = true,
      show_current_context_start = false,
    },
  },

  -- Show LSP progress
  --- @url https://github.com/j-hui/fidget.nvim
  {
    'j-hui/fidget.nvim',
    event = 'BufReadPost',
    opts = {
      window = {
        blend = 0,
      },
      text = { spinner = 'dots_ellipsis' },
    },
  },

  -- Filetype icons
  --- @url https://github.com/nvim-tree/nvim-web-devicons
  {
    'nvim-tree/nvim-web-devicons',
    enabled = true,
    config = function() require('config.devicons') end,
  },

  -- Render colors in files
  --- @url https://github.com/NvChad/nvim-colorizer.lua
  {
    'NvChad/nvim-colorizer.lua',
    event = 'BufReadPre',
    opts = {
      filetypes = { '*' },
      user_default_options = {
        mode = 'background', -- Set the display mode.
        names = false, -- "Name" codes like Blue or blue
      },
    },
  },
}
