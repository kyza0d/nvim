vim.cmd([[
  imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
  let g:copilot_no_tab_map = v:true
]])

-- stylua: ignore
local disable = {
  [ "SmiteshP/nvim-navic" ]                = false,
  [ "nvim-lua/plenary.nvim" ]              = false,
  [ "L3MON4D3/LuaSnip" ]                   = false,
  ["jose-elias-alvarez/nvim-lsp-ts-utils"] = false,
  ["wbthomason/packer.nvim"]               = false,
  ["numToStr/Comment.nvim"]                = false,
  ["lervag/vimtex"]                        = false,
  ["iamcco/markdown-preview.nvim"]         = false,
  ["akinsho/bufferline.nvim"]              = false,
  ["lukas-reineke/indent-blankline.nvim"]  = false,
  ["folke/which-key.nvim"]                 = false,
  ["MunifTanjim/nui.nvim"]                 = false,
  ["nvim-neo-tree/neo-tree.nvim"]          = false,
  ["kylechui/nvim-surround"]               = false,
  ["kyazdani42/nvim-web-devicons"]         = false,
  ["~/github/palette.lua/"]                = false,
  ["~/github/aura/"]                       = false,
  ["lewis6991/gitsigns.nvim"]              = false,
  ["akinsho/toggleterm.nvim"]              = false,
  ["kevinhwang91/nvim-ufo"]                = false,
  ["hrsh7th/nvim-cmp"]                     = false,
  ["windwp/nvim-ts-autotag"]               = false,
  ["windwp/nvim-autopairs"]                = false,
  ["jose-elias-alvarez/null-ls.nvim"]      = false,
  ["nvim-treesitter/nvim-treesitter"]      = false,
  ["nvim-telescope/telescope.nvim"]        = false,
  ["folke/trouble.nvim"]                   = false,
  ["neovim/nvim-lspconfig"]                = false,
}

local plugins = {
  -- Plugin manager
  "wbthomason/packer.nvim",

  -- Built-in LSP interface
  ["neovim/nvim-lspconfig"] = {
    disable = disable["neovim/nvim-lspconfig"],
    config = function()
      require("language-server.lsp-config")
    end,
  },

  -- Pretty diagnostics
  ["folke/trouble.nvim"] = {
    disable = disable["folke/trouble.nvim"],
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup({})
    end,
  },

  -- Fuzzy finder
  ["nvim-telescope/telescope.nvim"] = {
    disable = disable["nvim-telescope/telescope.nvim"],
    config = function()
      require("plugin-config.telescope")
    end,
  },

  -- Built-in tree-sitter interface
  ["nvim-treesitter/nvim-treesitter"] = {
    disable = disable["nvim-treesitter/nvim-treesitter"],
    module = "nvim-treesitter",
    commit = "c2e3938510e8fc2cb89b991afe95ca61a79c4683",
    run = ":TSUpdate",
    config = function()
      require("plugin-config.treesitter")
    end,
  },

  -- Inject LSP actions
  ["jose-elias-alvarez/null-ls.nvim"] = {
    disable = disable["jose-elias-alvarez/null-ls.nvim"],
    config = function()
      require("language-server.null-ls")
    end,
  },

  -- Typescript utilities
  ["jose-elias-alvarez/nvim-lsp-ts-utils"] = {
    disable = disable["jose-elias-alvarez/nvim-lsp-ts-utils"],
  },

  -- Pair completion
  ["windwp/nvim-autopairs"] = {
    disable = disable["windwp/nvim-autopairs"],
    config = function()
      require("nvim-autopairs").setup({
        disable_filetype = { "TelescopePrompt", "vim", "markdown" },
      })
    end,
  },

  ["windwp/nvim-ts-autotag"] = {
    disable = disable["windwp/nvim-ts-autotag"],
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  -- Completion engine
  ["hrsh7th/nvim-cmp"] = {
    disable = disable["hrsh7th/nvim-cmp"],
    config = function()
      require("plugin-config.completion")
    end,
    requires = {
      -- Snippet completion
      "saadparwaiz1/cmp_luasnip",

      -- Commandline completion
      "hrsh7th/cmp-cmdline",

      -- Path completion
      "hrsh7th/cmp-path",

      -- Calc completion
      "hrsh7th/cmp-calc",

      -- LSP completion
      "hrsh7th/cmp-nvim-lsp",

      -- Buffer completion
      "hrsh7th/cmp-buffer",
    },
  },

  -- Snippet engine
  ["L3MON4D3/LuaSnip"] = {
    disable = disable["L3MON4D3/LuaSnip"],
  },

  -- LSP folding
  ["kevinhwang91/nvim-ufo"] = {
    disable = disable["kevinhwang91/nvim-ufo"],
    requires = "kevinhwang91/promise-async",
    config = function()
      require("ufo").setup()
    end,
  },

  -- Integrated terminal
  ["akinsho/toggleterm.nvim"] = {
    disable = disable["akinsho/toggleterm.nvim"],
    cmd = "ToggleTerm",
    config = function()
      require("plugin-config.terminal")
    end,
  },

  -- Utility lua functions
  ["nvim-lua/plenary.nvim"] = {
    disable = disable["nvim-lua/plenary.nvim"],
  },

  -- Git integration
  ["lewis6991/gitsigns.nvim"] = {
    disable = disable["lewis6991/gitsigns.nvim"],
    config = function()
      require("gitsigns").setup({
        signcolumn = false,
      })
    end,
  },

  ["~/github/aura/"] = {
    config = function()
      require("plugin-config.aura")
    end,
  },

  "~/github/summer-time/",
  "~/github/summer-night/",
  "~/github/plastic/",
  "~/github/dark-pines/",

  -- Colorscheme manager
  ["~/github/palette.lua/"] = {
    config = function()
      require("plugin-config.palette")
    end,
  },

  -- Icons
  ["kyazdani42/nvim-web-devicons"] = {
    disable = disable["kyazdani42/nvim-web-devicons"],
    config = function()
      require("plugin-config.devicons")
    end,
  },

  -- Surround motions
  ["kylechui/nvim-surround"] = {
    disable = disable["kylechui/nvim-surround"],
    config = function()
      require("nvim-surround").setup()
    end,
  },

  ["nvim-neo-tree/neo-tree.nvim"] = {
    disable = disable["nvim-neo-tree/neo-tree.nvim"],
    tag = "v2.33",
    config = function()
      require("plugin-config.neotree")
    end,
    requires = {
      "MunifTanjim/nui.nvim",
      "mrbjarksen/neo-tree-diagnostics.nvim",
    },
  },

  ["MunifTanjim/nui.nvim"] = {
    disable = disable["MunifTanjim/nui.nvim"],
    config = function()
      require("plugin-config.nui")
    end,
  },

  -- Keystroke based commands
  ["folke/which-key.nvim"] = {
    disable = disable["folke/which-key.nvim"],
    config = function()
      require("plugin-config.whichkey")
    end,
  },

  -- Indent markers
  ["lukas-reineke/indent-blankline.nvim"] = {
    disable = disable["lukas-reineke/indent-blankline.nvim"],
    tag = "v2.19.0",
    config = function()
      require("plugin-config.indent")
    end,
  },

  -- Code depth indication
  ["SmiteshP/nvim-navic"] = {
    disable = disable["SmiteshP/nvim-navic"],
  },

  -- Bufferline
  ["akinsho/bufferline.nvim"] = {
    disable = disable["akinsho/bufferline.nvim"],
    tag = "v2.4.0",
    requires = {
      "moll/vim-bbye",
    },
    config = function()
      require("plugin-config.bufferline")
    end,
  },

  -- Live reload of markdown files
  ["iamcco/markdown-preview.nvim"] = {
    disable = disable["iamcco/markdown-preview.nvim"],
    tag = "v0.0.10",
    ft = "markdown",
    config = function()
      vim.api.nvim_command([[
        let g:mkdp_preview_options.disable_sync_scroll=1
        let g:mkdp_auto_close = 0
      ]])
    end,
  },

  -- Compile Tex Documents
  ["lervag/vimtex"] = {
    disable = disable["lervag/vimtex"],
    ft = "tex",
  },

  -- Align Code
  ["Vonr/align.nvim"] = {
    disable = disable["Vonr/align.nvim"],
  },

  -- Commenting
  ["numToStr/Comment.nvim"] = {
    disable = disable["numToStr/Comment.nvim"],
    tag = "v0.6.1",
    requires = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    cmd = "Comment",
    module = "Comment.api",
    config = function()
      require("plugin-config.comment")
    end,
  },
}

local status_ok, packer = pcall(require, "packer")

if status_ok then
  packer.startup({
    function(use)
      for key, plugin in pairs(plugins) do
        if type(key) == "string" and not plugin[1] then
          plugin[1] = key
        end
        use(plugin)
      end
    end,
    config = {
      display = {
        open_fn = function()
          return require("packer.util").float({ border = "single" })
        end,
      },
    },
  })
end
