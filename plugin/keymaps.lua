-- stylua: ignore start

local lsp = vim.lsp
keymap('n', '\\', ':set invhlsearch<cr>')

-- Opinionated Keymappings (my personal preferences)

-- Search for visually selected text
keymap('v', '//', [[y/\V<C-R>=escape(@",'/\')<CR><CR>N]])

keymap('n', '<M-n>', '*') -- Next occrence
keymap('n', '<M-p>', '#') -- Previous occrence

keymap({ 'n', 'v' }, '<M-l>', '$') -- End of line
keymap({ 'n', 'v' }, '<M-h>', '^') -- Start of line
keymap({ 'n', 'v' }, '<M-o>', function() -- Other bracket
  vim.api.nvim_input('%')
end)

keymap('n', '<M-k>', '4<C-y>') -- Scroll up
keymap('n', '<M-j>', '4<C-e>') -- Scroll down

keymap({ 'n', 'v' }, '<C-b>', '<C-v>') -- Block select

-- Change/delete go newxt
keymap("x", "<C-n", "//cgn", { nowait = false, noremap = false })

-----[ Register operations ]-----

-- Clipboard
keymap({ 'n', 'v' }, '<C-v>', '"+p') -- Paste
keymap('i', '<C-v>', '<C-r>+')       -- Paste (insert mode)
keymap('v', '<C-c>', '"+y')          -- Yank

-- Buffer operations
keymap('n', '<S-s>', '<cmd>silent w<cr>') -- Save
keymap('n', '<S-q>', '<cmd>bd<cr>')       -- Quit
keymap('n', '<C-CR>', '<C-^>')            -- Swap

-- Misc text operations
keymap('v', '.', ':normal .<cr>') -- Dot repeat (across lines)
keymap("v", "a", ":normal @a<cr>") -- apply macro (across lines )
keymap('x', 'x', '<S-j>')

-- [ Folding ] ----------------------------
keymap('n', 'zh', 'za') -- Collapse at cursor
keymap('n', 'zl', 'zA') -- Expand at cursor
keymap('n', 'zH', 'zM') -- Collapse all
keymap('n', 'zL', 'zR') -- Expand all

-- [ Spelling ] ---------------------------
keymap('n', 'zj', 'zg')                    -- Add to dictionary under cursor
keymap('n', 'zJ', 'zgG')                   -- Add all to dictionary
keymap('n', 'zc', '<C-o>:normal! z=1<cr>') -- Correct word under cursor

-- LSP keymaps
create_autocmd('LspAttach', {
  callback = function()
    keymap('n', 'gp', 'g?p', { noremap = false })
    keymap('n', 'gD', lsp.buf.type_definition)
    keymap('n', 'gd', lsp.buf.definition)
    keymap('n', 'gr', lsp.buf.references)
    keymap('n', '<C-space>', lsp.buf.hover)
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

-- stylua: ignore end
