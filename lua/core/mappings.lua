local keymap = function(modes, mapping, command, options)
  local default_opts = { noremap = true, silent = true, nowait = true }
  local keymap = type(command) == "function" and vim.keymap.set or vim.api.nvim_set_keymap

  options = options or {}
  options = vim.tbl_deep_extend("keep", {}, options, default_opts or {})

  if type(modes) == "table" then
    for _, mode in pairs(modes) do
      keymap(mode, mapping, command, options)
    end
  else
    keymap(modes, mapping, command, options)
  end
end

-- copilot.vim
keymap("i", "<C-J>", "copilot#Accept('<CR>')", { silent = true, expr = true })

-- neo-tree.nvim
keymap("n", "<C-n>", ":Neotree focus toggle<cr>", { desc = "Toggle Neotree" })

-- telescope.nvim
keymap("n", "<C-p>", function()
  require("telescope.builtin").find_files()
end)

-- bufferline.nvim
keymap("n", "<S-l>", "<cmd>silent BufferLineCycleNext<cr>", { desc = "Next buffer" })
keymap("n", "<S-h>", "<cmd>silent BufferLineCyclePrev<cr>", { desc = "Previous buffer" })

-- mini.comment
keymap("n", "<C-/>", "gcc", { desc = "Comment line" })

-- align.nvim
keymap("x", "as", function()
  require("align").align_to_char(1, true)
end)
keymap("x", "aa", function()
  require("align").align_to_char(2, true, true)
end)
keymap("x", "aw", function()
  require("align").align_to_string(false, true, true)
end)
keymap("x", "ar", function()
  require("align").align_to_string(true, true, true)
end)

-- ufo.nvim
keymap("n", "[[", ":foldclose<cr>", { desc = "Fold open" })
keymap("n", "]]", ":foldopen<cr>", { desc = "Fold close" })

-- LSP
keymap("n", "<C-S-j>", function()
  vim.diagnostic.open_float(nil, {
    focusable = true,
    close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    source = "always",
    prefix = " ",
  })
end)

keymap("n", "gd", function()
  vim.lsp.buf.definition({
    on_list = function(options)
      vim.fn.setqflist({}, " ", options)
      vim.api.nvim_command("cfirst")
      vim.api.nvim_command("norm zz")
    end,
  })
end, { desc = "Go to definition" })

-- Open documentation
keymap("n", "<S-k>", function()
  vim.lsp.buf.hover()
end, { desc = "Open documentation" })

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

-- Substitue selected text
keymap("v", "s", [["hy:%s/<C-r>h//gc<left><left><left>]], { desc = "Substitute selected text", silent = false })

-- Command line movement
keymap("c", "<C-h>", "<Left>", { silent = false })
keymap("c", "<C-l>", "<Right>", { silent = false })

-- Repeat "a" macro on selected lines
keymap("v", "a", ":normal @a<cr>", { desc = "Repeat macro on selected lines" })

-- Movement
keymap({ "n", "v" }, "<C-l>", "$", { desc = "Move to end of line" })
keymap({ "n", "v" }, "<C-h>", "^", { desc = "Move to start of line" })
keymap({ "n", "v" }, "<C-j>", "%", { desc = "Move to matching character" })
keymap("n", "<C-u>", "10<C-y>", { desc = "Move 10 lines up" })
keymap("n", "<C-d>", "10<C-e>", { desc = "Move 10 lines down" })
keymap("i", "<C-l>", "<Right>")
keymap("i", "<C-h>", "<Left>")

-- Alternate buffers
keymap("n", "<C-CR>", "<C-^>", { desc = "Switch to last buffer" })

-- Quit Buffer
keymap("n", "<S-q>", function()
  vim.api.nvim_command("Bd")
end, { desc = "Save and quit", silent = false })

-- Editing
keymap("i", "<C-CR>", "<C-o>o", { desc = "Insert new line below" })
keymap("i", "<C-S-CR>", "<C-o>O", { desc = "Insert new line above" })

-- Toggle highlight
keymap("n", "\\", ":set invhlsearch<cr>", { desc = "Toggle highlight" })
keymap("n", "\\", ":set invhlsearch<cr>", { desc = "Toggle highlight" })

-- LSP
keymap("n", ">", ":lua vim.lsp.buf.code_action()<cr>", { desc = "Code action" })
