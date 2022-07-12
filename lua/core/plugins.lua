local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
end

local status_ok, packer = pcall(require, "packer")

if not status_ok then
  return
end

vim.cmd([[packadd packer.nvim]])

require("core.plugins.palette")

vim.cmd([[
  imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
  let g:copilot_no_tab_map = v:true
]])

return require("packer").startup(function()
  -- Plugin Manager
  use("wbthomason/packer.nvim")

  use("github/copilot.vim")

  -- Code abstraction layer
  use({
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("core.plugins.treesitter")
    end,
  })

  -- LSP interface
  use({
    "neovim/nvim-lspconfig",
    config = function()
      require("core.plugins.lsp")
    end,
  })

  use("jose-elias-alvarez/nvim-lsp-ts-utils")

  use({
    "smjonas/inc-rename.nvim",
    config = function()
      require("core.plugins.inc_rename")
    end,
  })

  -- Inject LSP actions
  use({
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("core.plugins.lsp.null_ls")
    end,
  })

  use({
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup()
    end,
  })

  -- Manage LSP servers
  use("williamboman/nvim-lsp-installer")

  -- Completion engine
  use({
    "hrsh7th/nvim-cmp",
    config = function()
      require("core.plugins.nvim_cmp")
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

      -- Nvim's lua API completion
      "hrsh7th/cmp-nvim-lua",

      -- Document symbol completion
      "hrsh7th/cmp-nvim-lsp-document-symbol",
    },
  })

  -- Snippet engine
  use("L3MON4D3/LuaSnip")

  -- LSP folding
  use({
    "kevinhwang91/nvim-ufo",
    requires = "kevinhwang91/promise-async",
    config = function()
      require("core.plugins.fold")
    end,
  })

  -- Tag completion
  use({
    "windwp/nvim-ts-autotag",
    after = "nvim-treesitter",
    config = function()
      require("core.plugins.auto_tags")
    end,
  })

  -- Pair completion
  use({
    "windwp/nvim-autopairs",
    after = "nvim-treesitter",
    config = function()
      require("core.plugins.auto_pairs")
    end,
  })

  -- Integrated terminal
  use({
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm",
    config = function()
      require("core.plugins.toggleterm")
    end,
  })

  -- Utility lua functions
  use("nvim-lua/plenary.nvim")

  -- Git integration
  use({
    "lewis6991/gitsigns.nvim",
    config = function()
      require("core.plugins.gitsigns")
    end,
  })

  -- Image previewer
  -- use({
  --   "~/Github/draw_image/",
  --   config = function()
  --     require("draw_image").setup()
  --   end,
  -- })

  -- Colorscheme manager
  use({
    "~/github/palette.lua/",
    config = function()
      require("core.plugins.palette")
    end,
  })

  use({
    "nvim-treesitter/playground",
    config = function()
      require("nvim-treesitter.configs").setup({
        query_linter = {
          enable = true,
          use_virtual_text = true,
          lint_events = { "BufWrite", "CursorHold" },
        },
      })
    end,
  })

  -- Color previews
  use({
    "norcalli/nvim-colorizer.lua",
    cmd = "ColorizerAttachToBuffer",
    config = function()
      require("core.plugins.colorizer")
    end,
  })

  -- Onedark
  use("navarasu/onedark.nvim")
  use("catppuccin/nvim")
  use("sainnhe/sonokai")
  use("sainnhe/everforest")

  -- Icons
  use({
    "kyazdani42/nvim-web-devicons",
    config = function()
      require("core.plugins.web_devicons")
    end,
  })

  -- Surround motions
  use("tpope/vim-surround")

  -- File explorer
  use({
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("core.plugins.nvim_tree")
    end,
  })

  -- Keystroke based commands
  use({
    "folke/which-key.nvim",
    config = function()
      require("core.plugins.whichkey")
    end,
  })

  -- Show indent
  use({
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("core.plugins.indentline")
    end,
  })

  -- Compile Tex Documents
  use({
    "lervag/vimtex",
    ft = "tex",
  })

  -- Statusline
  use({
    "nvim-lualine/lualine.nvim",
    wants = "nvim-gps",
    config = function()
      require("core.plugins.lualine")
    end,
  })

  use("SmiteshP/nvim-gps")

  -- Bufferline
  use({
    "akinsho/bufferline.nvim",
    requires = {
      "moll/vim-bbye",
    },
    config = function()
      require("core.plugins.bufferline")
    end,
  })

  -- Fuzzy finder
  use({
    "nvim-telescope/telescope.nvim",
    config = function()
      require("core.plugins.telescope")
    end,
  })

  -- Commenting
  use({
    "numToStr/Comment.nvim",
    requires = {
      {
        after = "nvim-treesitter",
        "JoosepAlviste/nvim-ts-context-commentstring",
      },
    },
    cmd = "Comment",
    module = "Comment.api",
    config = function()
      require("core.plugins.comment")
    end,
  })

  if packer_bootstrap then
    require("packer").sync()
  end
end)
