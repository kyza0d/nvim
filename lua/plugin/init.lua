return {

  "Vonr/align.nvim",

  "JoosepAlviste/nvim-ts-context-commentstring",

  {
    "nvim-treesitter/playground",
    cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
  },

  {
    "tpope/vim-surround",
    event = "BufReadPost",
  },

  {
    "dstein64/nvim-scrollview",
    event = "BufReadPost",
    enabled = false,
    opts = {
      excluded_filetypes = { "neo-tree" },
      current_only = true,
      winblend = 10,
    },
    config = function(_, opts)
      require("scrollview").setup(opts)
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("plugin.config.whichkey")
    end,
  },

  { "folke/tokyonight.nvim", lazy = false },

  { dir = "~/plugins/themes/summer-time", lazy = false },
  { dir = "~/plugins/themes/summer-night", lazy = false },

  {
    "github/copilot.vim",
    event = "InsertEnter",
    init = function()
      vim.cmd([[
        imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
        let g:copilot_no_tab_map = v:true
        let g:copilot_filetypes = {
        \ '*': v:true,
        \ 'TelescopePrompt': v:false,
        \ }
      ]])
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        untracked = { text = "▎" },
        topdelete = { text = "" },
        changedelete = { text = "" },
        delete = { text = "" },
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    version = false, -- last release is way too old and doesn't work on Windows
    event = "BufReadPost",
    opts = {
      -- stylua: ignore
      ensure_installed = {
        "bash", "css", "gitignore", "help",
        "html", "java", "javascript", "tsx",
        "typescript", "jsdoc", "json", "jsonc",
        "regex", "rust", "scss", "toml", "vim",
      },
      indent = { enable = true },
      playground = {
        enable = true,
      },
      context_commentstring = {
        enable = true,
      },
      highlight = {
        enable = true,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    init = function()
      vim.g.indent_blankline_char = "▏"
      vim.g.indent_blankline_context_char = "▏"
      vim.g.indent_blankline_show_trailing_blankline_indent = false
    end,
    opts = {
      show_current_context = true,
      -- show_current_context_start = true,
    },
  },

  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets", "saadparwaiz1/cmp_luasnip" },
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require("servers.null-ls")
        end,
      },
    },
  },

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
    config = function(_, opts)
      require("mini.comment").setup(opts)
    end,
  },

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

  {
    "akinsho/bufferline.nvim",
    event = "BufReadPost",
    opts = require("plugin.config.bufferline"),
    dependencies = "moll/vim-bbye",
  },

  {
    "SmiteshP/nvim-navic",
    init = function()
      vim.g.navic_silence = true
    end,
    opts = require("plugin.config.nvim-navic"),
  },

  {
    dir = "~/plugins/harmony.nvim",
    event = "BufReadPre",
    config = function()
      require("plugin.config.harmony")
    end,
  },

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

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    opts = require("plugin.config.telescope"),
    dependencies = "nvim-lua/plenary.nvim",
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    config = function()
      require("plugin.config.neotree")
    end,
    dependencies = "MunifTanjim/nui.nvim",
  },

  {
    "akinsho/toggleterm.nvim",
    opts = {
      open_mapping = "<C-\\>",
      shade_terminals = false,
      shell = "zsh",
      on_open = function()
        vim.cmd("setlocal foldcolumn=0 | setlocal laststatus=0 | startinsert! | setlocal statuscolumn=")
      end,
      on_close = function()
        vim.cmd("setlocal foldcolumn=2 | setlocal laststatus=3")
      end,
    },
    keys = { "<C-\\>" },
  },

  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("plugin.config.devicons")
    end,
  },

  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
  },
}
