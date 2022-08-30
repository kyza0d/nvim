-- Toggle hlsearch
keymap("n", "\\", ":set invhlsearch<cr>")

-- Highlight selected text https://vim.fandom.com/wiki/Search_for_visually_selected_text#
keymap("v", "//", [[y/\V<C-R>=escape(@",'/\')<CR><CR>:set hlsearch<CR>N]])

-- Change go next
keymap("v", "<C-d>", "//dgn", { noremap = false })
keymap("v", "<C-n>", "//cgn", { noremap = false })

-- Copy / paste
keymap({ "n", "v" }, "<C-c>", '"+y')
keymap({ "i", "c" }, "<C-v>", "<C-r><C-p>+")
keymap({ "n", "v" }, "<C-v>", '"+p')

-- Previous buffer
keymap("n", "<C-CR>", "<C-^>", { silent = false })

-- Vertical movement
keymap("n", "<C-u>", "2<C-y>")
keymap("n", "<C-d>", "2<C-e>")

-- Block selection
keymap({ "n", "v" }, "<C-b>", "<C-v>")

-- Start and end of line
keymap({ "n", "v" }, "<C-l>", "$")
keymap({ "n", "v" }, "<C-h>", "^")
keymap({ "n", "v" }, "<C-l>", "$")
