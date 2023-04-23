local icons = require("core.options")

return {

	----------------------------------------------
	-- ⌨️  Motions / Keystrokes
	----------------------------------------------

	-- Keystroke-based commands
	{
		"folke/which-key.nvim",
		lazy = false,
		-- event = "VeryLazy",
		config = function()
			require("plugin.config.whichkey")
		end,
	},

	{
		"ThePrimeagen/harpoon",
		enabled = false,
		opts = {},
	},

	-- Surround motions
	{
		"tpope/vim-surround",
		event = "BufReadPost",
	},

	-- Align motions
	"Vonr/align.nvim",

	----------------------------------------------
	-- 🎨 UI, Appearance
	----------------------------------------------

	-- Themes
	"folke/tokyonight.nvim",

	{
		"glepnir/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("plugin.config.dashboard")
		end,
	},

	{ "NTBBloodbath/sweetie.nvim", lazy = false },
	{ "navarasu/onedark.nvim", lazy = false },
	{ "JoosepAlviste/palenightfall.nvim", lazy = false },
	{ dir = "/home/evan/Plugins/themes/byte-theme", lazy = false },
	{ dir = "/home/evan/Plugins/themes/neowal", lazy = false },
	{ dir = "/home/evan/Plugins/themes/summer-time", lazy = false },

	-- Scrollbar
	{
		"dstein64/nvim-scrollview",
		event = "BufReadPost",
		enabled = false,
		init = function()
			vim.g.scrollview_character = "▍"
		end,
		opts = {
			column = 1,
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
			vim.g.indent_blankline_filetype_exclude = { "toggleterm", "telescope", "norg" }
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
			window = {
				blend = 0, -- &winblend for the window
			},
			text = { spinner = "dots_ellipsis" },
		},
	},

	-- Filetype icons
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("plugin.config.devicons")
		end,
	},

	-- Consistent colorschemes
	{
		dir = "/home/evan/Plugins/harmony.nvim",

		priority = 1000,

		-- event = "VeryLazy",
		-- lazy = false,

		config = function()
			require("plugin.config.harmony")
		end,
	},

	{
		"NvChad/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = {
			filetypes = { "*" },
			user_default_options = {
				mode = "background", -- Set the display mode.
				names = false, -- "Name" codes like Blue or blue
				tailwind = true, -- Enable tailwind colors
				virtualtext = "■",
			},
		},
	},

	---------------------------------------------
	-- 🔍 LSP, Completion, Formatter/Linters
	----------------------------------------------

	-- Language server
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"jose-elias-alvarez/null-ls.nvim",
			{ "williamboman/mason.nvim", opts = {} },
		},
	},

	{
		"SmiteshP/nvim-navbuddy",
		event = "LspAttach",
		opts = {
			lsp = { auto_attach = true },
			window = {
				size = "80%",
				sections = {
					left = { size = "20%" },
					mid = { size = "20%" },
					right = { preview = "always" },
				},
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"SmiteshP/nvim-navic",
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

	-- Autopairs
	{
		"altermo/ultimate-autopair.nvim",
		event = { "InsertEnter", "CmdlineEnter" },
		opts = {},
	},

	-- Snippet engine
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets", "saadparwaiz1/cmp_luasnip" },
	},

	-- Goto definitions/references window
	{
		"dnlhc/glance.nvim",
		event = "LspAttach",
		opts = {
			preview_win_opts = { relativenumber = false },
		},
	},

	{
		"smjonas/inc-rename.nvim",
		event = "LspAttach",
		opts = {},
	},

	----------------------------------------------
	-- 📝 Editor
	----------------------------------------------

	-- Language Parser
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		version = false,
		event = "BufReadPost",
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
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
	},

	-- Fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		config = function()
			require("plugin.config.telescope")
		end,
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-symbols.nvim" },
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
		enabled = true,
		event = "BufReadPre",
		dependencies = "moll/vim-bbye",
		opts = require("plugin.config.bufferline"),
	},

	-- Terminal
	{
		"akinsho/toggleterm.nvim",
		keys = { "<C-\\>" },
		opts = require("plugin.config.toggleterm"),
	},

	-- Source Control
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		opts = {
			signs = {
				add = { text = "🭲" },
				change = { text = "🭲" },
				untracked = { text = "🭲" },
				topdelete = { text = "" },
				changedelete = { text = "" },
				delete = { text = "" },
			},
		},
	},

	{
		"folke/todo-comments.nvim",
		event = "BufReadPost",
		opts = {
			keywords = {
				ROADMAP = { icon = " ", color = "warning" },
			},
		},
	},

	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		opts = {},
	},

	-- Folding
	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
		event = "BufReadPost",
		config = function()
			require("plugin.config.nvim-ufo")
		end,
	},

	-- VS Code like winbar
	{
		"utilyre/barbecue.nvim",
		enabled = false,
		event = "BufReadPre",
		version = "*",
		dependencies = {
			{
				"SmiteshP/nvim-navic",
				init = function()
					vim.g.navic_silence = true
				end,
				opts = {
					icons = icons.navic,
					separator = icons.chevron,
					highlight = true,
					depth_limit = 3,
					depth_limit_indicator = "..",
				},
			},
		},
		opts = {
			exclude_filetypes = { "toggleterm", "norg" },
			kinds = require("core.options").navic,
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
	-- ✏️  Comments
	----------------------------------------------
	{
		"echasnovski/mini.comment",
		event = "VeryLazy",
		dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
		config = function(_, opts)
			require("mini.comment").setup(opts)
		end,
		opts = {
			hooks = {
				pre = function()
					require("ts_context_commentstring.internal").update_commentstring({})
				end,
			},
		},
	},

	----------------------------------------------
	-- 🔧 Utilites
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
	-- Notes
	----------------------------------------------

	{
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers",
		ft = "norg",
		opts = {
			load = {
				["core.defaults"] = {}, -- Loads default behaviour
				["core.keybinds"] = {}, -- Adds pretty icons to your documents
				["core.norg.esupports.indent"] = {
					config = {
						format_on_enter = false,
						format_on_escape = false,
					},
				},
				["core.norg.concealer"] = {
					config = {
						icons = {
							heading = {
								enabled = true,
								level_1 = {
									icon = " ",
								},
							},
						},
					},
				}, -- Adds pretty icons to your documents
				["core.norg.completion"] = { config = { engine = "nvim-cmp" } },
				["core.norg.dirman"] = { -- Manages Neorg workspaces
					config = {
						workspaces = {
							notes = "~/Notes",
						},
					},
				},
			},
		},
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},

	----------------------------------------------
	-- Other
	----------------------------------------------

	-- Shows Discord presence
	-- {
	-- 	"andweeb/presence.nvim",
	-- 	lazy = false,
	-- 	event = "BufReadPost",
	-- 	opts = {},
	-- },

	-- Syntax highlighting for codeblocks
	-- {
	-- 	"atusy/tsnode-marker.nvim",
	-- 	ft = "md",
	-- 	init = function()
	-- 		vim.api.nvim_create_autocmd("FileType", {
	-- 			group = vim.api.nvim_create_augroup("tsnode-marker-markdown", {}),
	-- 			pattern = "markdown",
	-- 			callback = function(ctx)
	-- 				require("tsnode-marker").set_automark(ctx.buf, {
	-- 					target = { "code_fence_content" }, -- list of target node types
	-- 					hl_group = "CursorLine", -- highlight group
	-- 				})
	-- 			end,
	-- 		})
	-- 	end,
	-- },

	-- {
	-- 	"willothy/flatten.nvim",
	-- 	event = "BufReadPre",
	-- 	config = true,
	-- 	opts = {
	-- 		window = {
	-- 			open = "alternate",
	-- 		},
	-- 	},
	-- 	priority = 1001,
	-- },

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
