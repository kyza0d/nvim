local concat = require('utils.concat')

local options = {

  -- Appearance

  laststatus = 3,
  cmdheight = 0,
  pumheight = 12,
  termguicolors = true,
  mouse = 'a',
  scrolloff = 6,
  showmode = false,

  title = true,

  number = true,
  numberwidth = 1,
  signcolumn = 'no',

  titlestring = 'nvim: @%{expand("%:p:h:t")}' .. '/%{expand("%:p:t")}',

  statuscolumn = concat({
    '%@SignCb@%s%=%T%@NumCb@ %l %T',
    "%#StatusColumnBorder#%{foldlevel(v:lnum) > 0 ? (foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? '󰅀  ' : '󰅂 ' ) : '   ') : '   '}",
    "%#FoldIndicator#%{(foldclosed(v:lnum) == -1 ? '' : ' ' )}",
  }),

  -- Indenting
  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  autoindent = true,
  breakindent = true,
  breakindentopt = 'shift:3',
  wrap = true,
  linebreak = true,

  -- Folding
  foldenable = true,
  foldlevel = 99,

  -- Searching
  ignorecase = true,
  smartcase = true,

  -- Memory and file
  shell = '/usr/bin/zsh',
  hidden = true,
  lazyredraw = false,
  swapfile = false,
  backup = false,

  -- Update times
  timeoutlen = 200,
  updatetime = 100,

  -- GUI options

  -- guifont = 'Iosevka Comfy Wide Motion:h10.4',
  -- guifont = 'Greybeard 14px:h11.7',
  -- guifont = 'Iosevka Comfy Wide Motion:h10.7',
  -- guifont = 'Pitagon Sans Mono:h10.6',
  guifont = 'Cartograph CF:h11.5',

  linespace = 8,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- Set statusline
create_autocmd({ 'BufEnter' }, {
  callback = function()
    if vim.bo.filetype ~= 'neo-tree' then vim.o.statusline = "%{%v:lua.require('statusline').active()%}" end
  end,
})

vim.opt.fillchars:append({
  -- horiz = '─',
  -- horiz = '▔',
  -- horizup = '▔',
  -- horizdown = '▔',
  -- vert = '▏',
  -- vertleft = '▏',
  -- vertright = '▏',
  -- verthoriz = '▏',
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
    Class = ' 󰴜 ',
    Color = '  ',
    Constant = ' 󰐤 ',
    Constructor = '  ',
    Enum = '   ',
    EnumMember = '  ',
    Event = '  ',
    Field = ' 󰸫 ',
    Folder = '  ',
    Function = ' 󰒔 ',
    Interface = ' 󰑕 ',
    Keyword = ' 󰎃 ',
    Method = ' 󰥤 ',
    Module = ' 󱃖 ',
    Array = ' 󱃗 ',
    Operator = ' 󰦓 ',
    Property = ' 󰥤 ',
    Reference = '  ',
    Snippet = ' 󰿦 ',
    Struct = '  ',
    Text = ' 󰺮 ',
    TypeParameter = ' 󰀧 ',
    Unit = '   ',
    Value = '  ',
    Variable = ' 󰥤 ',
    Directory = '  ',
    File = '  ',
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
    folder_open = '󰅀 ',
    folder_closed = '󰅂  ',
    folder_empty = '󰅀 ',
    file = ' ',
    symlink = ' ',
    symlink_open = ' ',
    default = ' ',
    default_open = ' ',
    indent_marker = '🭳',
    last_indent_marker = '🭳',
  },
}

if vim.g.neovide then vim.g.disable_icons = true end

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

  icons.editor.indent = '│'
  icons.editor.chevron = ' > '
end

return icons
