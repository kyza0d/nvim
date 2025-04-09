local lsp = vim.lsp
keymap('v', '//', [[y/\V<C-R>=escape(@",'/\')<CR><CR>N]])
keymap('n', '\\', ':set invhlsearch<cr>')

-- Scrolling
keymap('n', '<M-k>', '4<C-y>')
keymap('n', '<M-j>', '4<C-e>')

-- Search navigation
keymap('n', '<C-n>', '*')
keymap('n', '<C-p>', '#')

-- Matching pairs
keymap({ 'n', 'v' }, '<M-o>', function() vim.api.nvim_input('%') end)

-- Line navigation
keymap({ 'n', 'v' }, '<M-l>', '$')
keymap({ 'n', 'v' }, '<M-h>', '^')

-- Misc text operations
keymap('v', '.', ':normal .<cr>')
keymap('x', 'x', '<S-j>')

-- Clipboard operations
keymap({ 'n', 'v' }, '<C-v>', '"+p')
keymap('i', '<C-v>', '<C-r>+')

keymap('v', '<C-c>', '"+y')

-- File operations
keymap('n', '<M-s>', '<cmd>silent w<cr>')

-- Buffer navigation
keymap('n', '<C-CR>', '<C-^>')
keymap('n', '<S-q>', '<cmd>bd!<cr>')

-- Window management
keymap('n', '<M-CR>', '<cmd>split<cr>')

-- [ Folding ] ----------------------------
keymap('n', 'zh', 'za')
keymap('n', 'zl', 'zA')

keymap({ 'n', 'v' }, '<C-b>', '<C-v>')

-- LSP keymaps
create_autocmd('LspAttach', {
  callback = function()
    keymap('n', 'gp', 'g?p', { noremap = false })
    keymap('n', 'gd', lsp.buf.definition)
    keymap('n', 'gr', lsp.buf.references)
  end,
})

ky.augroup('AddTerminalMappings', {
  event = { 'TermOpen' },
  command = function()
    if vim.bo.filetype == '' or vim.bo.filetype == 'toggleterm' then
      vim.keymap.set('t', '<cmd>stopinsert<cr>', '<C-[>')
      vim.keymap.set('t', '<C-v>', [[<C-\><C-n>"+pi]])
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])
      vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]])
      vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-w>ji]])
      vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-w>ki]])
    end
  end,
})
