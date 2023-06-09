-------------------------------
-- Plugin mappings
-------------------------------

-- github/copilot.vim
keymap("i", "<C-J>", "copilot#Accept('<CR>')", { silent = true, expr = true })

-- nvim-neo-tree/neo-tree.nvim
keymap("n", "<C-n>", ":Neotree left toggle filesystem<cr>")

-- nvim-telescope/telescope.nvim
keymap("n", "<C-p>", ":lua require('telescope.builtin').find_files()<cr>")

-- akinsho/bufferline.nvim
keymap("n", "<S-l>", "<cmd>silent BufferLineCycleNext<cr>")
keymap("n", "<S-h>", "<cmd>silent BufferLineCyclePrev<cr>")
keymap("n", "<C-S-h>", "<cmd>silent BufferLineMovePrev<cr>")
keymap("n", "<C-S-l>", "<cmd>silent BufferLineMoveNext<cr>")

-- echasnovski/mini.comment
keymap("n", "<C-/>", "gcc")

-- Vonr/align.nvim
keymap("x", "as", function()
  require("align").align_to_char(1, true)
end)

-- Vonr/align.nvim
keymap("x", "ae", function()
  require("align").align_to_string(2, true)
end)

-- dnlhc/glance.nvim
keymap("n", "gr", "<cmd>Glance references<cr>")

-- smjonas/inc-rename.nvim
keymap("n", "gR", function()
  return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true })

-------------------------------
-- LSP
-------------------------------

create_autocmd("LspAttach", {
  callback = function()
    -- Preform code action
    keymap("n", ">", function()
      vim.lsp.buf.code_action()
    end, { buffer = true })

    keymap("n", "gd", function()
      vim.lsp.buf.definition({
        on_list = function(options)
          vim.fn.setqflist({}, " ", options)
          vim.api.nvim_command("cfirst")
        end,
      })
    end, { buffer = true })

    -- Show hover
    keymap("n", "<S-k>", function()
      vim.lsp.buf.hover()
    end, { buffer = true })

    -- Show diagnostic
    keymap("n", "<C-k>", function()
      vim.diagnostic.open_float()
    end, { buffer = true })
  end,
})

-------------------------------
-- Utilities
-------------------------------

-- Search for visually selected text
-- https://vim.fandom.com/wiki/Search_for_visually_selected_text
keymap("v", "//", [[y/\V<C-R>=escape(@",'/\')<CR><CR>:set hlsearch<CR>N]])

-- Toggle highlight
keymap("n", "\\", ":set invhlsearch<cr>")

-- Folding
keymap("n", "[[", ":foldclose<cr>", { nowait = true, noremap = true })
keymap("n", "]]", ":foldopen<cr>", { nowait = true, noremap = true })

-- Quit Buffer
keymap("n", "<S-q>", ":Bd<cr>", { desc = "Save and quit", silent = false })

-- Quit Neovim
keymap("n", "Z", "ZZ", { desc = "Save and quit", silent = false })

-------------------------------
-- Editing
-------------------------------

-- Change / Delete go next
keymap("v", "<C-n>", "//cgn", { noremap = false })
keymap("v", "<C-d>", "//dgn", { noremap = false })

-- Copying / Pasting
keymap({ "n", "v" }, "<C-c>", '"+y')
keymap({ "i", "c" }, "<C-v>", "<C-r><C-p>+")
keymap({ "n", "v" }, "<C-v>", '"+p')
keymap({ "i", "s" }, "<C-p>", "<C-r>0")

-- Block selection
keymap({ "n", "v" }, "<C-b>", "<C-v>")

-- Substitue selected text
keymap("n", "<C-s>", function()
  return string.format(":s/%s//g<Left><Left>", vim.fn.expand("<cword>"))
end, { silent = false, expr = true })

keymap("v", "<C-s>", function()
  return [["_y:%s/\%V<C-R>"//g<Left><Left>]]
end, { silent = false, expr = true })

-- Command line movement
keymap("c", "<C-h>", "<Left>", { silent = false })
keymap("c", "<C-l>", "<Right>", { silent = false })

-- Repeat "a" macro on selected lines
keymap("v", "a", ":normal @a<cr>", { desc = "Repeat macro on selected lines" })

-- Insert new lines
keymap("i", "<C-CR>", "<C-o>o", { desc = "Insert new line below" })
keymap("i", "<C-S-CR>", "<C-o>O", { desc = "Insert new line above" })

-------------------------------
-- Movement
-------------------------------

-- Start / end of line
keymap({ "n", "v" }, "<C-l>", "$", { desc = "Move to end of line" })
keymap({ "n", "v" }, "<C-h>", "^", { desc = "Move to start of line" })

-- Move to matching character
keymap({ "n", "v" }, "<C-j>", "%", { desc = "Move to matching character" })

-- Vertical movement
keymap("n", "<C-u>", "10<C-y>", { desc = "Move 10 lines up" })
keymap("n", "<C-d>", "10<C-e>", { desc = "Move 10 lines down" })

-- Alternate buffers
keymap("n", "<C-CR>", "<C-^>", { desc = "Switch to last buffer" })
