return {

	----------------------------------------------
	-- Motions / Keystrokes
	----------------------------------------------

	-- Keystroke-based commands
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("plugin.config.whichkey")
		end,
	},

	-- Surround motions
	{
		"tpope/vim-surround",
		event = "BufReadPost",
	},

	-- Align motions
	"Vonr/align.nvim",

	----------------------------------------------
	-- UI, Appearance
	----------------------------------------------

	-- Themes
	{ "folke/tokyonight.nvim", lazy = false },
	{ "sainnhe/everforest", lazy = false },
	{ "navarasu/onedark.nvim", lazy = false },

	{ dir = "~/plugins/themes/summer-time", lazy = false },
	{ dir = "~/plugins/themes/summer-night", lazy = false },
	{ dir = "~/plugins/themes/silent", lazy = false },
	{ dir = "~/plugins/themes/byte-theme", lazy = false },

	-- Scrollbar
	{
		"dstein64/nvim-scrollview",
		event = "BufReadPost",
		opts = {
			excluded_filetypes = { "neo-tree" },
			current_only = true,
			winblend = 10,
		},
	},

	-- Indent Lines
	{
		"lukas-reineke/indent-blankline.nvim",
		enabled = true,
		event = "BufReadPost",
		init = function()
			vim.g.indent_blankline_char = require("core.options").icons.indent
			vim.g.indent_blankline_context_char = require("core.options").icons.indent
			vim.g.indent_blankline_show_trailing_blankline_indent = false
		end,
		opts = {
			show_current_context = true,
		},
	},

	-- Show LSP progress
	{
		"j-hui/fidget.nvim",
		event = "BufReadPost",
		opts = {
			text = { spinner = "dots_ellipsis" },
		},
	},

	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("plugin.config.devicons")
		end,
	},

	-- Consistent colorschemes
	{
		dir = "~/plugins/harmony.nvim",
		enabled = true,
		event = "VeryLazy",
		config = function()
			require("plugin.config.harmony")
		end,
	},

	----------------------------------------------
	-- LSP, Completion, Formatter/Linters
	----------------------------------------------

	-- Language server quick config
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			{
				"williamboman/mason.nvim",
				opts = {},
			},
			{
				"jose-elias-alvarez/null-ls.nvim",
				config = function()
					require("servers.null-ls")
				end,
			},
		},
	},

	-- Completion menu
	{
		"hrsh7th/nvim-cmp",
		event = { "CmdlineEnter", "InsertEnter" },
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-path",
		},
		config = function()
			require("plugin.config.nvim-cmp")
		end,
	},

	-- Snippet engine
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets", "saadparwaiz1/cmp_luasnip" },
	},

	{
		"dnlhc/glance.nvim",
		opts = {
			preview_win_opts = { relativenumber = false },
		},
		keys = {
			{ "gD", "<Cmd>Glance definitions<CR>", desc = "lsp: glance definitions" },
			{ "gR", "<Cmd>Glance references<CR>", desc = "lsp: glance references" },
			{ "gY", "<Cmd>Glance type_definitions<CR>" },
			{ "gM", "<Cmd>Glance implementations<CR>" },
		},
	},

	----------------------------------------------
	-- Editor
	----------------------------------------------

	-- Language Parser
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		version = false,
		event = "BufReadPost",
		opts = {
      -- stylua: ignore
      ensure_installed = {
        "bash", "css", "gitignore", "help",
        "html", "java", "javascript", "tsx",
        "typescript", "jsdoc", "json", "jsonc",
        "regex", "rust", "scss", "toml", "vim",
      },
			highlight = { enable = true },
			indent = { enable = true },
			playground = { enable = true },
			context_commentstring = {
				enable = true,
				enable_autocmd = false,
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	-- Fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		opts = require("plugin.config.telescope"),
		dependencies = "nvim-lua/plenary.nvim",
	},

	-- File Explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = "Neotree",
		config = function()
			require("plugin.config.neotree")
		end,
		dependencies = "MunifTanjim/nui.nvim",
	},

	-- Bufferline
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		opts = require("plugin.config.bufferline"),
		dependencies = "moll/vim-bbye",
	},

	-- Terminal
	{
		"akinsho/toggleterm.nvim",
		opts = require("plugin.config.toggleterm"),
		keys = { "<C-\\>" },
	},

	-- Source Control
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		opts = {
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				untracked = { text = "│" },
				topdelete = { text = "" },
				changedelete = { text = "" },
				delete = { text = "" },
			},
		},
	},

	-- Commenting
	{
		"echasnovski/mini.comment",
		event = "VeryLazy",
		opts = {
			hooks = {
				pre = function()
					require("ts_context_commentstring.internal").update_commentstring({})
				end,
			},
		},
		dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
		config = function(_, opts)
			require("mini.comment").setup(opts)
		end,
	},

	-- Folding
	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
		event = "BufReadPost",
		opts = {
			provider_selector = function(bufnr, filetype, buftype)
				return { "treesitter", "indent" }
			end,
		},
	},

	-- VS Code like winbar
	{
		"utilyre/barbecue.nvim",
		event = "BufReadPost",
		version = "*",
		dependencies = {
			{
				"SmiteshP/nvim-navic",
				init = function()
					vim.g.navic_silence = true
				end,
				opts = require("plugin.config.nvim-navic"),
			},
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			symbols = {
				separator = "󰅂",
				kinds = require("core.options").navic,
			},
		},
	},

	-- Better text objects
	{
		"echasnovski/mini.ai",
		keys = {
			{ "a", mode = { "x", "o" } },
			{ "i", mode = { "x", "o" } },
		},
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				init = function()
					require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
				end,
			},
		},
		opts = function()
			local ai = require("mini.ai")
			return {
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}, {}),
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
				},
			}
		end,
		config = function(_, opts)
			local ai = require("mini.ai")
			ai.setup(opts)
		end,
	},

	----------------------------------------------
	-- Utilites
	----------------------------------------------

	-- Extra tree-sitter information
	{
		"nvim-treesitter/playground",
		cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
	},

	-- Measure startup time
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
	},

	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && yarn install",
		ft = "markdown",
		cmd = "MarkdownPreview",
	},

	----------------------------------------------
	-- Other
	----------------------------------------------

	{
		"andweeb/presence.nvim",
		lazy = false,
		event = "BufReadPost",
		opts = {},
	},

	-- {
	--   "github/copilot.vim",
	--   event = "InsertEnter",
	--   init = function()
	--     vim.g.copilot_filetypes = true
	--     vim.g.copilot_filetypes = {
	--       ["*"] = true,
	--       TelescopePrompt = false,
	--     }
	--   end,
	-- },
}
