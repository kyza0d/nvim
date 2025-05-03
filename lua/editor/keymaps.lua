-- stylua: ignore start

-- Disable built-in keymappings
keymap('n', '<S-q>', '<nop>')

local lsp = vim.lsp
keymap('n', '\\', ':set invhlsearch<cr>')

keymap('v', '<M-n>', [[:<C-u>normal! *``gvy<CR>cgn]], { noremap = true, silent = true })

-- Search for visually selected text
keymap('v', '//', [[y/\V<C-R>=escape(@",'/\')<CR><CR>N]])

keymap('n', '<C-n>', '*') -- Next occrence
keymap('n', '<C-p>', '#') -- Previous occrence

keymap({ 'n', 'v' }, '<M-l>', '$') -- End of line
keymap({ 'n', 'v' }, '<M-h>', '^') -- Start of line

keymap({ 'n', 'v' }, '<M-o>', function() vim.api.nvim_input('%') end)

keymap('n', '<M-k>', '4<C-y>') -- Scroll up
keymap('n', '<M-j>', '4<C-e>') -- Scroll down

keymap({ 'n', 'v' }, '<C-b>', '<C-v>') -- Block select

-- Editing
keymap('n', '<C-z>', '1z=', { nowait = true })

-- Buffer operations
keymap('n', '<S-x>', '<cmd>noautocmd silent! bd<cr>') -- Close buffer
keymap('n', '<C-CR>', '<C-^>') -- Swap current and alternate file

-- Macros/repeat
keymap('n', '<S-q>', 'qq')
keymap('v', '.', ':normal .<cr>')
keymap("v", "q", ":normal @q<cr>", { nowait = true })
keymap({ "n", "v" }, "<C-.>", ":normal @q<cr>", { nowait = true })

-- Folding
keymap('n', 'zh', 'za') -- Collapse at cursor
keymap('n', 'zl', 'zA') -- Expand at cursor
keymap('n', 'zH', 'zM') -- Collapse all
keymap('n', 'zL', 'zR') -- Expand all

-- LSP
create_autocmd('LspAttach', {
  callback = function()
    keymap('n', 'gp', 'g?p', { noremap = false })
    keymap('n', 'gD', lsp.buf.type_definition)
    keymap('n', 'gd', lsp.buf.definition)
    keymap('n', 'gr', lsp.buf.references)
  end,
})

augroup('AddTerminalMappings', {
  event = { 'TermOpen' },
  command = function()
    if vim.bo.filetype == '' or vim.bo.filetype == 'toggleterm' then
      vim.keymap.set('t', '<cmd>stopinsert<cr>', '<C-[>')
      vim.keymap.set('t', '<C-v>', [[<C-\><C-n>"+pi]])
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])
      vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-w>h]])
      vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]])
      vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-w>ji]])
      vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-w>ki]])
    end
  end,
})

-- stylua: ignore end
