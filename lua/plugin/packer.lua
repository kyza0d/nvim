require("packer").startup({
  function(use)
    use("wbthomason/packer.nvim")

    use("lewis6991/impatient.nvim")

    use({
      "lewis6991/gitsigns.nvim",
      -- event = "BufRead",
      config = function()
        require("plugin.gitsigns")
        -- require("scrollbar.handlers.gitsigns").setup()
      end,
    })

    use({
      "DNLHC/glance.nvim",
      config = function()
        require("glance").setup({
          -- your configuration
        })
      end,
    })

    -- Cool plugin
    -- use({ "sunjon/stylish.nvim" })

    use({
      "smjonas/live-command.nvim",
      -- live-command supports semantic versioning via tags
      -- tag = "1.*",
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
        require("headlines").setup({

          markdown = {
            headline_highlights = { "Headline" },
            codeblock_highlight = "CodeBlock",
            dash_highlight = "Dash",
            dash_string = "─",
            quote_highlight = "Quote",
            quote_string = "┃",
            fat_headlines = true,
            fat_headline_upper_string = "▃",
            fat_headline_lower_string = "🬂",
          },
        })
      end,
    })

    use({
      "~/plugins/harmony.nvim",
      config = function()
        require("plugin.harmony")
        vim.cmd([[so ~/.config/nvim/lua/plugin/harmony/init.lua]])
      end,
    })

    -- use({
    --   "~/plugins/caution.nvim",
    ----   event = "CursorHold",
    --   config = function()
    --     require("plugin.caution")
    --   end,
    -- })

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

      ---- event = "BufEnter",

      config = function()
        require("plugin.telescope")
      end,

      requires = {
        "nvim-lua/plenary.nvim",
        -- "kyazdani42/nvim-web-devicons",
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
      --event = "BufRead",
      config = function()
        require("plugin.trouble")
      end,
    })

    use({
      "folke/todo-comments.nvim",
      --event = "BufRead",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("plugin.todo-comments")
      end,
    })

    use({
      -- "~/open-source/nvim-cmp/",
      "hrsh7th/nvim-cmp",
      --event = { "InsertEnter", "CmdlineEnter" },
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

    use({
      "L3MON4D3/LuaSnip",
      --event = "InsertCharPre",
    })

    use({
      "neovim/nvim-lspconfig",
      --event = "BufReadPre",
      config = function()
        require("plugin.lsp-config")
        require("plugin.lsp-config.settings")
        require("plugin.lsp-config.handlers")
      end,
    })

    use({
      "jose-elias-alvarez/null-ls.nvim",
      after = "nvim-lspconfig",
      config = function()
        require("plugin.null-ls")
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
      --module = "typescript",
      config = function()
        require("typescript").setup({})
      end,
    })

    use({
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      -- disable = true,
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
      disable = false,
      config = function()
        require("plugin.indent-blankline")
      end,
    })

    use("navarasu/onedark.nvim")

    use({
      "windwp/nvim-autopairs",
      -- after = "nvim-treesitter",
      after = "nvim-cmp",
      config = function()
        require("plugin.autopairs")
      end,
    })

    use({
      "SmiteshP/nvim-navic",
      --module = "nvim-navic",
      -- after = "nvim-treesitter",
      config = function()
        require("plugin.nvim-navic")
      end,
    })

    use({
      "akinsho/bufferline.nvim",
      -- event = "BufRead",
      disable = false,
      config = function()
        require("plugin.bufferline")
      end,
    })

    -- use({ "moll/vim-bbye", after = "bufferline.nvim" })
    use("moll/vim-bbye")

    use({
      "akinsho/toggleterm.nvim",
      -- tag = "v2.2.1",

      --event = "BufEnter",
      config = function()
        require("plugin.toggleterm")
      end,
    })

    use({
      "kylechui/nvim-surround",
      --event = "BufRead",
      config = function()
        require("nvim-surround").setup()
      end,
    })

    use({
      "numToStr/Comment.nvim",
      tag = "v0.6.1",
      --module = "Comment",
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
      "~/plugins/imagine.nvim/",
      config = function()
        require("imagine").setup()
      end,
      -- https://github.com/mattn/libcallex-vim
      -- https://github.com/bytesnake/vim-graphical-preview
      -- https://github.com/heapslip/vimage.nvim
    })

    -- use({
    --   "williamboman/mason.nvim",
    --   config = function()
    --     require("mason").setup()
    --   end,
    -- }

    use({
      "Vonr/align.nvim",
      --module = "align",
    })

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

    -- use("~/plugins/themes/abyss")
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
