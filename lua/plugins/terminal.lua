local ui = ky.ui

return {
  {
    'akinsho/toggleterm.nvim',
    event = 'VeryLazy',
    opts = {
      open_mapping = '<M-\\>',
      persist_size = false,
      persist_mode = true,
      direction = 'horizontal',
      size = function() return vim.o.lines * 0.5 end,
      float_opts = {
        border = ky.ui.border.solid,
        winblend = 0,
        height = function() return vim.o.lines - 3 end,
        width = function() return vim.o.columns end,
        row = 0,
        col = 0,
      },
      highlights = {
        NormalFloat = { link = 'Term' },
        FloatBorder = { link = 'TermBorder' },
      },
      winbar = {
        enabled = true,
        name_formatter = function(term) return term.name end,
      },
    },
  },
  {
    'willothy/flatten.nvim',
    priority = 1001,
    lazy = false,
    config = {
      window = { open = 'alternate' },
      callbacks = {
        block_end = function() require('toggleterm').toggle() end,
      },
    },
  },
}
