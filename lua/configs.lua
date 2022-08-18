vim.g.vitex_view_method = "zathura"
vim.g.vimtex_view_forward_search_on_start = false

vim.cmd([[syntax enable]])

local config = {
  -- Appearance
  cmdheight = 0,
  number = true,
  linespace = 3,
  numberwidth = 0,
  laststatus = 3,
  pumheight = 13,
  splitright = true,

  scrolloff = 8,
  signcolumn = "yes",
  termguicolors = true,
  -- colorcolumn = "80",
  showmode = false,

  -- Wrapping
  wrap = true,
  textwidth = 80,
  linebreak = true,
  foldcolumn = "0",

  -- Indentation
  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  autoindent = true,
  breakindent = true,
  breakindentopt = "shift:4",

  -- Behavior
  hidden = true,
  timeoutlen = 300,
  updatetime = 300,
  ignorecase = true,
  lazyredraw = true,
  swapfile = false,
  smartcase = true,
  backup = false,
  mouse = "a",

  show_icons = true,

  icons = {
    { "", "left_sep" },
    { "", "right_sep" },
    { " ", "git" },
    { "+", "added" },
    { "~", "changed" },
    { "-", "removed" },
    { "", "modified" },
    { " ", "error" },
    { " !", "warning" },
    { " ", "info" },
    { "", "readonly" },
    { " ", "folder" },
    { " ", "folder_open" },
    { " ", "chevron_r" },
    { " ", "chevron_d" },
    { " 🭲", "tree_indent" },
    { "▏", "editor_indent" },
    { "▍", "tab_indicator" },

    { " ", "Text" },
    { "m ", "Method" },
    { " ", "Function" },
    { " ", "Constructor" },
    { " ", "Field" },
    { " ", "Variable" },
    { " ", "Class" },
    { " ", "Interface" },
    { " ", "Module" },
    { " ", "Property" },
    { " ", "Unit" },
    { " ", "Value" },
    { " ", "Enum" },
    { " ", "Keyword" },
    { " ", "Snippet" },
    { " ", "Color" },
    { " ", "File" },
    { " ", "Reference" },
    { " ", "Folder" },
    { " ", "EnumMember" },
    { " ", "Constant" },
    { " ", "Struct" },
    { " ", "Event" },
    { " ", "Operator" },
    { " ", "TypeParameter" },
  },

  borders = {
    telescope = "single",
    completion = "none",
  },
}

vim.opt.fillchars:append({
  vert = "▏",
  vertright = "▏",
  fold = "🭳",
  foldclose = "",
  foldopen = "",
  foldsep = " ",
  vertleft = "▕",
  eob = " ",
  horiz = "▁",
})

vim.wo.foldlevel = 20
vim.wo.foldenable = true

for k, v in pairs(config) do
  pcall(function()
    vim.opt[k] = v
  end, k, v)
end

return config
