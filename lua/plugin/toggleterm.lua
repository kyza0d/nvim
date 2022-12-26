local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  hidden = true,
  direction = "tab",
  -- on_open = function()
  --   vim.cmd("set laststatus=0 | set showtabline=0 | startinsert!")
  -- end,
  -- on_close = function()
  --   vim.cmd("set laststatus=3 | set showtabline=2")
  -- end,
})

function _lazygit_toggle()
  lazygit:toggle()
end

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
  winbar = {
    enabled = true,
  },
})
