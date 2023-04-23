return {
  open_mapping = "<C-\\>",
  shade_terminals = true,
  direction = "horizontal",
  size = function()
    return vim.o.lines * 0.4
  end,
  winbar = {
    enabled = true,
  },
  on_open = function()
    vim.cmd([[
      setlocal foldcolumn=0
      setlocal laststatus=0 
      setlocal statuscolumn=" "
      startinsert! 
    ]])
  end,
  on_close = function()
    vim.cmd([[
	     setlocal laststatus=3
	     " setlocal showtabline=2
	   ]])
  end,
}
