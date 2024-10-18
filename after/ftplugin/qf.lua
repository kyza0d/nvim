local opt = vim.opt_local

opt.wrap = false
opt.number = false
opt.statuscolumn = ''
opt.signcolumn = 'no'
opt.buflisted = false
opt.winfixheight = true

vim.keymap.set('n', 'dd', ky.list.qf.delete, { desc = 'delete current quickfix entry', buffer = true })
vim.keymap.set('v', 'd', ky.list.qf.delete, { desc = 'delete selected quickfix entry', buffer = true })

-- force quickfix to open beneath all other splits
vim.cmd.wincmd('J')
