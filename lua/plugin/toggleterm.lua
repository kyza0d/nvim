local status_ok, toggleterm = pcall(require, "toggleterm")

if not status_ok then
  return
end

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  hidden = true,
  direction = "tab",
  on_open = function()
    vim.cmd("set laststatus=0 | set showtabline=0 | startinsert!")
  end,
  on_close = function()
    vim.cmd("set laststatus=3 | set showtabline=2")
  end,
})

function _lazygit_toggle()
  lazygit:toggle()
end

toggleterm.setup({
  open_mapping = "<C-\\>",
  direction = "horizontal",
  shade_terminals = false,
  shell = "zsh",
  on_open = function()
    vim.cmd("set laststatus=0 | startinsert!")
  end,
  on_close = function()
    vim.cmd("set laststatus=3")
  end,
})
