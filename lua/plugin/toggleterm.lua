require("toggleterm").setup({
  open_mapping = "<C-\\>",
  direction = "horizontal",
  shade_terminals = false,
  shell = "zsh",
  size = 13,
  highlights = {
    Normal = {
      link = "StatusLine",
    },
    NormalFloat = {
      link = "Normal",
    },
  },
  on_open = function()
    vim.cmd("setlocal foldcolumn=0 | setlocal laststatus=0")
    vim.cmd("setlocal laststatus=0")
    vim.cmd("startinsert!")
  end,
  on_close = function()
    vim.cmd("setlocal foldcolumn=2 | setlocal laststatus=3")
  end,
})
