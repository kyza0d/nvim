local highlights = require("core.highlights")

vim.opt.bg = "dark"

require("harmony").setup({
	["*"] = {
		bg = { "#222222", "#ffffff" },
		fg = { "#dddddd", "#222222" },

		highlights = highlights,
	},

	tokyonight = {
		bg = "#161820",
		fg = "#c9cee0",
	},

	palenightfall = {
		bg = "#1d1f2a",
		fg = "#b7bfe2",
		highlights = {
			Conceal = { clear = true },
		},
	},

	onedark = {
		bg = { "#1E232A", "#ffffff" },
		fg = { "#cdd1d8", "#888888" },
	},

	sweetie = {
		bg = "#0D0D16",
		fg = "#d2cdf2",
	},
})
