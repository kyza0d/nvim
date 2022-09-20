-- Highlight selected text https://vim.fandom.com/wiki/Search_for_visually_selected_text#
keymap("v", "//", [[y/\V<C-R>=escape(@",'/\')<CR><CR>:set hlsearch<CR>N]])

-- stylua: ignore start
keymap("v", "<C-n>", "//cgn", { noremap = false }) -- Change go next
keymap("v", "<C-d>", "//dgn", { noremap = false }) -- Delete go next
keymap("v", "<C-i>", "//", { noremap = false })    -- Change at beginning of next
keymap("i", "<C-l>", "<Right>")                    -- Right for insert mode
keymap("i", "<C-h>", "<Left>")                     -- Left for insert mode

keymap({ "n", "v" }, "<C-c>", '"+y')               -- Copy
keymap({ "i", "c" }, "<C-v>", "<C-r><C-p>+")       -- Paste insert mode
keymap({ "n", "v" }, "<C-v>", '"+p')               -- Paste from "+
keymap({ "i", "s" }, "<C-p>", "<C-r>0")            -- Paste from "0

keymap({ "n", "v" }, "<C-b>", "<C-v>")             -- Block selection

keymap({ "n", "v" }, "<C-l>", "$")                 -- End of line
keymap({ "n", "v" }, "<C-h>", "^")                 -- Start of line

keymap("c", "<C-l>", "$", { silent = false })      -- End of line for normal commands
keymap("c", "<C-h>", "^", { silent = false })      -- Start of line for normal commands

keymap({ "n", "v" }, "s", "*")                     -- Next occurrence for word under cursor
keymap({ "n", "v" }, "S", "#")                     -- Previous occurrence for word under cursor

keymap("n", "<C-CR>", "<C-^>")                     -- Previous buffer
keymap("n", "<S-w>", ":w<cr>")                     -- Save Buffer
keymap({ "n", "v" }, "<C-j>", "%")                 -- Other pair

keymap("n", "<C-u>", "3<C-y>")                     -- 2 Lines up
keymap("n", "<C-d>", "3<C-e>")                     -- 2 Lines down

keymap("n", "<C-s-h>", ":foldclose<cr>")           -- Fold close
keymap("n", "<C-s-l>", ":foldopen<cr>")            -- Fold open

keymap("n", "\\", ":set invhlsearch<cr>")          -- Toggle hlsearch

keymap("i", "<C-o>", "<C-o>o")
keymap("i", "<C-S-o>", "<C-o>O")
