local M = {}

local options = {
  -- Appearance
  relativenumber = false,
  number = true,
  numberwidth = 5,
  cursorline = false,
  signcolumn = "yes",
  laststatus = 3,
  cmdheight = 0,
  pumheight = 12,
  showmode = false,
  termguicolors = true,
  scrolloff = 6,
  -- statuscolumn = '%=%l %s%#FoldColumn#%{foldlevel(v:lnum) > 0 ? (foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? "󰅀 " : "󰅂 ") : "🭱 ") : "  " }',
  statuscolumn = '%=%l %s%{foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? "󰅀 " : "󰅂 ") : "  " }',

  -- Indenting
  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  autoindent = true,
  breakindent = true,
  breakindentopt = "shift:4",
  wrap = true,
  linebreak = false,

  -- Folding
  foldenable = true,
  foldlevel = 99,
  foldlevelstart = 99,
  foldcolumn = "2",
  foldnestmax = 2,

  -- Searching
  ignorecase = true,
  smartcase = true,

  -- Memory and file
  shell = "/usr/bin/zsh",
  hidden = true,
  lazyredraw = true,
  swapfile = false,
  backup = false,

  -- Update times
  timeoutlen = 400,
  updatetime = 200,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.fillchars:append({
  vert = " ",
  vertright = "▏",
  fold = " ",
  foldclose = "",
  foldopen = "",
  foldsep = " ",
  vertleft = "┤",
  eob = " ",
  horiz = "─",
})

M.icons = {
  file = " ",
  book = " ",
  book_alt = "",
  error = " ",
  warning = " ",
  hint = " ",
  info = " ",
  chevron = "  ",
  keyboard = "",
  folder_closed = "󰅂 󰉋",
  folder_open = "󰅀 󰉋",
  folder_empty = "󰅀 󰉖",
  folder = "󰉋 ",
  git_branch = "",
  indent_marker = "🭱",
  last_indent_marker = "🭱",
  -- indent_marker = "│",
  -- last_indent_marker = "└",
}

M.cmp = {
  Class = " ",
  Color = " ",
  Constant = " ",
  Constructor = " ",
  Enum = "練",
  EnumMember = " ",
  Event = " ",
  Field = " ",
  File = " ",
  Folder = " ",
  Function = " ",
  Interface = "ﰮ ",
  Keyword = " ",
  Method = " ",
  Module = " ",
  Array = " ",
  Operator = "",
  Property = " ",
  Reference = " ",
  Snippet = " ",
  Struct = " ",
  Text = "料",
  TypeParameter = " ",
  Unit = "塞",
  Value = " ",
  Variable = " ",
  Dictionary = " ",
  Signature = " ",
}

return M
