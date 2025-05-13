-- stylua: ignore start

keymap('n', '<S-q>', '<nop>')

keymap('n', '\\', ':set invhlsearch<cr>')

-- Change go next under cursor
keymap('v', '<C-n>', [[:<C-u>normal! *``gvy<CR>cgn]], { noremap = true, silent = true })

-- Search for visually selected text
keymap('v', '//', [[y/\V<C-R>=escape(@",'/\')<CR><CR>N]])

-- Previous/next occurence
keymap('n', '<C-n>', '*')
keymap('n', '<C-p>', '#')

-- Start/end of line
keymap({ 'n', 'v' }, '<M-l>', '$')
keymap({ 'n', 'v' }, '<M-h>', '^')

-- Better %
keymap({ 'n', 'v' }, '<M-o>', function() api.nvim_input('%') end)

-- Vertical movement
keymap('n', '<M-k>', '4<C-y>')
keymap('n', '<M-j>', '4<C-e>')

-- Selection
keymap({ 'n', 'v' }, '<C-b>', '<C-v>')

-- Correct typo
keymap('n', '<C-c>', '1z=', { nowait = true })

-- Buffer operations
keymap('n', '<S-x>', '<cmd>noautocmd silent! bd<cr>') -- Close buffer
keymap('n', '<C-CR>', '<C-^>') -- Swap current and alternate file

-- Quick macro/repeat
keymap('n', '<C-q>', 'qq')
keymap('v', '.', ':normal .<cr>')
keymap("v", "q", ":normal @q<cr>", { nowait = true })
keymap({ "n", "v" }, "<C-.>", ":normal @q<cr>", { nowait = true })

-- Folding
keymap('n', 'zh', 'za') -- Collapse at cursor
keymap('n', 'zl', 'zA') -- Expand at cursor
keymap('n', 'zH', 'zM') -- Collapse all
keymap('n', 'zL', 'zR') -- Expand all

create_autocmd('LspAttach', {
  callback = function()
    keymap('n', 'gd', lsp.buf.definition)
  end,
})

augroup('AddTerminalMappings', {
  event = { 'TermOpen' },
  command = function()
    if vim.bo.filetype == '' or vim.bo.filetype == 'toggleterm' then
      keymap('t', '<cmd>stopinsert<cr>', '<C-[>')
      keymap('t', '<C-v>', [[<C-\><C-n>"+pi]])
      keymap('t', '<C-[>', [[<C-\><C-n>]])
      keymap('t', '<esc>', [[<C-\><C-n>]])
      keymap('t', '<C-h>', [[<C-\><C-n><C-w>h]])
      keymap('t', '<C-w>', [[<C-\><C-n><C-w>]])
      keymap('t', '<C-j>', [[<C-\><C-n><C-w>ji]])
      keymap('t', '<C-k>', [[<C-\><C-n><C-w>ki]])
    end
  end,
})

-- stylua: ignore end
