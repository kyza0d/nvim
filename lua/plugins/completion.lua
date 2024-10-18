local hl, P = ky.hl, ky.ui.palette

return {
  init = function()
    hl.plugin('NeoCodeium', {
      theme = { ['*'] = {
        { NeoCodeiumSuggestion = { link = 'Comment' } },
      } },
    })
  end,
  {
    'monkoose/neocodeium',
    opts = {
      show_label = false,
      silent = true,
    },
    event = 'BufReadPre',
  },
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    enabled = false,
    build = ':AvanteBuild source=false',
    init = function()
      hl.plugin('Avante', {
        theme = {
          ['*'] = {
            AvanteTitle = { fg = P.magenta, bold = true },
            AvanteSubtitle = { fg = P.light_yellow, bold = true },
          },
        },
      })
    end,
    opts = {
      hints = { enabled = false },
      claude = {
        endpoint = 'https://api.anthropic.com',
        model = 'claude-3-5-sonnet-20240620',
        temperature = 0,
        max_tokens = 4096,
      },
      behaviour = {
        auto_suggestions = true, -- Experimental stage
        auto_set_keymaps = true,
      },
      windows = {
        width = tonumber(vim.o.columns * 0.25),
      },
    },
    dependencies = {
      'echasnovski/mini.icons',
      'nvim-lua/plenary.nvim',
      {
        'grapp-dev/nui-components.nvim',
        dependencies = {
          'MunifTanjim/nui.nvim',
        },
      },
    },
  },

  { 'windwp/nvim-ts-autotag', event = { 'InsertEnter' } },

  {
    'hrsh7th/nvim-cmp',
    event = { 'CmdlineEnter', 'InsertEnter' },
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function() require('config.nvim-cmp') end,
  },

  -- {
  --   'saghen/blink.cmp',
  --   lazy = false,
  --   dependencies = 'rafamadriz/friendly-snippets',
  --   version = 'v0.*',
  --   opts = {
  --     keymap = {
  --       accept = '<CR>',
  --     },
  --     highlight = {
  --       use_nvim_cmp_as_default = true,
  --     },
  --   },
  -- },

  { 'onsails/lspkind-nvim', event = { 'CmdlineEnter', 'InsertEnter' } },

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      local autopairs = require('nvim-autopairs')
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done())
      autopairs.setup({
        close_triple_quotes = false,
        disable_filetype = { 'neo-tree-popup' },
        check_ts = true,
        map_cr = true,
      })
    end,
  },

  {
    'L3MON4D3/LuaSnip',
    event = 'InsertEnter',
    build = 'make install_jsregexp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    config = function()
      local luasnip = require('luasnip')
      local types = require('luasnip.util.types')

      luasnip.config.set_config({
        history = false,
        region_check_events = 'CursorMoved,CursorHold,InsertEnter',
        enable_autosnippets = true,
        delete_check_events = 'InsertLeave',
        ext_opts = {
          [types.choiceNode] = { active = { hl_mode = 'combine', virt_text = { { ' ', 'Operator' } } } },
          [types.insertNode] = { active = { hl_mode = 'combine', virt_text = { { ' ', 'Type' } } } },
        },
      })
      require('luasnip.loaders.from_vscode').lazy_load()
      luasnip.filetype_extend('typescriptreact', { 'javascript', 'typescript' })
    end,
  },
}
