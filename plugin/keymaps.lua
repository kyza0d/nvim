keymap('n', '\\', ':set invhlsearch<cr>', { desc = 'Toggle highlight' })
keymap('v', '//', [[y/\V<C-R>=escape(@",'/\')<CR><CR>N]], { desc = 'Search for visually selected text' })

-- [ Navigation and Motion ] ----------------------------

-- Scrolling
keymap('n', '<M-k>', '4<C-y>', { desc = 'Scroll up' })
keymap('n', '<M-j>', '4<C-e>', { desc = 'Scroll down' })

-- Search navigation
keymap('n', '<C-n>', '*', { desc = 'Next occurrence' })
keymap('n', '<C-p>', '#', { desc = 'Previous occurrence' })

-- Matching pairs
keymap({ 'n', 'v' }, '<M-o>', function() vim.api.nvim_input('%') end, { desc = 'Goto matching pair', nowait = true })

-- Line navigation
keymap({ 'n', 'v' }, '<M-l>', '$', { desc = 'Goto end of line' })
keymap({ 'n', 'v' }, '<M-h>', '^', { desc = 'Goto start of line' })

-- [ Text Manipulation ] ----------------------------

-- Misc text operations
keymap('v', '.', ':normal .<cr>', { desc = 'Repeat across lines' })
keymap('x', 'x', '<S-j>', { desc = 'Collapse line in visual mode' })

-- Clipboard operations
keymap({ 'n', 'v' }, '<C-v>', '"+p', { desc = 'Paste from + register' })
keymap('v', '<C-c>', '"+y', { desc = 'Yank to + register' })

-- [ File and Buffer Management ] ----------------------------

-- File operations
keymap('n', '<M-s>', '<cmd>silent w<cr>', { desc = 'Save file' })

-- Buffer navigation
keymap('n', '<C-CR>', '<C-^>', { desc = 'Alternate buffers' })

-- Window management
keymap('n', '<M-CR>', '<cmd>split<cr>', { desc = 'Split window' })

-- [ Folding ] ----------------------------
keymap('n', 'zh', 'za', { desc = 'Toggle fold' })
keymap('n', 'zl', 'zA', { desc = 'Toggle all folds' })

-- [ Miscellaneous ] ----------------------------
keymap({ 'n', 'v' }, '<C-b>', '<C-v>', { desc = 'Block selection' })
keymap('n', '<C-I>', '<C-I>', { desc = 'Jump to last jump' })

-- LSP keymaps
create_autocmd('LspAttach', {
  callback = function()
    keymap('n', '<s-d>', function() vim.lsp.buf.definition() end, { desc = 'Go to definition (LSP)', buffer = true })
    -- Debugging
    keymap('n', 'gp', 'g?p', { noremap = false, desc = 'Print variable' })
  end,
})

ky.augroup('AddTerminalMappings', {
  event = { 'TermOpen' },
  command = function()
    if vim.bo.filetype == '' or vim.bo.filetype == 'toggleterm' then
      vim.keymap.set('t', '<cmd>stopinsert<cr>', '<C-[>', { desc = 'Stop insert mode', noremap = true })
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], { desc = 'Escape to normal mode', buffer = 0 })
      vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], { desc = 'Close window', buffer = 0 })
      vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-w>ji]], { desc = 'Move cursor down', buffer = 0 })
      vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-w>ki]], { desc = 'Move cursor up', buffer = 0 })
    end
  end,
})
