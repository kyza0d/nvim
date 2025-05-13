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
        border = 'none',
        winblend = 0,
        height = function() return vim.o.lines end,
        width = function() return vim.o.columns end,
      },
      highlights = {
        Normal = { link = 'PanelBackground' },
        NormalFloat = { link = 'PanelBackground' },
      },
      winbar = {
        enabled = false,
        name_formatter = function(term) return term.name end,
      },
    },
  },
}
