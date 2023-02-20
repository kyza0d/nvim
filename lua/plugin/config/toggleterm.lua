return {
	open_mapping = "<C-\\>",
	shade_terminals = false,
	shell = "zsh",
	on_open = function()
		vim.cmd(
			"setlocal foldcolumn=1 | setlocal laststatus=0 | setlocal signcolumn=no | startinsert! | setlocal statuscolumn="
		)
	end,
	on_close = function()
		vim.cmd("setlocal laststatus=3")
	end,
}
