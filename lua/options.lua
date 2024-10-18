-- [ Status and Command Line ] ----------------------------

vim.opt.laststatus = 2 -- Always display the status line
vim.opt.cmdheight = 0 -- Height of the command line
vim.opt.showtabline = 3 -- Always show tabline
vim.opt.showmode = false -- Don't show mode in command line

-- [ Popup Menu ] --------------------------------------

vim.opt.pumheight = 10 -- Popup menu height

-- [ Cursor and Scrolling ] ----------------------------

vim.opt.cursorline = false
vim.opt.scrolloff = 8 -- Minimum lines to keep above and below the cursor
vim.opt.mousescroll = 'ver:3,hor:0' -- Mouse scroll settings
vim.opt.guicursor = {
  'n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50',
  'a:Cursor/lCursor',
  'sm:block-blinkwait175-blinkoff150-blinkon175',
}

-- [ Colors and Display ] ----------------------------

vim.opt.termguicolors = true -- Enable 24-bit RGB colors
vim.opt.conceallevel = 2 -- Conceal text (useful for markdown)
vim.opt.signcolumn = 'no' -- Always show sign column
vim.opt.emoji = true -- Enable emoji display

-- [ Tabs and Indentation ] ----------------------------

vim.opt.tabstop = 2 -- Number of spaces that a <Tab> counts for
vim.opt.softtabstop = 2 -- Number of spaces that a <Tab> counts for while editing
vim.opt.shiftwidth = 2 -- Number of spaces to use for autoindenting
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.autoindent = true -- Copy indent from current line when starting a new line
vim.opt.breakindent = true -- Wrap indent to match line start
vim.opt.breakindentopt = 'shift:3' -- Options for break indent

-- [ Wrapping and Text Width ] ----------------------------

vim.opt.textwidth = 80 -- Maximum width of text that is being inserted
vim.opt.wrap = true -- Wrap long lines
vim.opt.linebreak = true -- Break lines at word boundaries

-- [ Folding ] ----------------------------

vim.opt.foldenable = true -- Enable folding
vim.opt.foldcolumn = '0' -- Number of fold columns
vim.opt.foldlevel = 25 -- Fold level
vim.opt.foldmethod = 'expr' -- Folding method
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()' -- Fold expression

-- [ Search ] ----------------------------

vim.opt.ignorecase = true -- Ignore case when searching
vim.opt.smartcase = true -- Override ignorecase if search pattern contains uppercase letters

-- [ Timing ] ----------------------------

vim.opt.timeout = true -- Enable timeout
vim.opt.timeoutlen = 500 -- Time to wait for a mapped sequence to complete
vim.opt.updatetime = 300 -- Time to wait before triggering the plugin

-- [ Numbers and Hidden Buffers ] ----------------------------

vim.opt.number = false -- Show line numbers
vim.opt.hidden = true -- Allow switching buffers without saving
vim.opt.lazyredraw = false -- Don't redraw while executing macros

-- [ Files and Backups ] ----------------------------

vim.opt.swapfile = false -- Don't use swap file
vim.opt.backup = false -- Don't create backup files
vim.opt.undofile = true -- Save undo history

-- [ Splits ] ----------------------------

vim.opt.splitkeep = 'screen' -- Keep splits visible on screen
vim.opt.splitbelow = true -- Put new split below current
vim.opt.splitright = true -- Put new split to the right of the current

-- [ Buffers and Windows ] ----------------------------

vim.opt.eadirection = 'hor' -- Equally divide splits horizontally
vim.opt.switchbuf = 'useopen,uselast' -- Buffer switching options

-- [ Shell ] ----------------------------

vim.opt.shell = '/usr/bin/zsh' -- Use zsh as the shell
vim.opt.title = true -- Set terminal title

-- [ Fillchars ] ----------------------------

vim.opt.fillchars:append({
  horiz = '─',
  horizup = '─',
  diff = '╱',
  horizdown = '─',
  vert = '▕', --
  vertleft = '▏',
  vertright = '▏',
  eob = ' ',
  foldopen = '󰅀',
  foldclose = '󰅂',
})

-- [ Diff Options ] ----------------------------

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
