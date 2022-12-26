vim.g.mapleader = " "
vim.g.maplocalleader = " "

local get_buf_info = require("utils.get_buf_info")

-- Search for visually selected text
-- https://vim.fandom.com/wiki/Search_for_visually_selected_text
keymap("v", "//", [[y/\V<C-R>=escape(@",'/\')<CR><CR>:set hlsearch<CR>N]], { desc = "Search for visually selected text" })

-- Delete / Change go next
keymap("v", "<C-n>", "//cgn", { noremap = false, desc = "Change go next" })
keymap("v", "<C-d>", "//dgn", { noremap = false, desc = "Delete go next" })

-- Copying / Pasting
keymap({ "n", "v" }, "<C-c>", '"+y', { desc = "Copy to clipboard" })
keymap({ "i", "c" }, "<C-v>", "<C-r><C-p>+", { desc = "Paste from clipboard" })
keymap({ "n", "v" }, "<C-v>", '"+p', { desc = "Paste from clipboard" })
keymap({ "i", "s" }, "<C-p>", "<C-r>0", { desc = [[Paste from  "0" register]] })

-- Block selection
keymap({ "n", "v" }, "<C-b>", "<C-v>", { desc = "Block selection" })

-- Movement
keymap({ "n", "v" }, "<C-l>", "$", { desc = "Move to end of line" })
keymap({ "n", "v" }, "<C-h>", "^", { desc = "Move to start of line" })
keymap({ "n", "v" }, "<C-j>", "%", { desc = "Move to matching character" })
keymap("n", "<C-u>", "10<C-y>", { desc = "Move 10 lines up" })
keymap("n", "<C-d>", "10<C-e>", { desc = "Move 10 lines down" })
keymap("i", "<C-l>", "<Right>")
keymap("i", "<C-h>", "<Left>")

-- Command-line Movement
keymap("c", "<C-h>", "<S-Left>", { silent = false, desc = "Move cursor left" })
keymap("c", "<C-l>", "<S-Right>", { silent = false, desc = "Move cursor right" })
keymap("c", "<C-j>", "<Left>", { silent = false })
keymap("c", "<C-k>", "<Right>", { silent = false })

-- Buffer
keymap("n", "<S-q>", function()
  vim.api.nvim_command("Bdelete")
  if get_buf_info("$").name == "" then
    vim.api.nvim_command("q!")
  end
end, { desc = "Save and quit", silent = false })

keymap("n", "<S-l>", "<cmd>silent BufferLineCycleNext<cr>", { desc = "Next buffer" })
keymap("n", "<S-h>", "<cmd>silent BufferLineCyclePrev<cr>", { desc = "Previous buffer" })
keymap("n", "<C-CR>", "<C-^>", { desc = "Switch to last buffer" })
keymap("n", "<S-w>", ":silent w<cr>", { desc = "Save" })

-- Folding
keymap("n", "<C-s-h>", "<cmd>foldclose<cr>", { desc = "Close fold" })
keymap("n", "<C-s-l>", "<cmd>foldopen<cr>", { desc = "Open fold" })

-- Repeat macro on lines
keymap("v", ".", ":norm @a<cr>", { desc = "Repeat macro on lines" })

-- Easy align
keymap("x", "aa", [[<cmd>lua require("align").align_to_char(1, true)<cr>]], { desc = "Align" })
keymap("x", "as", [[<cmd>lua require("align").align_to_string(false, true, true)<cr>]], { desc = "Align" })

-- Editing
keymap("i", "<C-CR>", "<C-o>o", { desc = "Insert new line below" })
keymap("i", "<C-S-CR>", "<C-o>O", { desc = "Insert new line above" })

-- Toggle highlight
keymap("n", "\\", ":set invhlsearch<cr>", { desc = "Toggle highlight" })

-- Toggle Neotree
keymap("n", "<C-n>", ":Neotree focus toggle<cr>", { desc = "Toggle Neotree" })

-- Go preview
keymap("n", "gp", ":Gitsigns preview_hunk<cr>", { desc = "Preview diff" })
keymap("n", "gn", ":Gitsigns next_hunk<cr>", { desc = "Next diff" })
keymap("n", "gN", ":Gitsigns prev_hunk<cr>", { desc = "Previous diff" })

-- Commenting
keymap("i", "<C-/>", "<esc>:norm gcA<cr>a", { desc = "Comment line" })
keymap("n", "<C-/>", ":lua require('Comment.api').toggle_current_linewise()<cr>", { desc = "Comment line" })
keymap("v", "<C-/>", ":lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<cr>", { desc = "Comment line" })

-- Go next diagnostic
keymap("n", "-", ":lua vim.diagnostic.goto_prev()<cr>", { desc = "Go to previous diagnostic" })
keymap("n", "=", ":lua vim.diagnostic.goto_next()<cr>", { desc = "Go to next diagnostic" })

local function on_list(options)
  vim.fn.setqflist({}, " ", options)
  vim.api.nvim_command("cfirst")
  vim.api.nvim_command("norm zz")
end

vim.keymap.set("n", "gd", function()
  vim.lsp.buf.definition({ on_list = on_list })
end, { desc = "Go to definition" })

keymap("n", "gR", ":lua vim.lsp.buf.rename()<cr>", { desc = "Rename" })
keymap("n", "<S-k>", ":lua vim.lsp.buf.hover()<cr>", { desc = "Hover" })
keymap("n", "<C-S-k>", ":lua vim.diagnostic.open_float()<cr>", { desc = "Show diagnostics" })
keymap("n", ">", ":lua vim.lsp.buf.code_action()<cr>", { desc = "Code action" })
