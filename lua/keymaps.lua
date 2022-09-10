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

-- Save Buffer
keymap("n", "<S-w>", ":w<cr>")

-- Other pair
keymap({ "n", "v" }, "<C-j>", "%")

-- Vertical movement
keymap("n", "<C-u>", "2<C-y>")
keymap("n", "<C-d>", "2<C-e>")

-- Folding
keymap("n", "<C-s-h>", ":foldclose<cr>")
keymap("n", "<C-s-l>", ":foldopen<cr>")
