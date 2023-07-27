return {
  --------------------------------------------
  -- Editor appearance
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
