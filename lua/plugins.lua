local icons = require('options')

return {
  ----------------------------------------------
  -- Motions / Keystrokes
  ----------------------------------------------

  -- Keystroke-based commands --
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function() require('config.whichkey') end,
  },

  -- Surround motions --
  {
    'kylechui/nvim-surround',
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },

  -- Align motions --
  'Vonr/align.nvim',

  ----------------------------------------------
  -- UI, Appearance
  ----------------------------------------------

  {
    'Pocco81/true-zen.nvim',
    opts = {
      modes = { -- configurations per mode
        minimalist = {
          options = {
            statuscolumn = '  ',
            number = false,
            -- statusline = "%{%v:lua.require('statusline').active()%}",
            laststatus = 0,
            cmdheight = 0,
          },
        },
      },
    },
    event = 'VeryLazy',
  },

  { dir = '/home/evan/Plugins/summer-time/', lazy = false },
  { dir = '/home/evan/Plugins/byte-theme/', lazy = false },

  {
    dir = '/home/evan/Plugins/neowal/',
    dependencies = 'kyza2/harmony.nvim',
    priority = 1000,
    lazy = false,
  },

  -- Colorscheme engine --

  -- {
  --   dir = '/home/evan/Plugins/color-space.nvim/',
  --   enable = true,
  --   priority = 1001,
  --   config = function() require('config.color-space') end,
  -- },

  {
    dir = '/home/evan/Plugins/harmony.nvim/',
    enabled = true,
    priority = 1001,
    config = function() require('config.harmony') end,
  },

  -- Indent Lines --
  {
    'lukas-reineke/indent-blankline.nvim',
    enabled = true,
    event = 'BufReadPost',
    init = function()
      vim.g.indent_blankline_char = icons.editor.indent
      vim.g.indent_blankline_context_char = icons.editor.indent
      vim.g.indent_blankline_filetype_exclude = { 'toggleterm', 'telescope' }
      vim.g.indent_blankline_show_trailing_blankline_indent = true
    end,
    opts = {
      show_current_context = true,
      show_current_context_start = false,
    },
  },

  -- Show LSP progress --
  {
    'j-hui/fidget.nvim',
    event = 'BufReadPost',
    opts = {
      window = {
        blend = 0,
      },
      text = { spinner = 'dots_ellipsis' },
    },
  },

  -- Filetype icons --
  {
    'nvim-tree/nvim-web-devicons',
    enabled = true,
    config = function() require('config.devicons') end,
  },

  -- Render colors in files  --
  {
    'NvChad/nvim-colorizer.lua',
    event = 'BufReadPre',
    opts = {
      filetypes = { '*' },
      user_default_options = {
        mode = 'background', -- Set the display mode.
        names = false, -- "Name" codes like Blue or blue
      },
    },
  },

  ---------------------------------------------
  -- LSP, Formatter/Linters
  ----------------------------------------------

  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    build = ':MasonUpdate',
    opts = { ui = { height = 0.8 } },
  },

  -- Language server --
  {
    'williamboman/mason-lspconfig.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'mason.nvim',
      'neovim/nvim-lspconfig',
      'onsails/lspkind.nvim',
    },
    opts = {
      automatic_installation = true,
      handlers = {
        function(name)
          local config = require('servers')(name)
          if config then require('lspconfig')[name].setup(config) end
        end,
      },
    },
  },

  {
    'lvimuser/lsp-inlayhints.nvim',
    enabled = true,
    init = function()
      create_augroup('LspAttach_inlayhints', {})
      create_autocmd('LspAttach', {
        group = 'LspAttach_inlayhints',
        callback = function(args)
          if not (args.data and args.data.client_id) then return end
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          require('lsp-inlayhints').on_attach(client, bufnr)
        end,
      })
    end,
    opts = {
      inlay_hints = {
        highlight = 'Comment',
        labels_separator = ', ',
        parameter_hints = { prefix = '' },
        type_hints = { prefix = ': ', remove_colon_start = true },
      },
    },
  },

  {
    'jose-elias-alvarez/null-ls.nvim',
    init = function() require('config.null-ls') end,
  },

  {
    'SmiteshP/nvim-navbuddy',
    event = 'LspAttach',
    opts = {
      lsp = { auto_attach = true },
      window = {
        size = '100%',
        sections = {
          left = { size = '20%' },
          mid = { size = '20%' },
          right = { preview = 'always' },
        },
      },
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
      'SmiteshP/nvim-navic',
    },
  },

  -- Goto definitions/references window --------
  {
    'dnlhc/glance.nvim',
    opts = { preview_win_opts = { relativenumber = false } },
    event = 'LspAttach',
  },

  -- Incremental Renames -----------------------
  {
    'smjonas/inc-rename.nvim',
    opts = { hl_group = 'Visual', preview_empty_name = true },
    event = 'LspAttach',
  },

  ----------------------------------------------
  -- Editor
  ----------------------------------------------

  -- Language Parser ------------------------
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    version = false,
    event = 'BufReadPost',
    config = function(_, opts) require('nvim-treesitter.configs').setup(opts) end,
    opts = {
      -- stylua: ignore
      ensure_installed = {
        "bash", "css", "gitignore",
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

  -- Fuzzy finder ------------------
  {
    'nvim-telescope/telescope.nvim',
    lazy = false,
    config = function() require('config.telescope') end,
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-symbols.nvim' },
  },

  -- File Explorer -----------------
  {
    'nvim-neo-tree/neo-tree.nvim',
    -- cmd = "Neotree",
    lazy = false,
    config = function() require('config.neotree') end,
    dependencies = 'MunifTanjim/nui.nvim',
  },

  -- Bufferline --------------------
  {
    'akinsho/bufferline.nvim',
    enabled = true,
    event = 'BufReadPre',
    dependencies = 'moll/vim-bbye',
    opts = require('config.bufferline'),
  },

  -- VS Code like winbar ---------
  {
    'utilyre/barbecue.nvim',
    enabled = false,
    event = 'BufReadPre',
    dependencies = {
      'SmiteshP/nvim-navic',
    },
    opts = {
      exclude_filetypes = { 'toggleterm', 'yuck' },
      kinds = false,
      symbols = {
        separator = '|',
        kinds = icons.navic,
      },
    },
  },

  -- Terminal --
  {
    'akinsho/toggleterm.nvim',
    keys = { '<C-\\>' },
    opts = require('config.toggleterm'),
  },

  -- Source Control --
  {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    opts = {
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_formatter = '@<author>, <summary>',

      signs = {
        add = { text = '┇' },
        change = { text = '┇' },
        untracked = { text = '┇' },
        topdelete = { text = '' },
        changedelete = { text = '' },
        delete = { text = '' },
      },
    },
  },

  -- Pretty reference lists
  {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    opts = {},
  },

  -- Highlighted TODO comments --
  {
    'folke/todo-comments.nvim',
    event = 'BufReadPost',
    opts = {
      keywords = {
        ROADMAP = { icon = ' ', color = 'warning' },
      },
    },
  },

  -- Folding --
  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    event = 'BufReadPost',
    config = function() require('config.nvim-ufo') end,
  },

  -- Better text objects --
  {
    'echasnovski/mini.ai',
    keys = {
      { 'a', mode = { 'x', 'o' } },
      { 'i', mode = { 'x', 'o' } },
    },
    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter-textobjects',
        init = function() require('lazy.core.loader').disable_rtp_plugin('nvim-treesitter-textobjects') end,
      },
    },
    opts = function()
      local ai = require('mini.ai')
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { '@block.outer', '@conditional.outer', '@loop.outer' },
            i = { '@block.inner', '@conditional.inner', '@loop.inner' },
          }, {}),
          f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }, {}),
          c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }, {}),
        },
      }
    end,
    config = function(_, opts)
      local ai = require('mini.ai')
      ai.setup(opts)
    end,
  },

  ----------------------------------------------
  -- Comments
  ----------------------------------------------
  {
    'echasnovski/mini.comment',
    event = 'VeryLazy',
    dependencies = 'JoosepAlviste/nvim-ts-context-commentstring',
    config = function(_, opts) require('mini.comment').setup(opts) end,
    opts = {
      hooks = {
        pre = function() require('ts_context_commentstring.internal').update_commentstring({}) end,
      },
    },
  },

  -----------------------------------------------
  -- Source/AI Auto completion
  -----------------------------------------------
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      local autopairs = require('nvim-autopairs')
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done())
      autopairs.setup({
        close_triple_quotes = true,
        disable_filetype = { 'neo-tree-popup' },
        check_ts = true,
        fast_wrap = { map = '<c-e>' },
        ts_config = {
          lua = { 'string' },
          dart = { 'string' },
          javascript = { 'template_string' },
        },
      })
    end,
  },

  -- Completion menu --
  {
    'hrsh7th/nvim-cmp',
    event = { 'CmdlineEnter', 'InsertEnter' },
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-emoji',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'lukas-reineke/cmp-rg',
      'uga-rosa/cmp-dictionary',
    },
    config = function() require('config.nvim-cmp') end,
  },

  -- Snippet engine ----------------------------
  {
    'L3MON4D3/LuaSnip',
    dependencies = { 'rafamadriz/friendly-snippets', 'saadparwaiz1/cmp_luasnip' },
  },

  {
    'github/copilot.vim',
    event = 'InsertEnter',
    init = function()
      vim.g.copilot_filetypes = true
      vim.g.copilot_filetypes = {
        ['*'] = true,
        TelescopePrompt = false,
      }
    end,
  },

  {
    'svermeulen/text-to-colorscheme',
    lazy = false,
    opts = require('config.text-to-colorscheme'),
  },

  ----------------------------------------------
  -- Utilites
  ----------------------------------------------

  {
    'andweeb/presence.nvim',
    event = 'BufReadPre',
    enabled = true,
    opts = {
      auto_update = true,
    },
  },

  -- Extra tree-sitter information --
  {
    'nvim-treesitter/playground',
    cmd = { 'TSPlaygroundToggle', 'TSHighlightCapturesUnderCursor' },
  },

  -- Measure startup time --
  {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
  },

  -- Preview markdown files --
  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && yarn install',
    ft = 'markdown',
    cmd = 'MarkdownPreview',
  },
}
