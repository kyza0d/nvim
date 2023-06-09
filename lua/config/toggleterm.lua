return {
  open_mapping = "<C-\\>",
  shade_terminals = true,
  direction = "horizontal",
  size = function()
    return vim.o.lines * 0.50 -- 60% of terminal
  end,
  winbar = {
    enabled = true,
  },
  on_open = function()
    vim.opt_local.foldcolumn = "0"
    vim.opt_local.statuscolumn = ""
  end,
  on_close = function()
    vim.opt_local.laststatus = 3
  end,
}
