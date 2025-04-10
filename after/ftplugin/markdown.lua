local opt = vim.opt_local

-- Set up markdown-specific options
opt.wrap = true
opt.conceallevel = 2
opt.concealcursor = 'nc'
opt.textwidth = 80
opt.formatoptions:append('t')
opt.formatoptions:append('c')
opt.formatoptions:append('q')
opt.linebreak = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.expandtab = true
opt.spell = true
opt.spelllang = 'en_us'

keymap('i', '<C-t>', '<c-o>:norm <C-t>$<cr>', { noremap = false, desc = 'Insert checkbox at beginning and move to end', buffer = true })
