return {
  {
    'akinsho/toggleterm.nvim',
    event = 'VeryLazy',
    opts = {
      open_mapping = '<M-\\>',
      persist_size = false,
      persist_mode = true,
      direction = 'float',
      size = function() return vim.o.lines * 0.5 end,
      float_opts = {
        border = 'none',
        winblend = 0,
        height = function() return vim.o.lines - 1 end,
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
    lazy = false,
    priority = 1001,
    config = {
      window = { open = 'alternate' },
      hooks = {
        block_end = function() require('toggleterm').toggle() end,
        post_open = function(_, winnr, _, is_blocking)
          if is_blocking then
            require('toggleterm').toggle()
          else
            api.nvim_set_current_win(winnr)
          end
        end,
      },
    },
  },
}
