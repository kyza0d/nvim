local concat = require('utils.concat')

local options = {

  ------------------------------
  -- Appearance
  ------------------------------

  numberwidth = 5,
  cursorline = true,
  laststatus = 3,
  cmdheight = 1,
  pumheight = 12,
  termguicolors = true,
  mouse = 'a',
  scrolloff = 6,
  showmode = false,

  title = true,
  titlestring = 'nvim:%{expand("%:p:h:t")}' .. '/%{expand("%:p:t")}',

  number = false,
  relativenumber = false,
  signcolumn = 'yes',

  statuscolumn = concat({
    '%= ',
    '%= %{v:lnum} ',
    -- "%#StatusColumnBorder#%{foldlevel(v:lnum) > 0 ? (foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? '󰅀  ' : '󰅂 ' ) : '   ') : '   '}",
    "%#StatusColumnBorder#%{foldlevel(v:lnum) > 0 ? (foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? '-  ' : '+ ' ) : '   ') : '   '}",
    "%#FoldIndicator#%{(foldclosed(v:lnum) == -1 ? '' : '▎' )}",
  }),

  ------------------------------
  -- Indenting
  ------------------------------

  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  autoindent = true,
  breakindent = true,
  breakindentopt = 'shift:3',
  wrap = true,
  linebreak = true,

  ------------------------------
  -- Folding
  ------------------------------

  foldenable = true,
  foldlevel = 99,

  ------------------------------
  -- Searching
  ------------------------------

  ignorecase = true,
  smartcase = true,

  ------------------------------
  -- Memory and file
  ------------------------------

  shell = '/usr/bin/zsh',
  hidden = true,
  lazyredraw = true,
  swapfile = false,
  backup = false,

  ------------------------------
  -- Update times
  ------------------------------

  timeoutlen = 200,
  updatetime = 100,

  ------------------------------
  -- GUI options
  ------------------------------

  -- guifont = "JetBrainsMono NFM SemiBold:h10.5",
  -- linespace = 2,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.fillchars:append({
  vert = ' ',
  vertright = '├',
  vertleft = '┤',
  horiz = '─',
  eob = ' ',
})

local icons = {
  editor = {
    file = ' ',
    book = ' ',
    book_alt = '',
    error = ' ',
    warning = ' ',
    hint = ' ',
    info = ' ',
    chevron = '  ',
    keyboard = '',
    git_branch = '󰘬 ',
    indent = '│',
  },

  completion = {
    Class = ' 󰴜  ',
    Color = '   ',
    Constant = ' 󰐤  ',
    Constructor = '   ',
    Enum = '    ',
    EnumMember = '   ',
    Event = '   ',
    Field = ' 󰸫  ',
    Folder = '   ',
    Function = ' 󰒔  ',
    Interface = ' 󰑕  ',
    Keyword = ' 󰎃  ',
    Method = ' 󰥤  ',
    Module = ' 󱃖  ',
    Array = ' 󱃗  ',
    Operator = ' 󰦓  ',
    Property = ' 󰥤  ',
    Reference = '   ',
    Snippet = ' 󰿦  ',
    Struct = '   ',
    Text = ' 󰺮  ',
    TypeParameter = ' 󰀧  ',
    Unit = '    ',
    Value = '   ',
    Variable = ' 󰥤  ',
    Directory = '   ',
    File = '   ',
  },

  navic = {
    File = ' ',
    Module = ' ',
    Namespace = ' ',
    Package = ' ',
    Class = ' ',
    Method = ' ',
    Property = ' ',
    Field = ' ',
    Constructor = ' ',
    Enum = '  ',
    Interface = '  ',
    Function = ' ',
    Variable = ' ',
    Constant = ' ',
    String = ' ',
    Number = ' ',
    Boolean = '◩ ',
    Array = ' ',
    Object = ' ',
    Key = ' ',
    Null = 'ﳠ ',
    EnumMember = ' ',
    Struct = ' ',
    Event = ' ',
    Operator = ' ',
    TypeParameter = ' ',
  },

  neotree = {
    folder_open = '',
    folder_closed = '',
    folder_empty = '',
    folder_empty_open = '',
    -- folder_open = ' 󰅀  ',
    -- folder_closed = ' 󰅂  ',
    -- folder_empty = ' 󰅀  ',
    -- folder_empty_open = ' ',
    file = ' ',
    symlink = ' ',
    symlink_open = ' ',
    default = ' ',
    default_open = ' ',
    indent_marker = '│',
    last_indent_marker = '│',
  },
}

vim.g.neovide_refresh_rate = 60
vim.g.disable_icons = true

if vim.g.disable_icons then
  vim.opt.fillchars:append({
    foldclose = '>',
    foldopen = 'v',
  })
  for _, t in ipairs(icons) do
    for k in pairs(t) do
      t[k] = ''
    end
  end
end

return icons
