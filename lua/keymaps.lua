vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Search for visually selected text
-- https://vim.fandom.com/wiki/Search_for_visually_selected_text
keymap("v", "//", [[y/\V<C-R>=escape(@",'/\')<CR><CR>:set hlsearch<CR>N]])

-- Substitute
-- keymap("n", "s", ":s/", { silent = false })
-- keymap("n", "S", ":norm &<cr>")

-- Repeat macro on lines
keymap("v", ".", ":norm @a<cr>")

-- Scratch
-- keymap("n", "<F1>", function()
--   vim.cmd("botright split") -- split bottom
--   vim.api.nvim_set_current_buf(vim.api.nvim_create_buf(false, true)) -- create new buffer
--   vim.lsp.buf_attach_client(0, 0) -- attach to client
--   vim.cmd("setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile") -- set buffer options
--   vim.cmd("file lua") -- set buffer name
--
--   vim.api.nvim_command("au QuitPre <buffer> set nomodified")
-- end)

-- Easy align

keymap("x", "aa", function()
  require("align").align_to_char(1, true)
end)

keymap("x", "as", function()
  require("align").align_to_string(false, true, true)
end)

-- Delete / Change go next
keymap("v", "<C-n>", "//cgn", { noremap = false })
keymap("v", "<C-d>", "//dgn", { noremap = false })

-- Copying / Pasting
keymap({ "n", "v" }, "<C-c>", '"+y')
keymap({ "i", "c" }, "<C-v>", "<C-r><C-p>+")
keymap({ "i", "s" }, "<C-p>", "<C-r>0")
keymap({ "n", "v" }, "<C-v>", '"+p')

-- Block selection
keymap({ "n", "v" }, "<C-b>", "<C-v>")

-- Movement
keymap({ "n", "v" }, "<C-l>", "$")
keymap({ "n", "v" }, "<C-h>", "^")
keymap("i", "<C-l>", "<Right>")
keymap("i", "<C-h>", "<Left>")
keymap({ "n", "v" }, "<C-j>", "%")
keymap("n", "<C-u>", "10<C-y>")
keymap("n", "<C-d>", "10<C-e>")

-- Command-line Movement
keymap("c", "<C-h>", "<S-Left>", { silent = false })
keymap("c", "<C-l>", "<S-Right>", { silent = false })
keymap("c", "<C-j>", "<Left>", { silent = false })
keymap("c", "<C-k>", "<Right>", { silent = false })

-- Buffer
keymap("n", "<S-w>", ":silent w<cr>")
keymap("n", "<C-CR>", "<C-^>")
keymap("n", "<C-s-h>", ":foldclose<cr>")
keymap("n", "<C-s-l>", ":foldopen<cr>")
keymap("n", "<S-q>", "ZZ")
keymap("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>")
keymap("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>")
keymap("n", "<S-d>", "<cmd>Bdelete!<cr>")

-- Editing
keymap("i", "<C-CR>", "<C-o>o")
keymap("i", "<C-S-CR>", "<C-o>O")

-- Toggle highlight
keymap("n", "\\", ":set invhlsearch<cr>")

-- Toggle Neotree
keymap("n", "<C-n>", ":Neotree focus toggle<cr>")

-- Go preview
keymap("n", "gp", ":Gitsigns preview_hunk<cr>")
keymap("n", "gn", ":Gitsigns next_hunk<cr>")
keymap("n", "gN", ":Gitsigns prev_hunk<cr>")

-- Commenting
keymap("i", "<C-/>", "<esc>:norm gcA<cr>a")
keymap("n", "<C-/>", ":lua require('Comment.api').toggle_current_linewise()<cr>")
keymap("v", "<C-/>", ":lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<cr>")

-- Go next diagnostic
keymap("n", "-", ":lua vim.diagnostic.goto_prev()<cr>")
keymap("n", "=", ":lua vim.diagnostic.goto_next()<cr>")

local function on_list(options)
  vim.fn.setqflist({}, " ", options)
  vim.api.nvim_command("cfirst")
  vim.api.nvim_command("norm zz")
end

vim.keymap.set("n", "gd", function()
  vim.lsp.buf.definition({ on_list = on_list })
end)

keymap("n", "gR", ":lua vim.lsp.buf.rename()<cr>")
keymap("n", "<S-k>", ":lua vim.lsp.buf.hover()<cr>")
keymap("n", "<C-S-k>", ":lua vim.diagnostic.open_float()<cr>")
keymap("n", ">", ":lua vim.lsp.buf.code_action()<cr>")
