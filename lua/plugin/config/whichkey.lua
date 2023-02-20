local leader = {
	f = {
		name = "Find",
		f = { "<cmd>Telescope find_files<cr>", "files" },
		w = { "<cmd>Telescope live_grep<cr>", "grep" },
		b = { "<cmd>Telescope buffers<cr>", "buffers" },
		h = { "<cmd>Telescope help_tags<cr>", "help" },
	},

	c = {
		name = "Colorscheme",
		o = { "<cmd>colorscheme onedark<cr>", "onedark" },
		d = { "<cmd>colorscheme doom-one<cr>", "doom-one" },
		e = { "<cmd>colorscheme embark<cr>", "embark" },
		n = { "<cmd>colorscheme nord<cr>", "nord" },
		s = { "<cmd>colorscheme summer-time<cr>", "summer-time" },
		i = { "<cmd>colorscheme iceberg<cr>", "iceberg" },
	},

	g = {
		name = "Git",
		["%"] = { ":!git add %<cr>", "Add current file" },
		["d"] = { "<cmd>lua _lazygit_toggle()<CR>", "details" },
		r = {
			name = "reset",
			["h"] = { ":Gitsigns reset_hunk<cr>", "hunk" },
			["b"] = { ":Gitsigns reset_buffer<cr>", "buffer" },
		},
		s = {
			name = "stage",
			["h"] = { ":Gitsigns stage_hunk<cr>", "hunk" },
			["b"] = { ":Gitsigns stage_buffer<cr>", "buffer" },
		},
	},

	d = {
		name = "Dotfiles",
		v = { ":Telescope find_files cwd=~/.config/nvim/<cr>", ".nvim" },
		p = { ":silent e ~/.config/polybar/config.ini<cr>", ".polybar" },
		c = { ":silent e ~/.config/picom/picom.conf<cr>", ".picom" },
		q = { ":silent e ~/.config/qutebrowser/config.py<cr>", ".qutebrowser" },
		b = { ":silent e ~/.config/bspwm/bspwmrc<cr>", ".bspwmrc" },
		d = { ":silent e ~/.config/dunst/dunstrc<cr>", ".dunst" },
		x = { ":silent e ~/.xprofile<cr>", ".xprofile" },
		z = { ":silent e ~/.zshrc<cr>", ".zsh" },
		s = { ":silent e ~/.config/sxhkd/sxhkdrc<cr>", ".sxhkd" },
		r = { ":silent e ~/.config/rofi/config.rasi<cr>", ".rofi" },
		k = { ":silent e ~/.config/kitty/kitty.conf<cr>", ".kitty" },
		l = { ":silent e ~/.config/lsd/config.yaml<cr>", ".lsd" },
	},
}

local cr_mappings = {
	d = { ":WhichKey \\<leader>d<cr>", "Dotfiles" },
	t = { ":TodoTrouble <cr>", "  Todo" },
	w = { ":w!<cr>", "Write buffer" },
	r = { "<cmd>Telescope oldfiles<cr>", "recent" },
	a = { ":norm @a<CR>", "Preform 'a' macro", silent = false },
	h = { ":Telescope help_tags<cr>", "Search" },
	["/"] = { ":Telescope live_grep<cr>", "Grep" },
}

local cr_mappings_visual = {
	a = { ":norm @a<CR>", "Preform 'a' macro", silent = false },
	s = { ":%s/", "Substitute command ", silent = false, noremap = false },
	n = { ":Norm ", "Normal command", silent = false },
	h = {
		name = "hunk",
		s = { ":Gitsigns stage_hunk<cr>", "Stage hunk" },
	},
}

require("which-key").register(leader, {
	mode = "n",
	prefix = "<Space>",
})

require("which-key").register(cr_mappings, {
	mode = "n",
	prefix = "<cr>",
})

require("which-key").register(cr_mappings_visual, {
	mode = "v",
	prefix = "<cr>",
})

require("which-key").setup({
	plugins = {
		marks = true,
		registers = false,
		spelling = {
			enabled = true,
			suggestions = 20,
		},

		presets = {
			operators = true,
			motions = true,
			text_objects = true,
			windows = true,
			nav = true,
			z = true,
			g = true,
		},
	},

	icons = {
		breadcrumb = "",
		separator = "->",
		group = "",
	},
})
