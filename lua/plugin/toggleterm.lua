require("toggleterm").setup({
  open_mapping = "<C-\\>",
  direction = "horizontal",
  shade_terminals = false,
  shell = "zsh",
  size = 13,
  highlights = {
    Normal = {
      link = "Normal",
    },
    NormalFloat = {
      link = "Normal",
    },
  },
  on_open = function()
    vim.cmd("setlocal laststatus=0 | setlocal foldcolumn=0 | startinsert!")
  end,
  on_close = function()
    vim.cmd("set laststatus=3")
  end,
})
