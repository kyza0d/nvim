--------------------------------------------
-- Editor's appearence
--------------------------------------------

return {
  -- Indent Lines
  --- @url https://github.com/lukas-reineke/indent-blankline.nvim
  {
    'lukas-reineke/indent-blankline.nvim',
    enabled = true,
    event = 'BufReadPost',
    init = function()
      vim.g.indent_blankline_char = '│'
      vim.g.indent_blankline_context_char = '│'
      vim.g.indent_blankline_filetype_exclude = { 'toggleterm', 'telescope' }
      vim.g.indent_blankline_show_trailing_blankline_indent = true
    end,
    opts = {
      show_current_context = true,
      show_current_context_start = false,
    },
  },

  {
    'glepnir/dashboard-nvim',
    enabled = false,
    event = 'VimEnter',
    config = function() require('config.dashboard') end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  },

  -- Filetype icons
  --- @url https://github.com/nvim-tree/nvim-web-devicons
  {
    'nvim-tree/nvim-web-devicons',
    config = function() require('config.devicons') end,
  },

  -- Render colors in files
  --- @url https://github.com/NvChad/nvim-colorizer.lua
  {
    'NvChad/nvim-colorizer.lua',
    -- event = 'BufReadPre',
    opts = {
      filetypes = { '*' },
      user_default_options = {
        mode = 'background', -- Set the display mode.
        names = false, -- "Name" codes like Blue or blue
      },
    },
  },

  -- Highlighted TODO comments
  --- @url https://github.com/folke/todo-comments.nvim
  {
    'folke/todo-comments.nvim',
    -- event = 'BufReadPost',
    opts = {
      keywords = {
        ROADMAP = { icon = ' ', color = 'warning' },
      },
    },
  },
}
