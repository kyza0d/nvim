local M = {}
local keymap = require("utils").keymap
-- local nui_lsp = require("plugin.nui.nui_lsp").lsp_rename

-- Space for leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("n", "<F2>", ":lua _lazygit:toggle()")
keymap("n", "<F3>", ":lua _spotify:toggle()")

-- Bufferline
keymap("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>")
keymap("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>")
keymap("n", "<S-d>", "<cmd>Bdelete<cr>")

-- Incremenal Selection
keymap("v", "<C-j>", ":lua require('nvim-treesitter.incremental_selection').node_incremental()")
keymap("v", "<C-k>", ":lua require('nvim-treesitter.incremental_selection').node_decremental()")

-- Git signs
keymap("n", "<A-p>", ":Gitsigns preview_hunk")
keymap("n", "<A-[>", ":Gitsigns prev_hunk")
keymap("n", "<A-]>", ":Gitsigns next_hunk")

keymap("i", "<C-l>", "<Right>")
keymap("i", "<C-h>", "<Left>")

-- LSP
keymap("n", "[d", ":lua vim.diagnostic.goto_prev()")
keymap("n", "]d", ":lua vim.diagnostic.goto_next()")
keymap("n", "gR", ":lua vim.lsp.buf.rename()")
keymap("n", ">", ":lua vim.lsp.buf.code_action()")
keymap("n", "K", ":lua vim.lsp.buf.hover()")
keymap("n", "gd", ":lua vim.lsp.buf.definition()")

-- Trouble lsp
keymap("n", "gr", ":Trouble lsp_references")
keymap("n", "gD", ":Trouble workspace_diagnostics")

-- Telescope
keymap({ "n", "v" }, "<C-p>", ':lua require("telescope.builtin").find_files(PREVIEW())')
keymap({ "n", "v" }, "?", ':lua require("telescope.builtin").live_grep(PREVIEW())')
-- keymap({ "n", "v" }, "/", ':lua require("telescope.builtin").current_buffer_fuzzy_find(DROPDOWN())')

-- Commenting
keymap("i", "<C-/>", "<esc>:norm gcA<cr>a")
keymap("n", "<C-/>", ":lua require('Comment.api').toggle_current_linewise()")
keymap("v", "<C-/>", ":lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())")

-- Toggle terminal
keymap("t", "<C-\\>", "<cmd>ToggleTerm<cr>", { noremap = true })
keymap("n", "<C-\\>", ":ToggleTerm")

-- Toggle filetree
-- keymap("n", "<C-n>", ":Neotree float focus toggle")
keymap("n", "<C-n>", ":Neotree focus toggle")

-- Folds
keymap("n", "<C-S-h>", ":foldclose")
keymap("n", "<C-S-l>", ":foldopen")

-- Toggle hlsearch
keymap("n", "\\", ":set invhlsearch")

-- Highlight selected text https://vim.fandom.com/wiki/Search_for_visually_selected_text#
keymap("v", "//", [[y/\V<C-R>=escape(@",'/\')<CR><CR>:set hlsearch<CR>N]])

-- Emulation of multicursor
keymap("v", "<C-d>", "//dgn", { noremap = false })
keymap("v", "<C-n>", "//cgn", { noremap = false })

-- Switch to previous buffer (Ctrl+Enter)
keymap("n", "<C-CR>", "<C-^>", { silent = false })

-- New lines
keymap("i", "<C-CR>", "<C-o>o")
keymap("i", "<C-S-CR>", "<C-o>O")

-- Copy to system clipboard
keymap({ "n", "v" }, "<C-c>", '"+y')

-- Paste from system clipboard
keymap({ "i", "c" }, "<C-v>", "<C-r><C-p>+")
keymap({ "n", "v" }, "<C-v>", '"+p')

-- Paste from register
keymap("i", "<C-p>", "<C-r><C-p>0", { silent = false })

-- Start and end of line
keymap({ "n", "v" }, "<C-l>", "$")
keymap({ "n", "v" }, "<C-h>", "^")
keymap({ "n", "v" }, "<C-l>", "$")

keymap({ "n", "v" }, "gg", ":1")

-- Block selection
keymap({ "n", "v" }, "<C-b>", "<C-v>")

-- Vertical movement
keymap("n", "<C-u>", "2<C-y>")
keymap("n", "<C-d>", "2<C-e>")

-- For ":norm" commands
keymap("c", "<C-l>", "$", { silent = false })

-- Repeat from insert mode
keymap("n", "<C-.>", "<Esc>.", { silent = false })
