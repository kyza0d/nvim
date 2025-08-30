-- stylua: ignore start

keymap('n', '<s-q>', '<nop>')

keymap('n', '\\', ':set invhlsearch<cr>')

keymap('v', '<c-n>', function()
  local selection = helpers.visual_selection()

  if selection ~= '' then
    local escaped = vim.fn.escape(selection, [[/\]])
    vim.fn.setreg('/', [[\V]] .. escaped)
    vim.o.hlsearch = true
    vim.api.nvim_feedkeys('cgn', 'n', false)
  end
end, {
  noremap = true,
  silent = true,
})

-- Search for visually selected text
keymap('v', '//', [[y/\V<C-R>=escape(@",'/\')<CR><CR>N]])

-- Previous/next occurence
keymap('n', '<c-n>', '*')
keymap('n', '<c-p>', '#')

-- Start/end of line
keymap({ 'n', 'v' }, '<m-l>', '$')
keymap({ 'n', 'v' }, '<m-h>', '^')

-- Better %
keymap({ 'n', 'v' }, '<m-o>', function() api.nvim_input('%') end)

-- Vertical movement
keymap('n', '<M-k>', '4<c-y>')
keymap('n', '<M-j>', '4<c-e>')

-- Selection
keymap({ 'n', 'v' }, '<c-b>', '<c-v>')

-- Correct typo
keymap('n', '<C-c>', '1z=', { nowait = true })

-- Buffer operations
keymap('n', '<s-x>', '<cmd>noautocmd silent! Bd<cr>') -- Close buffer (bufferline)
-- keymap('n', '<s-x>', '<cmd>noautocmd silent! bd<cr>') -- Close buffer
keymap('n', '<c-s>', function ()
  if vim.bo.modified then vim.cmd('silent! write') end
end)

keymap('n', '<c-cr>', '<C-^>') -- Swap current and alternate file

-- Quick macro/repeat
keymap('n', 'M', 'qq', {nowait = true})
keymap('n', 'm', '@0', {nowait = true})
keymap("v", "m", ":normal @q<cr>", { nowait = true })

-- Folding
keymap('n', 'zh', 'za') -- Collapse at cursor hello
keymap('n', 'zl', 'zA') -- Expand at cursor
keymap('n', 'zH', 'zM') -- Collapse all
keymap('n', 'zL', 'zR') -- Expand all

create_autocmd('LspAttach', {
  callback = function()
    keymap('n', 'gd', lsp.buf.definition)
    keymap('n', 'gi', lsp.buf.implementation)
    keymap('n', '?', vim.lsp.buf.hover)
  end,
})

augroup('AddTerminalMappings', {
  event = { 'TermOpen' },
  command = function()
    if vim.bo.filetype == '' or vim.bo.filetype == 'toggleterm' then
      keymap('t', '<M-\\>', '<cmd>FloatermToggle<cr>')
      keymap('t', '<cmd>stopinsert<cr>', '<C-[>')
      keymap('t', '<C-v>', [[<C-\><C-n>"+pi]])
      keymap('t', '<C-[>', [[<C-\><C-n>]])
      keymap('t', '<esc>', [[<C-\><C-n>]])
      keymap('t', '<C-h>', [[<C-\><C-n><C-w>h]])
      keymap('t', '<C-w>', [[<C-\><C-n><C-w>]])
      keymap('t', '<C-j>', [[<C-\><C-n><C-w>ji]])
      keymap('t', '<C-k>', [[<C-\><C-n><C-w>ki]])
      keymap('n', '<C-c>', [[<C-\><C-n>i<C-c>]])
    end
  end,
})

-- stylua: ignore end
