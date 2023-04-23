require("telescope").setup({
	defaults = {
		file_ignore_patterns = { "node_modules", "package-lock.json", "yarn.lock", "dist" },
		sorting_strategy = "ascending",

		borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },

		selection_caret = " ",
		prompt_prefix = " ",
		entry_prefix = " ",

		path_display = { "absolute" },

		layout_config = {
			width = 0.8,
			height = 0.7,
		},

		preview_title = "",
		prompt_title = "",
		results_title = "",

		pickers = {
			live_grep = {
				file_ignore_patterns = { "node_modules", "package-lock.json" },
			},
		},
	},
})
