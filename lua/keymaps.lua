local pickers = require('config.telescope.pickers')

-- [ General ] ----------------------------

keymap('n', '\\', ':set invhlsearch<cr>', { desc = 'Toggle highlight' })
keymap('v', '//', [[y/\V<C-R>=escape(@",'/\')<CR><CR>N]], { desc = 'Search for visually selected text' })

-- [ AI Assistance ] ----------------------------

-- Neocodeium
keymap('i', '<M-j>', function() require('neocodeium').accept() end)
keymap('i', '<M-l>', function() require('neocodeium').accept_line() end)
keymap('i', '<M-n>', function() require('neocodeium').cycle_or_complete() end)
keymap('i', '<M-p>', function() require('neocodeium').cycle_or_complete(1) end)
keymap('i', '<M-CR>', function() require('neocodeium').accept() end)

-- [ Notes, Todos, etc ] ----------------------------
vim.api.nvim_create_autocmd('Filetype', {
  pattern = 'norg',
  callback = function() vim.keymap.set('n', '<M-Space>', '<Plug>(neorg.qol.todo-items.todo.task-cycle)', { buffer = true }) end,
})

-- [ Navigation and Motion ] ----------------------------

-- Spider motion
keymap({ 'n', 'o', 'x' }, 'w', "<cmd>lua require('spider').motion('w')<CR>", { desc = 'Spider-w' })
keymap({ 'n', 'o', 'x' }, 'e', "<cmd>lua require('spider').motion('e')<CR>", { desc = 'Spider-e' })
keymap({ 'n', 'o', 'x' }, 'b', "<cmd>lua require('spider').motion('b')<CR>", { desc = 'Spider-b' })
keymap('i', '<C-w>', "<Esc>l<cmd>lua require('spider').motion('w')<CR>i")
keymap('i', '<C-b>', "<Esc><cmd>lua require('spider').motion('b')<CR>i")

local function elegant_buffer_split()
  local current_buf = vim.api.nvim_get_current_buf()
  local buffers = vim.tbl_filter(function(b) return vim.api.nvim_buf_is_valid(b) and vim.bo[b].buflisted end, vim.api.nvim_list_bufs())
  local next_buf
  for i, buf in ipairs(buffers) do
    if buf == current_buf then
      next_buf = buffers[i % #buffers + 1]
      break
    end
  end
  next_buf = next_buf or current_buf
  local win = vim.api.nvim_get_current_win()
  vim.cmd('split')
  local new_win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(new_win, next_buf)
  vim.api.nvim_set_current_win(win)
  vim.api.nvim_win_set_buf(win, current_buf)
end

-- Set the keymapping
keymap('n', '<C-M-l>', function()
  -- If no window is opened horz
  elegant_buffer_split()
  vim.cmd('wincmd p')
end, { noremap = false, desc = 'Elegant buffer split' })

local function close_and_next_quickfix()
  local current_buf = vim.api.nvim_get_current_buf()
  local qf_list = vim.fn.getqflist()
  local qf_size = #qf_list
  local current_qf_idx = vim.fn.getqflist({ idx = 0 }).idx
  vim.cmd(fmt('silent %s', current_qf_idx < qf_size and 'cnext' or 'cfirst'))
  local new_buf = vim.api.nvim_get_current_buf()
  if current_buf ~= new_buf then vim.cmd('bdelete ' .. current_buf) end
end

local function close_and_prev_quickfix()
  local current_buf = vim.api.nvim_get_current_buf()
  local current_qf_idx = vim.fn.getqflist({ idx = 0 }).idx
  if current_qf_idx > 1 then
    vim.cmd('silent cprev')
  else
    vim.cmd('silent clast') -- Loop to the last item if at the beginning
  end
  local new_buf = vim.api.nvim_get_current_buf()
  if current_buf ~= new_buf then vim.cmd('bdelete ' .. current_buf) end
end

-- Keymappings
vim.keymap.set('n', '<M-n>', close_and_next_quickfix, { desc = 'Close and preview next quickfix item' })
vim.keymap.set('n', '<M-p>', close_and_prev_quickfix, { desc = 'Close and preview previous quickfix item' })

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

-- Treesitter selection
keymap('v', '<C-j>', function() require('nvim-treesitter.incremental_selection').init_selection() end, { desc = 'Initialize incremental selection' })
keymap('v', '<C-j>', function() require('nvim-treesitter.incremental_selection').node_incremental() end, { desc = 'Increment selection' })

keymap('v', '<C-k>', function() require('nvim-treesitter.incremental_selection').node_decremental() end, { desc = 'Decrement selection' })

-- Alignment
keymap('x', 'aa', function() require('align').align_to_char({ length = 1 }) end, { desc = 'Align to character' })
keymap('x', 'as', function() require('align').align_to_string({ preview = false, regex = true }) end, { desc = 'Align to string with regex' })

-- Commenting
keymap('i', '<C-/>', function() vim.api.nvim_input('<C-o>A') end, { desc = 'Toggle comment in insert mode' })
keymap('n', '<C-/>', require('Comment.api').toggle.linewise.current, { desc = 'Toggle comment in normal mode' })
keymap('v', '<C-/>', require('Comment.api').call('toggle.linewise', 'g@'), { desc = 'Toggle comment in visual mode', expr = true })

-- Join/split lines
keymap({ 'n' }, '<S-k>', function() require('treesj').toggle({ split = { recursive = true } }) end, { desc = 'Join (Treesj)' })

-- Parameter manipulation
keymap('n', '<M-[>', ':TSTextobjectSwapPrevious @parameter.inner<cr>', { desc = 'Swap previous parameter (Treesitter)' })
keymap('n', '<M-]>', ':TSTextobjectSwapNext @parameter.inner<cr>', { desc = 'Swap next parameter (Treesitter)' })

-- Search and replace
keymap('v', '<S-d>', '//dgn', { desc = 'Delete next match', noremap = false })
keymap('v', '<S-n>', '//cgn', { desc = 'Change next match', noremap = false })

vim.keymap.set('v', '<leader>s', function()
  local s_start = vim.fn.getpos("'<")
  local s_end = vim.fn.getpos("'>")
  local n_lines = math.abs(s_end[2] - s_start[2]) + 1
  local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
  lines[1] = string.sub(lines[1], s_start[3], -1)
  if n_lines == 1 then
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
  else
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
  end
  local selection = table.concat(lines, '\n')
  selection = vim.fn.escape(selection, [[/\]])

  vim.api.nvim_feedkeys(':' .. selection .. '/', 'n', false)
end, { noremap = true, silent = true, desc = 'Substitute visual selection' })

-- Clipboard operations
keymap({ 'v', 'n' }, '<C-v>', '"+p', { desc = 'Paste from + register' })
keymap('i', '<C-v>', '<C-r>+', { desc = 'Paste from + register' })
keymap('v', '<C-c>', '"+y', { desc = 'Yank to + register' })

-- Misc text operations
keymap('v', '.', ':normal .<cr>', { desc = 'Repeat across lines' })
keymap('x', 'x', '<S-j>', { desc = 'Collapse line in visual mode' })

-- [ File and Buffer Management ] ----------------------------

-- File operations
keymap('n', '<M-s>', '<cmd>silent w<cr>', { desc = 'Save file' })

-- Buffer navigation
keymap('n', '<S-l>', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next buffer (Bufferline)' })
keymap('n', '<S-h>', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Previous buffer (Bufferline)' })
keymap('n', '<S-x>', '<cmd>Bd<cr>', { desc = 'Close buffer (Bufferline)' })
keymap('n', '<Tab>', '<Nop>', { desc = 'Disable default tab behavior' })
keymap('n', '<Tab>', '<cmd>BufferLinePick<cr>', { desc = 'Pick buffer (Bufferline)' })
keymap('n', '<C-CR>', '<C-^>', { desc = 'Alternate buffers' })
keymap('n', '<M-1>', '<cmd>BufferLineGoToBuffer 1<cr>')
keymap('n', '<M-2>', '<cmd>BufferLineGoToBuffer 2<cr>')
keymap('n', '<M-3>', '<cmd>BufferLineGoToBuffer 3<cr>')

-- Window management
keymap('n', '<M-CR>', '<cmd>split<cr>', { desc = 'Split window' })

-- [ UI Toggles and Navigation ] ----------------------------

-- Trouble
keymap({ 'n', 'i' }, '<M-i>', '<cmd>Trouble symbols toggle focus=true win.position=left<cr>', { desc = 'Toggle Trouble' })

-- Trouble
keymap({ 'n', 'i' }, '<M-w>', '<cmd>Trouble lsp_document_symbols toggle focus=true win.position=left<cr>', { desc = 'Toggle Trouble' })

-- Neo-tree
keymap('n', '<M-e>', function()
  local width = vim.o.columns
  require('neo-tree.command').execute({
    source = 'last',
    position = width > 120 and 'left' or 'bottom',
    toggle = true,
  })
end, { desc = 'Toggle Neo-tree' })

-- Telescope
keymap('n', '<C-f>', function() pickers.open({ hidden = true, picker = 'find_files' }) end, { desc = 'Find files (Telescope)' })
keymap('n', '<leader>fs', function() pickers.symbols() end, { desc = 'Find document symbols (Telescope)' })

-- Search and replace
keymap('n', '<M-s>', function() require('grug-far').grug_far({ prefills = { search = vim.fn.expand('<cword>') } }) end)
keymap('v', '<M-s>', function() require('grug-far').with_visual_selection() end)

-- Folding
keymap('n', 'zh', 'za', { desc = 'Toggle fold' })
keymap('n', 'zl', 'zA', { desc = 'Toggle all folds' })

-- Trouble
create_autocmd('FileType', {
  pattern = { 'trouble' },
  callback = function()
    keymap('n', 'zh', 'zM', { desc = 'Toggle fold' })
    keymap('n', 'zl', 'zi', { desc = 'Toggle all folds' })
  end,
})

-- [ Window and Split Management ] ----------------------------

-- Smart Splits
keymap({ 'n', 't' }, '<C-h>', require('smart-splits').move_cursor_left, { desc = 'Move cursor left (Smart Splits)' })
keymap({ 'n', 't' }, '<C-j>', require('smart-splits').move_cursor_down, { desc = 'Move cursor down (Smart Splits)' })
keymap({ 'n', 't' }, '<C-k>', require('smart-splits').move_cursor_up, { desc = 'Move cursor up (Smart Splits)' })
keymap({ 'n', 't' }, '<C-l>', require('smart-splits').move_cursor_right, { desc = 'Move cursor right (Smart Splits)' })

keymap('n', '<M-S-h>', require('smart-splits').resize_left, { desc = 'Resize split left (Smart Splits)' })
keymap('n', '<M-S-j>', require('smart-splits').resize_down, { desc = 'Resize split down (Smart Splits)' })
keymap('n', '<M-S-k>', require('smart-splits').resize_up, { desc = 'Resize split up (Smart Splits)' })
keymap('n', '<M-S-l>', require('smart-splits').resize_right, { desc = 'Resize split right (Smart Splits)' })

-- [ Terminal Integration ] ----------------------------

-- Terminal mappings
keymap({ 'n' }, '<M-.>', function() editor.terminals.yazi_toggle() end)

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

keymap('t', '<C-v>', function()
  local register = vim.fn.getreg('+'):gsub('\n', '<cr>')
  vim.api.nvim_paste(register, true, -1)
end, { desc = 'Paste in terminal' })

-- [ LSP and Debugging ] ----------------------------

-- LSP keymaps
create_autocmd('LspAttach', {
  callback = function()
    -- Go to definition
    keymap('n', 'gd', function()
      vim.lsp.buf.definition({
        on_list = function(options)
          vim.fn.setqflist({}, ' ', options)
          vim.api.nvim_command('cfirst')
        end,
      })
    end, { desc = 'Go to definition (LSP)', buffer = true })

    -- References list
    keymap('n', 'gr', '<cmd>Trouble lsp_references focus=true<cr>', { desc = 'Show references (Trouble)' })
    keymap('n', 'gR', '<cmd>Glance references<cr>', { desc = 'Glance references (Glance)' })
    -- keymap('n', '?', function() vim.lsp.buf.hover() end, { desc = 'Show hover information (LSP)', buffer = true })
    keymap('n', '<S-k>', function() require('pretty_hover').hover() end, { desc = 'Show hover information (LSP)', buffer = true })
    keymap('n', '<C-.>', ky.custom_menus.code_action, { desc = 'Show code actions (LSP)', buffer = true })

    -- Debugging
    keymap('n', 'gp', 'g?p', { noremap = false, desc = 'Print variable' })
  end,
})

-- Open links
keymap('n', 'gl', function()
  local link = tostring(vim.fn.expand('<cfile>'))
  if not link:match('^https?://') and not link:match('^github.com/') then
    vim.notify('Not a valid link: ' .. link)
  else
    vim.system({ 'firefox', link })
  end
end, { desc = 'Open link' })

-- [ Miscellaneous ] ----------------------------

keymap({ 'n', 'v' }, '<C-b>', '<C-v>', { desc = 'Block selection' })
keymap('n', '<C-I>', '<C-I>', { desc = 'Jump to last jump' })
