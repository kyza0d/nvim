require("packer").startup({
  function(use)
    use("wbthomason/packer.nvim")

    use("lewis6991/impatient.nvim")

    use({
      "lewis6991/gitsigns.nvim",
      config = function()
        require("plugin.gitsigns")
      end,
    })
    use("Mofiqul/vscode.nvim")

    use({
      "andweeb/presence.nvim",
      config = function()
        require("plugin.presence")
      end,
    })

    use("NTBBloodbath/doom-one.nvim")

    use("folke/tokyonight.nvim")

    use({ "ellisonleao/gruvbox.nvim" })
    use("JoosepAlviste/palenightfall.nvim")

    use("sainnhe/everforest")

    use({
      "DNLHC/glance.nvim",
      config = function()
        require("glance").setup()
      end,
    })

    use({
      "smjonas/live-command.nvim",
      config = function()
        require("live-command").setup({
          defaults = {
            enable_highlighting = true,
            inline_highlighting = true,
            hl_groups = {
              insertion = "DiffAdd",
              deletion = "DiffDelete",
              change = "DiffChange",
            },
          },
          commands = {
            Norm = { cmd = "norm" },
            G = { cmd = "g" },
          },
        })
      end,
    })

    use({
      "~/plugins/themes/aura",
      config = function()
        require("plugin.aura")
      end,
    })

    use({
      "github/copilot.vim",
      setup = function()
        vim.cmd([[
          imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
          let g:copilot_no_tab_map = v:true
          let g:copilot_filetypes = {
          \ '*': v:true,
          \ 'TelescopePrompt': v:false,
          \ }
        ]])
      end,
    })

    use({
      "lukas-reineke/headlines.nvim",
      config = function()
        require("headlines").setup()
      end,
    })

    use({
      "~/plugins/harmony.nvim",
      config = function()
        require("plugin.harmony")
        vim.cmd([[so ~/.config/nvim/lua/plugin/harmony/init.lua]])
      end,
    })

    use("nvim-lua/plenary.nvim")

    use({
      "kyazdani42/nvim-web-devicons",
      config = function()
        require("plugin.devicons")
      end,
    })

    use({
      "nvim-neo-tree/neo-tree.nvim",

      config = function()
        require("plugin.neo-tree")
      end,

      setup = function()
        vim.g.neo_tree_remove_legacy_commands = 1
      end,

      requires = {
        "MunifTanjim/nui.nvim",
      },
    })

    use({ "dstein64/vim-startuptime", cmd = "StartupTime" })

    use({
      "nvim-telescope/telescope.nvim",
      tag = "0.1.0",

      config = function()
        require("plugin.telescope")
      end,

      requires = {
        "nvim-lua/plenary.nvim",
      },
    })

    use({
      "~/open-source/which-key.nvim/",
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
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("plugin.todo-comments")
      end,
    })

    use({
      "hrsh7th/nvim-cmp",
      wants = "LuaSnip",
      requires = {
        { "hrsh7th/cmp-nvim-lsp", module = "cmp_nvim_lsp" },
        { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
        { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
        { "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
        { "hrsh7th/cmp-path", after = "nvim-cmp" },
        { "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" },
        { "uga-rosa/cmp-dictionary", after = "nvim-cmp" },
        { "hrsh7th/cmp-calc", after = "nvim-cmp" },
      },
      config = function()
        require("plugin.nvim-cmp")
      end,
    })

    use("L3MON4D3/LuaSnip")

    use({
      "neovim/nvim-lspconfig",
      config = function()
        require("lsp.lsp-config")
        require("lsp.lsp-config.settings")
        require("lsp.lsp-config.handlers")
      end,
    })

    use({
      "jose-elias-alvarez/null-ls.nvim",
      after = "nvim-lspconfig",
      config = function()
        require("lsp.null-ls")
      end,
    })

    use({
      "williamboman/mason.nvim",
      config = function()
        require("lsp.mason")
      end,
    })

    use({ "williamboman/mason-lspconfig.nvim" })

    use({
      "jose-elias-alvarez/typescript.nvim",
      config = function()
        require("typescript").setup({})
      end,
    })

    use({
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function()
        require("plugin.treesitter")
      end,
    })

    use({
      "nvim-treesitter/playground",
      disable = false,
      after = "nvim-treesitter",
    })

    use({
      "kevinhwang91/nvim-ufo",
      wants = "nvim-treesitter",
      requires = "kevinhwang91/promise-async",
    })

    use({
      "lukas-reineke/indent-blankline.nvim",
      after = "nvim-treesitter",
      disable = true,
      config = function()
        require("plugin.indent-blankline")
      end,
    })

    use("navarasu/onedark.nvim")

    use({
      "windwp/nvim-autopairs",
      after = "nvim-cmp",
      config = function()
        require("plugin.autopairs")
      end,
    })

    use({
      "SmiteshP/nvim-navic",
      config = function()
        require("plugin.nvim-navic")
      end,
    })

    use({
      "akinsho/bufferline.nvim",
      disable = false,
      config = function()
        require("plugin.bufferline")
      end,
    })

    use("moll/vim-bbye")

    use({
      "akinsho/toggleterm.nvim",
      config = function()
        require("plugin.toggleterm")
      end,
    })

    use({
      "kylechui/nvim-surround",
      config = function()
        require("nvim-surround").setup()
      end,
    })

    use({
      "numToStr/Comment.nvim",
      tag = "v0.6.1",
      requires = {
        {
          "JoosepAlviste/nvim-ts-context-commentstring",
          wants = "nvim-treesitter",
        },
      },
      config = function()
        require("plugin.comment")
      end,
    })

    use({
      "~/plugins/img.nvim/",
      config = function()
        require("img").setup()
      end,
    })

    use("Vonr/align.nvim")

    use({
      "iamcco/markdown-preview.nvim",
      ft = { "markdown" },
      run = function()
        vim.fn["mkdp#util#install"]()
      end,
      setup = function()
        vim.g.mkdp_auto_close = 0
      end,
    })

    use("~/plugins/themes/summer-time")
    use("~/plugins/themes/summer-night")
  end,
  config = {
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "none" })
      end,
    },
  },
})

-- Cool plugins
-- https://github.com/mattn/libcallex-vim
-- https://github.com/bytesnake/vim-graphical-preview
-- https://github.com/heapslip/vimage.nvim
-- use({ "sunjon/stylish.nvim" })
