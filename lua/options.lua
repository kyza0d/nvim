vim.g.cursorhold_updatetime = 300

-- local colors = require("palette").colors

-- vim.cmd("hi FoldColumn guifg=" .. colors.background_0)

local options = {
  -- Appearance
  number = true,
  numberwidth = 1,
  relativenumber = false,
  foldcolumn = "2",
  signcolumn = "no",
  showmode = false,
  termguicolors = true,
  cmdheight = 1,
  laststatus = 3,
  wrap = false,
  list = true,
  scrolloff = 8,
  pumheight = 10,
  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  cursorline = false,
  expandtab = true,
  autoindent = true,
  breakindent = true,
  breakindentopt = "shift:4",
  linebreak = true,
  hidden = true,
  timeoutlen = 300,
  ignorecase = true,
  lazyredraw = true,
  swapfile = false,
  backup = false,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.fillchars:append({
  -- vert = "▕",
  vert = "▏",
  vertright = " ",
  fold = " ",
  foldclose = "",
  foldopen = "",
  foldsep = " ",
  vertleft = " ",
  eob = " ",
  horiz = " ",
})

vim.wo.foldlevel = 20
vim.wo.foldenable = true

local icons = {
  file = " ",
  book = " ",

  book_alt = " ",

  error = " ",
  warning = " ",
  hint = " ",
  info = " ",

  chevron = "  ",

  folder_open = " ",
  folder_closed = " ",
  folder_empty = " ",
  folder_alt = "  ",
  git_branch = "  ",

  indent_marker = "│",
  last_indent_marker = "╰╴",
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

vim.g.icons_enabled = true

if vim.g.icons_enabled then
  return {
    icons = icons,
    cmp = cmp,
  }
else
  local no_icons = {
    file = "",

    chevron = " > ",
    folder_open = "v",
    folder_closed = ">",
    folder_empty = " ",

    error = "x",
    warning = "!",
    hint = "?",
    info = "i",

    indent_marker = "|",
    last_indent_marker = "| ",
  }

  return {
    icons = vim.tbl_deep_extend("keep", {}, no_icons, erase(icons) or {}),
    cmp = cmp,
  }
end
