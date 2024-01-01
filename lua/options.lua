--------------------------------------------

-- Options
--------------------------------------------

local options = {
  -- Appearance
  laststatus = 3,
  cmdheight = 1,
  pumheight = 12,
  cursorline = false,
  scrolloff = 8,
  termguicolors = true,
  showtabline = 3,
  showmode = false,
  number = true,
  numberwidth = 1,
  signcolumn = 'yes',
  mousescroll = 'ver:3,hor:0',

  -- Indenting
  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  autoindent = true,
  breakindent = true,
  breakindentopt = 'shift:3',
  textwidth = 80,
  wrap = true,
  linebreak = true,

  -- Folding
  foldenable = true,
  foldcolumn = '2',
  foldlevel = 25,

  -- Searching
  ignorecase = true,
  smartcase = true,

  -- Timeouts
  timeoutlen = 200,
  updatetime = 50,

  -- Buffer Management
  hidden = true,
  lazyredraw = false,
  swapfile = false,
  backup = false,

  -- Shell
  shell = '/usr/bin/zsh',

  -- Title string
  title = true,

  statuscolumn = concat({
    '%@SignCb@%s%=%T%@NumCb@ %l %T',
    "%#StatusColumnBorder#%{foldlevel(v:lnum) > 0 ? (foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? '󰅀  ' : '󰅂 ' ) : '   ') : '   '}",
    "%#FoldedIndicator#%{(foldclosed(v:lnum) == -1 ? '' : ' ▎' )}",
  }),

  -- Gui Options
  guifont = 'Cartograph CF,Symbols Nerd Font:h10.3',
  linespace = 6,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- vim.opt.titlestring = 'nvim: @%{expand("%:p:h:t")}' .. '/%{expand("%:p:t")}'

-- UI characters.
vim.opt.fillchars:append({
  horiz = '─',
  horizup = '─',
  horizdown = '─',
  vert = '▏',
  vertleft = '▏',
  vertright = '▏',
  verthoriz = '▏',
  eob = ' ',
})

return options
