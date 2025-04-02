vim.opt.laststatus = 2
vim.opt.cmdheight = 0
vim.opt.showtabline = 3
vim.opt.showmode = false

vim.opt.pumheight = 10

vim.opt.cursorline = false
vim.opt.scrolloff = 8
vim.opt.mousescroll = 'ver:3,hor:0'
vim.opt.guicursor = {
  'n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50',
  'a:Cursor/lCursor',
  'sm:block-blinkwait175-blinkoff150-blinkon175',
}

vim.opt.termguicolors = true
vim.opt.conceallevel = 2
vim.opt.signcolumn = 'yes'
vim.opt.emoji = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.breakindent = true
vim.opt.breakindentopt = 'shift:3'

vim.opt.textwidth = 80
vim.opt.wrap = true
vim.opt.linebreak = true

vim.opt.foldenable = true
vim.opt.foldcolumn = '0'
vim.opt.foldlevel = 25
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.timeout = true
vim.opt.timeoutlen = 500
vim.opt.updatetime = 300

vim.opt.number = false
vim.opt.numberwidth = 3
vim.opt.hidden = true
vim.opt.lazyredraw = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.splitkeep = 'screen'
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.eadirection = 'hor'
vim.opt.switchbuf = 'useopen,uselast'

vim.opt.shell = '/usr/bin/zsh'
vim.opt.title = true

vim.opt.fillchars:append({
  horiz = '─',
  horizup = '─',
  diff = '╱',
  horizdown = '─',
  vert = '▕',
  vertleft = '▏',
  vertright = '▏',
  eob = ' ',
  foldopen = '󰅀',
  foldclose = '󰅂',
})

vim.opt.diffopt = vim.opt.diffopt
  + {
    'vertical',
    'iwhite',
    'hiddenoff',
    'foldcolumn:0',
    'context:4',
    'algorithm:histogram',
    'indent-heuristic',
    'linematch:60',
  }
