-- Toggle hlsearch
keymap("n", "\\", ":set invhlsearch<cr>")

-- Highlight selected text https://vim.fandom.com/wiki/Search_for_visually_selected_text#
keymap("v", "//", [[y/\V<C-R>=escape(@",'/\')<CR><CR>:set hlsearch<CR>N]])

-- Change go next
keymap("v", "<C-d>", "//dgn", { noremap = false })
keymap("v", "<C-n>", "//cgn", { noremap = false })

-- Left / right for insert mode
keymap("i", "<C-l>", "<Right>")
keymap("i", "<C-h>", "<Left>")

-- Copy
keymap({ "n", "v" }, "<C-c>", '"+y')

-- Paste
keymap({ "i", "c" }, "<C-v>", "<C-r><C-p>+")
keymap({ "n", "v" }, "<C-v>", '"+p')
keymap({ "i", "s" }, "<C-p>", "<C-r>0")

-- Start / end of line
keymap({ "n", "v" }, "<C-l>", "$")
keymap({ "n", "v" }, "<C-h>", "^")

-- Start / end of line for normal commands
keymap("c", "<C-l>", "$", { silent = false })
keymap("c", "<C-h>", "^", { silent = false })

-- Block selection
keymap({ "n", "v" }, "<C-b>", "<C-v>")

-- Previous buffer
keymap("n", "<C-CR>", "<C-^>")

-- Other pair
keymap({ "n", "v" }, "<C-j>", "%")

-- Other pair
keymap("n", "<C-p>", ':lua require("telescope.builtin").find_files(_pager())<cr>')
keymap("n", "?", ":Telescope live_grep<cr>")

-- Vertical movement
keymap("n", "<C-u>", "2<C-y>")
keymap("n", "<C-d>", "2<C-e>")

-- Folding
keymap("n", "<C-s-h>", ":foldclose<cr>")
keymap("n", "<C-s-l>", ":foldopen<cr>")

-- Toggle filetree
keymap("n", "<C-n>", ":Neotree focus toggle<cr>")

-- Language Server
keymap("n", "gd", ":lua vim.lsp.buf.declaration()<cr>")
keymap("n", "gr", ":Trouble lsp_references<cr>")
keymap("n", "gR", ":lua vim.lsp.buf.rename()<cr>")
keymap("n", "<S-k>", ":lua vim.lsp.buf.hover()<cr>")
keymap("n", "<C-S-k>", ":lua vim.diagnostic.open_float()<cr>")
keymap("n", ">", ":lua vim.lsp.buf.code_action()<cr>")
