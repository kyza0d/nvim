local M = {}
local keymap = require("core.utils").keymap

-- Space for leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bufferline
keymap("n", "<Tab>", ":bn")
keymap("n", "<S-Tab>", ":bp")

-- Git signs
keymap("n", "<A-p>", ":Gitsigns preview_hunk")
keymap("n", "<A-[>", ":Gitsigns prev_hunk")
keymap("n", "<A-]>", ":Gitsigns next_hunk")

-- Zenmode
keymap("n", "<F11>", ":ZenMode")

-- Insert at end of lines
-- keymap("v", "<S-a>", ":norm A", "silent", "noremap", "no_cr" )

-- Emulation of multicursor
keymap("n", "<C-n>", ":NvimTreeToggle")

-- Telescope
keymap({ "n", "v" }, "<C-p>", ':lua require("telescope.builtin").find_files(DROPDOWN())')

keymap({ "n", "v" }, "?", ':lua require("telescope.builtin").live_grep(PREVIEW())')

-- Commenting
keymap("i", "<C-/>", "<esc>:norm gcA<cr>a")
keymap("n", "<C-/>", ":lua require('Comment.api').toggle_current_linewise()")
keymap("v", "<C-/>", ":lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())")

-- Toggle terminal
keymap("n", "<F1>", ":lua lazygit_toggle()")
keymap("t", "<C-\\>", "<cmd>ToggleTerm<cr>", { noremap = true })
keymap("n", "<C-\\>", ":ToggleTerm")
-- keymap("t", "<C-[>", "<C-\\><C-n>", { noremap = true })

keymap("n", "<C-S-h>", "zc")
keymap("n", "<C-S-l>", "za")

-- LSP
keymap("n", "gr", ":Trouble lsp_references")
keymap("n", "gd", ":Trouble definition")
keymap("n", ">", ":lua vim.lsp.buf.code_action()")
keymap("n", "K", ":lua vim.lsp.buf.hover()")

-- Toggle hlsearch
keymap("n", "\\", ":set invhlsearch")

-- Highlight selected text https://vim.fandom.com/wiki/Search_for_visually_selected_text#
keymap("v", "//", [[y/\V<C-R>=escape(@",'/\')<CR><CR>:set hlsearch<CR>N]])

-- Emulation of multicursor
keymap("v", "<C-d>", "//dgn", { noremap = false })
keymap("v", "<C-n>", "//cgn", { noremap = false })

-- keymap("n", "f", function()
--   local char = vim.fn.nr2char(vim.fn.getchar())
--   vim.api.nvim_feedkeys("f" .. char, "n", false)
--
--   print(char)
-- end)

-- Switch to previous buffer (Ctrl+Enter)
keymap("n", "<C-CR>", "<C-^>", { silent = false })

-- New lines
keymap("i", "<C-CR>", "<C-o>o")
keymap("i", "<C-S-CR>", "<C-o>O")

-- Copy to system clipboard
keymap({ "n", "v" }, "<C-c>", '"+y')

-- Paste from system clipboard
keymap({ "i", "c" }, "<C-v>", "<C-r>+")
keymap({ "n", "v" }, "<C-v>", '"+p')

-- Paste from register
keymap("i", "<C-p>", "<C-r>0", { silent = false })

-- Ctrl + j to %
keymap("v", "<C-j>", ":norm gv%")
keymap("n", "d<C-j>", ":norm d%")
keymap("n", "<C-j>", ":norm %")

keymap("n", "gg", ":1")

-- Block selection
keymap({ "n", "v" }, "<C-b>", "<C-v>")

-- Vertical movement
keymap("n", "<C-u>", "2<C-y>")
keymap("n", "<C-d>", "2<C-e>")

-- Start / end of line
keymap({ "n", "v" }, "<C-h>", "^")
keymap({ "n", "v" }, "<C-l>", "$")

-- For ":norm" commands
keymap("c", "<C-l>", "$", { silent = false })
return M
