local use = require("packer").use

require("packer").startup({
  function(use)
    use("wbthomason/packer.nvim")

    use("neovim/nvim-lspconfig")

    use("sainnhe/sonokai")

    use({
      "nvim-treesitter/nvim-treesitter",
      config = function()
        require("plugin.treesitter")
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

    use({ "jose-elias-alvarez/null-ls.nvim", disable = true })

    use({
      "jose-elias-alvarez/typescript.nvim",
      config = function()
        require("typescript").setup()
      end,
    })

    use({
      "nvim-telescope/telescope.nvim",

      keymap("n", "<C-p>", ":Telescope find_files<cr>"),
      keymap("n", "?", ":Telescope live_grep<cr>"),

      tag = "0.1.0",
      requires = { "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons" },
    })

    use({
      "folke/which-key.nvim",
      config = function()
        require("plugin.whichkey")
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
