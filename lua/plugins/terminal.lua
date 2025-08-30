return {
  {
    'nvzone/floaterm',
    dependencies = 'nvzone/volt',
    enabled = false,
    opts = {},
    cmd = 'FloatermToggle',
    keys = {
      { '<M-\\>', '<cmd>FloatermToggle<cr>', desc = 'Toggle Floaterm' },
    },
  },
  {
    'akinsho/toggleterm.nvim',
    enabled = true,
    event = 'VeryLazy',
    opts = {
      open_mapping = '<M-\\>',
      persist_size = false,
      persist_mode = true,
      direction = 'horizontal',
      size = function() return vim.o.lines * 0.5 end,
      float_opts = {
        border = 'rounded',
        winblend = 0,
        height = function() return math.ceil(vim.o.lines * 0.76) end,
        width = function() return math.ceil(vim.o.columns * 0.5) end,
      },
      highlights = {
        Normal = { link = 'Term' },
        NormalFloat = { link = 'Term' },
        WinBar = { link = 'Term' },
        WinBarActive = { bg = { from = 'Normal' } },
        WinBarInactive = { bg = { from = 'Normal' } },
        StatusLine = { link = 'StatusLineTerm' },
        CursorLine = { bg = 'none' },
        CursorLineSign = { bg = 'none' },
      },
      winbar = {
        enabled = true,
        name_formatter = function(term)
          -- term.name example: "/usr/bin/zsh;#toggleterm#1"
          local parts = vim.split(term.name, '#')

          local number = parts[#parts]
          local shell_path = parts[1]
          local shell_name = vim.fn.fnamemodify(shell_path, ':t')

          return string.format('#%s %s', number, shell_name)
        end,
      },
    },
  },
}
