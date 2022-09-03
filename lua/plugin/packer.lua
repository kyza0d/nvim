require("packer").startup({
  function(use)
    use("wbthomason/packer.nvim")

    use({
      config = function()
        require("plugin.lsp-config.servers")
        require("plugin.lsp-config.settings")
        require("plugin.lsp-config.handlers")
      end,
      "neovim/nvim-lspconfig",
    })

    use("sainnhe/sonokai")

    use("Mofiqul/vscode.nvim")

    use("shaunsingh/nord.nvim")

    use("NTBBloodbath/doom-one.nvim")

    use({
      "nvim-treesitter/nvim-treesitter",
      -- commit = "65d0818fede50cb92697701a6afb1c77c7c33ae8",
      config = function()
        require("plugin.treesitter")
      end,
    })

    use("nvim-treesitter/playground")

    use({
      "lukas-reineke/indent-blankline.nvim",
      disable = true,
      config = function()
        require("plugin.indent-blankline")
      end,
    })

    use({
      "kevinhwang91/nvim-ufo",
      requires = "kevinhwang91/promise-async",

      keymap("n", "<C-s-h>", ":foldclose<cr>"),
      keymap("n", "<C-s-l>", ":foldopen<cr>"),

      config = function()
        require("ufo").setup()
      end,
    })

    use({
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
        require("plugin.null-ls")
      end,
    })

    use({
      "jose-elias-alvarez/typescript.nvim",
      config = function()
        require("typescript").setup()
      end,
    })

    use({
      "nvim-telescope/telescope.nvim",
      tag = "0.1.0",
      config = function()
        require("plugin.telescope")
      end,

      keymap("n", "<C-p>", ":Telescope find_files<cr>"),
      keymap("n", "?", ":Telescope live_grep<cr>"),

      requires = {
        "nvim-lua/plenary.nvim",
        "kyazdani42/nvim-web-devicons",
      },
    })

    use({
      "kyazdani42/nvim-web-devicons",
      config = function()
        require("plugin.devicons")
      end,
    })

    use({
      "folke/which-key.nvim",
      config = function()
        require("plugin.whichkey")
      end,
    })

    use({
      "folke/trouble.nvim",
      config = function()
        require("plugin.trouble")
      end,
    })

    use({
      "akinsho/toggleterm.nvim",
      config = function()
        require("plugin.toggleterm")
      end,
    })

    use({
      "windwp/nvim-autopairs",
      config = function()
        require("plugin.autopairs")
      end,
    })

    use({
      "windwp/nvim-ts-autotag",
      config = function()
        require("nvim-ts-autotag")
      end,
    })

    use({
      "kylechui/nvim-surround",
      config = function()
        require("nvim-surround").setup()
      end,
    })

    use({
      tag = "v0.6.1",
      "numToStr/Comment.nvim",

      keymap("i", "<C-/>", "<esc>:norm gcA<cr>a"),
      keymap("n", "<C-/>", ":lua require('Comment.api').toggle_current_linewise()<cr>"),
      keymap("v", "<C-/>", ":lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<cr>"),

      requires = "JoosepAlviste/nvim-ts-context-commentstring",
      config = function()
        require("plugin.comment")
      end,
    })

    use({
      "iamcco/markdown-preview.nvim",
      run = function()
        vim.fn["mkdp#util#install"]()
      end,
      ft = { "markdown" },
      setup = function()
        vim.g.mkdp_auto_close = 0
      end,
    })

    use("~/github/summer-time/")

    use({
      "akinsho/bufferline.nvim",

      keymap("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>"),
      keymap("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>"),
      keymap("n", "<S-d>", "<cmd>Bdelete<cr>"),

      config = function()
        require("plugin.bufferline")
      end,
      requires = "moll/vim-bbye",
    })

    use("lewis6991/gitsigns.nvim")

    -- Snippet engine

    use("L3MON4D3/LuaSnip")

    use({
      "hrsh7th/nvim-cmp",
      config = function()
        require("plugin.nvim-cmp")
      end,
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
      requires = {
        {
          "SmiteshP/nvim-navic",
          config = function()
            require("plugin.nvim-navic")
          end,
        },
      },
      config = function()
        require("plugin.lualine")
      end,
    })

    use({
      "nvim-neo-tree/neo-tree.nvim",

      keymap("n", "<C-n>", ":Neotree focus toggle<cr>"),

      config = function()
        require("plugin.neo-tree")
      end,
      requires = {
        "nvim-lua/plenary.nvim",
        "kyazdani42/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
      },
    })

    use({
      "~/github/palette.lua",
      config = function()
        require("plugin.palette")
      end,
    })
  end,
  config = {
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end,
    },
  },
})
