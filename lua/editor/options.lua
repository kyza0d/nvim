require('vim._extui').enable({})
vim.lsp.inline_completion.enable(true)

opt.showmode = false
opt.laststatus = 2
opt.cmdheight = 0

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

opt.number = true
opt.numberwidth = 3
opt.hidden = true
opt.lazyredraw = false

opt.swapfile = false
opt.backup = false
opt.undofile = true

opt.autoread = true
opt.splitkeep = 'screen'
opt.splitbelow = true
opt.splitright = true

opt.eadirection = 'hor'
opt.switchbuf = 'useopen,uselast'

opt.shell = '/usr/bin/zsh'
opt.title = true

settings({
  [{
    'kitty',
    'config',
  }] = {
    opts = {
      commentstring = '# %s',
      number = false,
    },
  },

  [{ 'fzf' }] = {
    opts = {
      winbar = '',
    },
  },

  [{
    'grug-far',
    'markdown',
    'codecompanion',
  }] = {
    opts = {
      number = false,
      cursorline = false,
      foldcolumn = '0',
      signcolumn = 'no',
      textwidth = 65,
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

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  return orig_util_open_floating_preview(contents, syntax, {
    border = 'none',
    max_width = 60,
    max_height = 60,
  }, ...)
end
