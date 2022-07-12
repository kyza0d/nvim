local status_ok, toggleterm = pcall(require, "toggleterm")

if not status_ok then
  return
end

toggleterm.setup({
  size = vim.o.lines * 0.6,
  shade_terminals = false,
  open_mapping = "<F2>",
  direction = "horizontal",
  shell = "zsh",
  hide_numbers = false,
  on_open = function()
    vim.cmd("startinsert!")
    vim.cmd([[
      set laststatus=0
      set signcolumn=no
      set nonumber
    ]])
  end,
  on_close = function()
    vim.cmd([[
      set laststatus=2
      set signcolumn=yes
      set number
    ]])
  end,
  float_opts = {
    winblend = 0,
  },
})

local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new({
  cmd = "lazygit",
  direction = "tab",
  on_open = function()
    vim.cmd([[
      set showtabline=0
      set laststatus=0
      set signcolumn=no
      set nonumber
    ]])
  end,
  on_exit = function()
    vim.cmd([[:NvimTreeRefresh]])
    vim.cmd([[
      set showtabline=2
      set laststatus=2
      set signcolumn=yes
      set number
    ]])
  end,
})

function lazygit_toggle()
  lazygit:toggle()
end
