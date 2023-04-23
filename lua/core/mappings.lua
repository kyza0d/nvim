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

-------------------------------
-- Plugin mappings
-------------------------------

-- github/copilot.vim
keymap("i", "<C-J>", "copilot#Accept('<CR>')", { silent = true, expr = true })

-- nvim-neo-tree/neo-tree.nvim
-- keymap("n", "<C-n>", ":Neotree focus toggle<cr>")
keymap("n", "<C-n>", ":Neotree left toggle filesystem<cr>")

-- nvim-telescope/telescope.nvim
keymap("n", "<C-p>", function()
	require("telescope.builtin").find_files()
end)

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

-- dnlhc/glance.nvim
keymap("n", "gr", "<cmd>Glance references<cr>")

-- smjonas/inc-rename.nvim
keymap("n", "gR", function()
	return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true })

-------------------------------
-- LSP
-------------------------------

-- Preform code action
-- keymap("n", ">", ":lua vim.lsp.buf.code_action()<cr>")

keymap("n", "gd", function()
	vim.lsp.buf.definition({
		on_list = function(options)
			vim.fn.setqflist({}, " ", options)
			vim.api.nvim_command("cfirst")
		end,
	})
end)

-- Show hover
keymap("n", "<S-k>", function()
	vim.lsp.buf.hover()
end)

-- Show diagnostic
keymap("n", "<C-k>", function()
	vim.diagnostic.open_float()
end)

-------------------------------
-- Utilities
-------------------------------

-- Search for visually selected text
-- https://vim.fandom.com/wiki/Search_for_visually_selected_text
keymap(
	"v",
	"//",
	[[y/\V<C-R>=escape(@",'/\')<CR><CR>:set hlsearch<CR>N]],
	{ desc = "Search for visually selected text" }
)

-- Toggle highlight
keymap("n", "\\", ":set invhlsearch<cr>")

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

-- Block selection
-- keymap({ "i", "n", "v" }, "<Tab>", "<cmd>norm <Right><Right>V><cr>")
-- keymap({ "i", "n", "v" }, "<S-Tab>", "<cmd>norm <Left><Left>V<<cr>")

-- Substitue selected text
keymap("v", "<C-s>", [["hy:%s/<C-r>h//gc<left><left><left>]], { silent = false })

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

-- Quit Buffer
keymap("n", "<S-q>", ":Bd<cr>", { desc = "Save and quit", silent = false })

-- Quit Neovim
keymap("n", "Z", "ZZ", { desc = "Save and quit", silent = false })

-------------------------------
-- Apperance
-------------------------------

-- Folding
keymap("n", "[[", ":foldclose<cr>", { nowait = true })
keymap("n", "]]", ":foldopen<cr>", { nowait = true })
