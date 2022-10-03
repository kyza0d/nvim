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

require("toggleterm").setup({
  open_mapping = "<C-\\>",
  direction = "horizontal",
  shade_terminals = true,
  shell = "zsh",
  -- size = vim.api.nvim_win_get_height(0) * 0.4,
  size = 13,
  on_open = function()
    vim.cmd("set laststatus=0 | startinsert!")
  end,
  on_close = function()
    vim.cmd("set laststatus=3")
  end,
})
