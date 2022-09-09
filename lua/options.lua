vim.g.cursorhold_updatetime = 300

local options = {
  -- Appearance
  number = true,
  numberwidth = 5,
  showmode = false,
  signcolumn = "yes",
  termguicolors = true,
  cmdheight = 1,
  laststatus = 3,
  list = true,
  scrolloff = 8,
  pumheight = 13,
  tabstop = 2,
  cursorline = true,
  softtabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  autoindent = true,
  breakindent = true,
  breakindentopt = "shift:4",
  wrap = true,
  textwidth = 80,
  linebreak = true,
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
