return {
  open_mapping = '<C-\\>',
  shade_terminals = false,
  direction = 'horizontal',
  size = function()
    return vim.o.lines * 0.30 -- 30% of terminal
  end,
  on_open = function()
    vim.opt_local.statuscolumn = ''
    vim.opt_local.cursorline = false
  end,
  -- on_close = function() vim.opt_local.laststatus = 3 end,
}
