local M = {}
local keymap = require("utils").keymap
-- local nui_lsp = require("plugin.nui.nui_lsp").lsp_rename

-- Space for leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bufferline
keymap("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>")
keymap("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>")
keymap("n", "<S-d>", "<cmd>Bdelete<cr>")

-- Incremenal Selection
keymap("v", "<C-j>", ":lua require('nvim-treesitter.incremental_selection').node_incremental()")
keymap("v", "<C-k>", ":lua require('nvim-treesitter.incremental_selection').node_decremental()")

keymap("x", "aa", function()
  require("align").align_to_char(1, true)
end)

-- Git signs
keymap("n", "<A-p>", ":Gitsigns preview_hunk")
keymap("n", "<A-[>", ":Gitsigns prev_hunk")
keymap("n", "<A-]>", ":Gitsigns next_hunk")

keymap("i", "<C-l>", "<Right>")
keymap("i", "<C-h>", "<Left>")

-- Hop Char
keymap("n", "s", ":HopChar1")

-- Zenmode
keymap("n", "<F11>", ":ZenMode")

-- Filetree

-- Telescope
keymap({ "n", "v" }, "<C-p>", ':lua require("telescope.builtin").find_files(PREVIEW())')

keymap({ "n", "v" }, "?", ':lua require("telescope.builtin").live_grep(PREVIEW())')

-- Commenting
keymap("i", "<C-/>", "<esc>:norm gcA<cr>a")
keymap("n", "<C-/>", ":lua require('Comment.api').toggle_current_linewise()")
keymap("v", "<C-/>", ":lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())")

-- Toggle terminal
keymap("n", "<F1>", ":lua lazygit_toggle()")
keymap("t", "<C-\\>", "<cmd>ToggleTerm<cr>", { noremap = true })
keymap("n", "<C-\\>", ":ToggleTerm")

-- Toggle filetree
keymap("n", "<C-n>", ":Neotree focus toggle")

keymap("n", "<C-S-h>", ":foldclose")
keymap("n", "<C-S-l>", ":foldopen")

keymap("n", "gd", function()
  vim.lsp.buf.definition()
end)

keymap("n", ">", function()
  vim.lsp.buf.code_action()
end)

keymap("n", "<S-k>", function()
  vim.lsp.buf.hover()
end)

keymap("n", "<C-s-k>", function()
  vim.diagnostic.open_float()
end)

-- keymap("n", "gR", require("plugin.nui").lsp_rename, { silent = false })
keymap("n", "gR", function()
  vim.lsp.buf.rename()
end)

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

keymap("n", "gr", ":Trouble lsp_references")

-- Copy to system clipboard
keymap({ "n", "v" }, "<C-c>", '"+y')

-- Paste from system clipboard
keymap({ "i", "c" }, "<C-v>", "<C-r><C-p>+")
keymap({ "n", "v" }, "<C-v>", '"+p')

-- Paste from register
keymap("i", "<C-p>", "<C-r><C-p>0", { silent = false })

-- keymap({ "n", "v" }, "<C-j>", "%")
keymap({ "n", "v" }, "<C-l>", "$")
keymap({ "n", "v" }, "<C-h>", "^")
keymap({ "n", "v" }, "<C-l>", "$")

keymap("n", "gg", ":1")

-- Block selection
keymap({ "n", "v" }, "<C-b>", "<C-v>")

-- Vertical movement
keymap("n", "<C-u>", "1<C-y>")
keymap("n", "<C-d>", "1<C-e>")

-- For ":norm" commands
keymap("c", "<C-l>", "$", { silent = false })
return M
