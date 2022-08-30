local use = require("packer").use

require("packer").startup({
	function(use)
		use("wbthomason/packer.nvim")
		use("neovim/nvim-lspconfig")
		use("nvim-treesitter/nvim-treesitter")
		use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" })
		use({ "jose-elias-alvarez/null-ls.nvim", disable = true })
		use("jose-elias-alvarez/typescript.nvim")
		use({
			"nvim-telescope/telescope.nvim",
			tag = "0.1.0",
			requires = { "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons" },
		})
		use("folke/which-key.nvim")
		use("akinsho/toggleterm.nvim")
		use("windwp/nvim-autopairs")
		use("windwp/nvim-ts-autotag")
		use("kylechui/nvim-surround")
    use("terrortylor/nvim-comment")
		use("~/github/summer-time/")
    use("navarasu/onedark.nvim")
    use("shaunsingh/nord.nvim")
		use({
			"akinsho/bufferline.nvim",
			requires = "moll/vim-bbye",
		})
		use("lewis6991/gitsigns.nvim")
		-- Snippet engine
		use("L3MON4D3/LuaSnip")
		use({
			"hrsh7th/nvim-cmp",
			requires = {
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-cmdline",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-calc",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"L3MON4D3/LuaSnip",
			},
		})
		use({
			"nvim-lualine/lualine.nvim",
			requires = "SmiteshP/nvim-navic",
		})
		use({
			"nvim-neo-tree/neo-tree.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
				"kyazdani42/nvim-web-devicons",
				"MunifTanjim/nui.nvim",
			},
		})
		use("~/github/palette.lua")
	end,
	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
	},
})
