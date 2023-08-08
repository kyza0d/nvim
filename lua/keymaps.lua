--------------------------------------------
-- Plugin Mappings
--------------------------------------------

-- github/copilot.vim
keymap('i', '<C-J>', "copilot#Accept('<CR>')", { silent = true, expr = true, desc = 'Accept Copilot suggestion' })

-- nvim-neo-tree/neo-tree.nvim
keymap('n', '<C-n>', ':Neotree toggle filesystem<cr>', { desc = 'Toggle Neotree filesystem' })

-- nvim-telescope/telescope.nvim
keymap('n', '<C-p>', ":lua require('telescope.builtin').find_files()<cr>", { desc = 'Search files with Telescope' })

-- echasnovski/mini.comment
keymap('n', '<C-/>', 'gcc', { desc = 'Toggle comment' })

-- Vonr/align.nvim
keymap(
  'x',
  'as',
  function() require('align').align_to_char(1, true) end,
  { desc = 'Align selected text to a character' }
)

-- dnlhc/glance.nvim
keymap('n', 'gr', '<cmd>Glance references<cr>', { desc = 'Glance at references' })

-- smjonas/inc-rename.nvim
keymap(
  'n',
  'gR',
  function() return ':IncRename ' .. vim.fn.expand('<cword>') end,
  { expr = true, desc = 'Incrementally rename' }
)

--------------------------------------------
-- Movement
--------------------------------------------

-- Folding
keymap('n', '<C-[>', ':foldclose<cr>', { desc = 'Close fold' })
keymap('n', '<C-]>', ':foldopen<cr>', { desc = 'Open fold' })

-- Command line movement
keymap('c', '<C-l>', '<Right>', { silent = false, desc = 'Move right in command line' })

--------------------------------------------
-- Language Server Protocol
--------------------------------------------

-- create_autocmd('LspAttach', {
--   callback = function()
--     -- Perform code action
--     keymap('n', '>', function() vim.lsp.buf.code_action() end, { buffer = true, desc = 'Perform LSP code action' })
--
--     keymap('n', 'gd', function()
--       vim.lsp.buf.definition({
--         on_list = function(options)
--           vim.fn.setqflist({}, ' ', options)
--           vim.api.nvim_command('cfirst')
--         end,
--       })
--     end, { buffer = true, desc = 'Go to LSP definition' })
--
--     -- Show hover
--     keymap('n', '<S-k>', function() vim.lsp.buf.hover() end, { buffer = true, desc = 'Show LSP hover' })

-- (Remaining LSP key mappings)

--------------------------------------------
-- Searching
--------------------------------------------

-- Search for visually selected text
keymap('v', '//', [[y/\V<C-R>=escape(@",'/\')<CR><CR>:set hlsearch<CR>N]], { desc = 'Search selected text' })

-- Toggle highlight
keymap('n', '\\', ':set invhlsearch<cr>', { desc = 'Toggle search highlight' })

--------------------------------------------
-- Buffer Management
--------------------------------------------

-- Change Buffer
keymap('n', '<S-l>', '<cmd>bn<cr>', { silent = true, desc = 'Move to next buffer' })
keymap('n', '<S-h>', '<cmd>bp<cr>', { silent = true, desc = 'Move to previous buffer' })

-- Alternate buffers
keymap('n', '<C-CR>', '<C-^>', { desc = 'Switch to alternate buffer' })

-- Move Buffers
keymap('n', '<C-S-h>', ':silent BufferLineMovePrev<cr>', { desc = 'Move buffer left' })
keymap('n', '<C-S-l>', ':silent BufferLineMoveNext<cr>', { desc = 'Move buffer right' })

-- Quit Buffer
-- (Description already provided)

-- Navigate Buffers
keymap({ 'n', 'v' }, '<cr>1', '<cmd>BufferLineGoToBuffer 1<cr>', { nowait = true, desc = 'Go to Buffer 1' })

--------------------------------------------
-- Editor Management
--------------------------------------------

-- Close Editor
-- (Description already provided)

-------------------------------
-- Text Manipulation
-------------------------------

-- Copying / Pasting
-- (Descriptions can be added like 'Copy to clipboard', 'Paste from clipboard', etc.)

-- Change / Delete go next
keymap('v', '<C-n>', '//cgn', { noremap = false, desc = 'Change to next match' })
keymap('v', '<C-d>', '//dgn', { noremap = false, desc = 'Delete next match' })

-- Substitute selected text
keymap(
  'n',
  '<C-s>',
  function() return string.format(':s/%s//g<Left><Left>', vim.fn.expand('<cword>')) end,
  { silent = false, expr = true, desc = 'Substitute word under cursor' }
)
keymap(
  'v',
  '<C-s>',
  function() return [["_y:%s/\%V<C-R>"//g<Left><Left>]] end,
  { silent = false, expr = true, desc = 'Substitute selected text' }
)

-------------------------------
-- Remaps
-------------------------------

-- Block selection
keymap({ 'n', 'v' }, '<C-b>', '<C-v>', { desc = 'Select block of text' })

-- Repeat "a" macro on selected lines
keymap('v', 'a', ':normal @a<cr>', { desc = 'Repeat macro on selected lines' })

-- Insert new lines
keymap('i', '<C-CR>', '<C-o>o', { desc = 'Insert new line below' })
keymap('i', '<C-S-CR>', '<C-o>O', { desc = 'Insert new line above' })
