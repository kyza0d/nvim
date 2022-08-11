vim.g.copilot_node_command = "~/.nvm/versions/node/v16.16.0/bin/node"

vim.cmd([[
  imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
  let g:copilot_no_tab_map = v:true
]])

local plugins = {
  -- Plugin manager
  "wbthomason/packer.nvim",

  -- Fuzzy finder
  ["nvim-telescope/telescope.nvim"] = {
    config = "plugin.telescope",
  },

  -- Pair completion
  ["windwp/nvim-autopairs"] = {
    config = function()
      require("nvim-autopairs").setup({
        disable_filetype = { "TelescopePrompt", "vim", "markdown" },
      })
    end,
  },

  -- Inject LSP actions
  ["jose-elias-alvarez/null-ls.nvim"] = {
    config = "language-server.null-ls",
    requires = "jose-elias-alvarez/nvim-lsp-ts-utils",
  },

  -- Display LSP actions in a pretty window
  ["folke/trouble.nvim"] = {
    config = "plugin.trouble",
  },

  -- Surround motions
  ["kylechui/nvim-surround"] = {
    config = function()
      require("nvim-surround").setup()
    end,
  },

  -- Git integration
  ["lewis6991/gitsigns.nvim"] = {
    config = function()
      require("gitsigns").setup({
        signcolumn = false,
      })
    end,
  },

  -- Bufferline
  ["akinsho/bufferline.nvim"] = {
    tag = "v2.4.0",
    config = "plugin.bufferline",
    requires = {
      "moll/vim-bbye",
    },
  },

  "~/github/summer-time/",
  "Mofiqul/vscode.nvim",

  ["~/github/aura/"] = {
    config = "plugin.aura",
  },

  -- Colorscheme manager
  ["~/github/palette.lua/"] = {
    config = "plugin.palette",
  },

  -- Completion engine
  ["hrsh7th/nvim-cmp"] = {
    config = "plugin.completion",
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

      -- Snippet engine
      "L3MON4D3/LuaSnip",
    },
  },

  -- Icons
  ["kyazdani42/nvim-web-devicons"] = {
    config = "plugin.devicons",
  },

  -- LSP folding
  ["kevinhwang91/nvim-ufo"] = {
    requires = "kevinhwang91/promise-async",
    config = function()
      require("ufo").setup()
    end,
  },

  -- Built-in LSP interface
  ["neovim/nvim-lspconfig"] = {
    config = "language-server.lsp-config",
  },

  -- Integrated terminal
  ["akinsho/toggleterm.nvim"] = {
    tag = "v2.1.0",
    config = "plugin.terminal",
  },

  -- Code depth indication
  "SmiteshP/nvim-navic",

  -- Commenting
  ["numToStr/Comment.nvim"] = {
    tag = "v0.6.1",
    requires = "JoosepAlviste/nvim-ts-context-commentstring",
    config = "plugin.comment",
  },

  -- Built-in tree-sitter interface
  ["nvim-treesitter/nvim-treesitter"] = {
    commit = "c2e3938510e8fc2cb89b991afe95ca61a79c4683",
    config = "plugin.treesitter",
  },

  -- File explorer
  ["nvim-neo-tree/neo-tree.nvim"] = {
    tag = "v2.33",
    config = "plugin.neotree",
    requires = {
      "MunifTanjim/nui.nvim",
      "mrbjarksen/neo-tree-diagnostics.nvim",
    },
  },

  ["github/copilot.vim"] = {
    config = function()
      vim.cmd([[
        let g:copilot_filetypes = {
          \ '*': v:true,
          \ }
      ]])
    end,
  },

  -- Indent markers
  ["lukas-reineke/indent-blankline.nvim"] = {
    tag = "v2.19.0",
    config = "plugin.indent",
  },

  -- Keystroke based commands
  ["folke/which-key.nvim"] = {
    config = "plugin.whichkey",
  },

  "nvim-lua/plenary.nvim",
}

local status_ok, packer = pcall(require, "packer")

if status_ok then
  packer.startup({
    function(use)
      for key, plugin in pairs(plugins) do
        pcall(function() -- Don't throw an error if the plugin is not found
          plugin[1] = key -- Use key as plugin name
          if type(plugin) == "table" then -- if the plugin has config values
            if type(plugin.config) == "string" then -- if only a name is provied
              plugin.config = require(plugin.config) -- require config path
            elseif type(plugin.config) == "function" then
              plugin.config = plugin.config() -- or call config function
            end
          end
        end, key, plugin)
        use(plugin)
      end
    end,
  })
end
