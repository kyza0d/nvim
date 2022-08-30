local status_ok, telescope = pcall(require, "telescope")

if not status_ok then
	return
end

keymap("n", "<C-p>", ":Telescope find_files<cr>")

telescope.setup({
	defaults = {
		sorting_strategy = "ascending",
		selection_caret = " ",
		prompt_prefix = " ",
		entry_prefix = " ",
		path_display = { "smart" },

		layout_config = {
			width = 0.5,
			height = 0.4,
		},

		borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },

		layout_strategy = "bottom_pane",

		preview_title = "",
		prompt_title = "",
		results_title = "",

		file_ignore_patterns = { "node_modules", "package-lock.json", "yarn.lock" },
	},
})
