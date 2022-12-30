vim.g.icons_enabled = true

local options = {
  syntax = "enable",
  numberwidth = 3,
  cursorline = true,
  relativenumber = false,
  foldcolumn = "1",
  signcolumn = "no",
  number = false,
  showmode = false,
  termguicolors = true,
  cmdheight = 0,
  smartcase = true,
  laststatus = 3,
  scrolloff = 6,
  pumheight = 12,
  tabstop = 2,
  shortmess = "",

  softtabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  autoindent = true,
  breakindent = true,
  breakindentopt = "shift:4",

  foldenable = true,

  wrap = true,
  linebreak = true,

  hidden = true,
  timeoutlen = 400,
  updatetime = 200,
  ignorecase = true,
  -- lazyredraw = true,
  lazyredraw = true,
  swapfile = false,
  backup = false,

  shell = "/usr/bin/zsh",
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.opt.fillchars:append({
  -- vert = "▕",
  -- vert = "│",
  vert = "▏",
  vertright = "├",
  fold = " ",
  foldclose = "",
  foldopen = "",
  foldsep = " ",
  vertleft = "┤",
  eob = " ",
  horiz = "─",
})

local icons = {
  file = " ",
  book = " ",
  book_alt = " ",
  error = " ",
  warning = " ",
  hint = " ",
  info = " ",
  chevron = "  ",
  keyboard = "",
  folder_closed = "  ",
  folder_open = "  ",
  folder_empty = "  ",
  folder = "  ",
  git_branch = "",
  indent_marker = "│",
  -- last_indent_marker = "└╴",
  last_indent_marker = "│",
}

local cmp = {
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

local function erase(table)
  for icon, _ in pairs(table) do
    table[icon] = ""
  end

  return table
end

if vim.g.icons_enabled then
  return {
    icons = icons,
    cmp = cmp,
  }
else
  return {
    icons = vim.tbl_deep_extend("keep", {}, {
      file = "",

      chevron = " > ",
      folder_open = "v",
      folder_closed = ">",
      folder_empty = "> ",

      error = "x",
      warning = "!",
      hint = "?",
      info = "i",

      indent_marker = "|",
      last_indent_marker = "| ",
    }, erase(icons) or {}),
    cmp = cmp,
  }
end
