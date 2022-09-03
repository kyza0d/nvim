local options = {
  -- Appearance
  number = true,
  showmode = false,
  signcolumn = "yes",
  termguicolors = true,
  scrolloff = 8,
  pumheight = 13,

  -- Indent
  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  laststatus = 3,
  cmdheight = 1,
  expandtab = true,
  autoindent = true,
  breakindent = true,
  breakindentopt = "shift:4",
  list = true,

  -- Wrapping
  wrap = true,
  textwidth = 80,
  linebreak = true,

  -- Behavior
  hidden = true,
  timeoutlen = 300,
  ignorecase = true,
  lazyredraw = true,
  swapfile = false,
  backup = false,
}

vim.opt.fillchars:append({
  vert = " ",
  vertright = " ",
  fold = " ",
  foldclose = "",
  foldopen = "",
  foldsep = " ",
  vertleft = " ",
  eob = " ",
  horiz = "─",
})

vim.wo.foldlevel = 20
vim.wo.foldenable = true

for k, v in pairs(options) do
  vim.opt[k] = v
end
