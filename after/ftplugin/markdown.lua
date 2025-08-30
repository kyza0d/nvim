opt.wrap = true
opt.conceallevel = 2
opt.concealcursor = 'nc'
opt.formatoptions:append('t')
opt.formatoptions:append('c')
opt.formatoptions:append('q')
opt.linebreak = true
opt.breakindent = false
opt.shiftwidth = 2
opt.tabstop = 2
opt.lazyredraw = true
opt.expandtab = true
opt.spelllang = 'en_us'

-- Correct spelling
keymap('i', '<C-c>', '<C-g>u<Esc>[s1z=`]a<C-g>u', { buffer = true })

-- Toggle checkbox
if pcall(require, 'markdown-toggle') then
  keymap({ 'n', 'v' }, '<Tab>', require('markdown-toggle').checkbox, { silent = true, buffer = true })
end

-- Obsidian
keymap('n', '<S-k>', '<cmd>Obsidian follow_link<cr>', { silent = true, buffer = true })
