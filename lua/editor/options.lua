opt.laststatus = 2
opt.cmdheight = 0
opt.showmode = false

opt.pumheight = 10

opt.cursorline = true
opt.scrolloff = 8
opt.mousescroll = 'ver:3,hor:0'
opt.guicursor = {
  'n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50',
  'a:Cursor/lCursor',
  'sm:block-blinkwait175-blinkoff150-blinkon175',
}

opt.termguicolors = true
opt.signcolumn = 'yes'
opt.emoji = true

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.breakindent = true
opt.breakindentopt = 'shift:3'

opt.textwidth = 80
opt.wrap = true
opt.linebreak = true

opt.foldenable = true
opt.foldcolumn = '0'
opt.foldlevel = 24
opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'

opt.ignorecase = true
opt.smartcase = true

opt.timeout = true
opt.timeoutlen = 500
opt.updatetime = 300

opt.number = false
opt.numberwidth = 3
opt.hidden = true
opt.lazyredraw = false

opt.swapfile = false
opt.backup = false
opt.undofile = true

opt.splitkeep = 'screen'
opt.splitbelow = true
opt.splitright = true

opt.eadirection = 'hor'
opt.switchbuf = 'useopen,uselast'

opt.shell = '/usr/bin/zsh'
opt.title = true

settings({
  [{ 'kitty', 'config' }] = {
    opts = {
      commentstring = '# %s',
      number = false,
    },
  },

  [{ 'markdown' }] = {
    opts = {
      number = false,
      statuscolumn = ' ',
      textwidth = 65,
      signcolumn = 'no',
    },
  },

  [{ 'qf' }] = {
    opts = {
      wrap = false,
      number = false,
      signcolumn = 'no',
      buflisted = false,
      winfixheight = true,
    },
  },
})

opt.fillchars:append({
  horiz = '─',
  horizup = '─',
  diff = '╱',
  horizdown = '─',
  vert = '▕',
  vertleft = '▏',
  vertright = '▏',
  eob = ' ',
  fold = ' ',
  foldsep = ' ',
  foldopen = '󰅀',
  foldclose = '󰅂',
})

opt.diffopt = opt.diffopt
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
