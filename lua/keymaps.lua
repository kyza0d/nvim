-------------------------------
-- Keymaps
-------------------------------

-- github/copilot.vim
keymap('i', '<C-J>', "copilot#Accept('<CR>')", { silent = true, expr = true })

-- nvim-telescope/telescope.nvim
-- keymap('n', '<C-f>', ":lua require('telescope.builtin').find_files({prompt_title = 'Jump to file'})<cr>")
local pickers = require('config.telescope.pickers')
keymap('n', '<C-f>', function() pickers.prettyFilesPicker({ picker = 'find_files' }) end)
keymap('n', '<leader>fb', function() pickers.prettyBuffersPicker() end)
keymap('n', '<leader>fs', function() pickers.prettyDocumentSymbols() end)
keymap('n', '<leader>ws', function() pickers.prettyWorkspaceSymbols() end)

keymap('n', '<C-.>', function() pickers.prettyGrepPicker({ picker = 'live_grep' }) end)

-- nvim-neo-tree/neo-tree.nvim
keymap('n', '<C-e>', ':Neotree toggle left source=last<cr>')

-- akinsho/bufferline.nvim
keymap('n', '<C-S-h>', ':silent BufferLineMovePrev<cr>')
keymap('n', '<C-S-l>', ':silent BufferLineMoveNext<cr>')
keymap('n', '<S-h>', ':silent BufferLineCyclePrev<cr>')
keymap('n', '<S-l>', ':silent BufferLineCycleNext<cr>')

keymap('n', '<cr>1', '<cmd>lua require("bufferline").go_to(1, true)<cr>')
keymap('n', '<cr>2', '<cmd>lua require("bufferline").go_to(2, true)<cr>')
keymap('n', '<cr>3', '<cmd>lua require("bufferline").go_to(3, true)<cr>')
keymap('n', '<cr>4', '<cmd>lua require("bufferline").go_to(4, true)<cr>')
keymap('n', '<cr>5', '<cmd>lua require("bufferline").go_to(5, true)<cr>')

-- Alternate buffers
keymap('n', '<C-CR>', '<C-^>', { desc = 'Switch to last buffer' })

-- echasnovski/mini.comment
keymap('n', '<C-/>', 'gcc')

-- Vonr/align.nvim
keymap('x', 'as', function() require('align').align_to_char(1, true) end)

-- dnlhc/glance.nvim
keymap('n', 'gR', '<cmd>Glance references<cr>')

-- RRethy/vim-illuminate
keymap('n', '<C-n>', function() require('illuminate').goto_next_reference(true) end, { nowait = true })
keymap('n', '<C-p>', function() require('illuminate').goto_prev_reference(true) end, { nowait = true })

-------------------------------
-- LSP
-------------------------------

create_autocmd('LspAttach', {
  callback = function()
    keymap('n', 'gd', function()
      vim.lsp.buf.definition({
        on_list = function(options)
          vim.fn.setqflist({}, ' ', options)
          vim.api.nvim_command('cfirst')
        end,
      })
    end, { buffer = true })

    -- References
    keymap('n', 'gr', function() require('trouble').toggle('lsp_references') end, { buffer = true })

    -- Show diagnostic
    keymap('n', '?', function() vim.diagnostic.open_float() end, { buffer = true })
    keymap('n', 'K', function() vim.lsp.buf.hover() end, { buffer = true })

    --- Code actions
    keymap('n', '>', ky.custom_menus.code_action, { buffer = true })
  end,
})

-------------------------------
-- Utilities
-------------------------------

-- Search for visually selected text
-- https://vim.fandom.com/wiki/Search_for_visually_selected_text
keymap('v', '//', [[y/\V<C-R>=escape(@",'/\')<CR><CR>:set hlsearch<CR>N]])

-- Toggle highlight
keymap('n', '\\', ':set invhlsearch<cr>')

-- Quit Buffer
keymap('n', '<S-q>', ':Bd<cr>', { desc = 'Save and quit' })
-- keymap('n', '<S-q>', ':bd<cr>', { desc = 'Save and quit', silent = false })

-- Quit Neovim
keymap('n', 'Z', 'ZZ', { desc = 'Save and quit', silent = false })

-------------------------------
-- Editing
-------------------------------
-- Change / Delete go next
keymap('v', '<C-n>', '//cgn', { noremap = false })
keymap('v', '<C-d>', '//dgn', { noremap = false })

-- Copying / Pasting
keymap({ 'n', 'v' }, '<C-c>', '"+y')
keymap({ 'i', 'c' }, '<C-v>', '<C-r><C-p>+')
keymap({ 'n', 'v' }, '<C-v>', '"+p')
keymap({ 'i', 's' }, '<C-p>', '<C-r>0')

-- Repeat across lines
keymap('v', '.', ':normal .<cr>', { desc = 'Repeat .' })
keymap('v', '@a', ':normal @a<cr>', { desc = 'Repeat macro' })

-- Block selection
keymap({ 'n', 'v' }, '<C-b>', '<C-v>')

-- Command line movement
keymap('c', '<C-h>', '<Left>', { silent = false })
keymap('c', '<C-l>', '<Right>', { silent = false })

------------------------------------------------------------------------------
-- Moving lines/visual block
------------------------------------------------------------------------------
-- source: https://www.reddit.com/r/vim/comments/i8b5z1/is_there_a_more_elegant_way_to_move_lines_than_eg/
keymap('x', '<M-j>', ":move'>+<CR>='[gv", { silent = true })
keymap('x', '<M-k>', ":move-2<CR>='[gv", { silent = true })
keymap('n', '<M-j>', '<cmd>move+<CR>==')
keymap('n', '<M-k>', '<cmd>move-2<CR>==')

-- Insert new lines
keymap('i', '<C-CR>', '<C-o>o', { desc = 'Insert new line below' })
keymap('i', '<C-S-CR>', '<C-o>O', { desc = 'Insert new line above' })

-- Enter Normal mode from terminal
keymap('t', '<C-[>', '<cmd>stopinsert<cr>', { noremap = true })

-------------------------------
-- Movement
-------------------------------

-- Start / end of line
keymap({ 'n', 'v' }, '<C-l>', '$', { desc = 'end of line' })
keymap({ 'n', 'v' }, '<C-h>', '^', { desc = 'start of line' })

-- Vertical movement
keymap('n', '<C-u>', '4<C-y>', { desc = 'Move 10 lines up' })
keymap('n', '<C-d>', '4<C-e>', { desc = 'Move 10 lines down' })
