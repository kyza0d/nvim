local reqcall = ky.reqcall
local icons = ky.ui.icons
local completion_icons = icons.completion
local helpers = ky.helpers

return {
  {
    'saghen/blink.cmp',
    version = '*',
    dependencies = {
      'rafamadriz/friendly-snippets',
      'MahanRahmati/blink-nerdfont.nvim',
      {
        'fang2hou/blink-copilot',
        opts = {
          kind_icon = completion_icons.Copilot,
        },
      },
    },
    opts = {
      keymap = { preset = 'enter' },
      appearance = {
        nerd_font_variant = 'mono',
        use_nvim_cmp_as_default = true,
        kind_icons = completion_icons,
      },
      cmdline = {
        keymap = {
          preset = 'cmdline',
        },
      },
      sources = {
        default = {
          'lsp',
          'copilot',
          'path',
          'snippets',
          'buffer',
          'nerdfont',
        },
        per_filetype = {
          codecompanion = { 'codecompanion' },
        },
        providers = {
          path = {
            name = 'path',
            score_offset = 600,
          },
          copilot = {
            name = 'copilot',
            module = 'blink-copilot',
            max_items = 1,
            score_offset = 250,
            async = true,
          },
          lsp = {
            name = 'lsp',
            score_offset = 200,
          },
          snippets = {
            name = 'snippets',
            score_offset = 150,
          },
          nerdfont = {
            module = 'blink-nerdfont',
            name = 'Nerd Fonts',
            score_offset = 100,
            opts = { insert = true },
          },
        },
      },
      completion = {
        menu = {
          auto_show = true,
          draw = {
            padding = { 0, 1 },
          },
        },
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
        },
        list = {
          selection = {
            auto_insert = function(ctx) return ctx.mode == 'cmdline' and false or true end,
          },
        },
      },
    },
    opts_extend = {
      'sources.default',
    },
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup({
        close_triple_quotes = true,
        disable_filetype = {
          'neo-tree-popup',
        },
        check_ts = true,
        ts_config = {
          lua = { 'string' },
          dart = { 'string' },
          javascript = {
            'template_string',
          },
        },
      })
    end,
  },
  {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = {
          markdown = true,
          help = true,
        },
      })
    end,
  },
  {
    'olimorris/codecompanion.nvim',
    init = function()
      helpers.on_load('codecompanion.nvim', function()
        local wk = reqcall('which-key')
        wk.add({
          {
            icon = '󰱽',
            '<leader>c',
            group = 'Code Companion',
            nowait = false,
            remap = false,
          },
          {
            icon = '󰱽',
            '<leader>cc',
            '<cmd>CodeCompanionChat Toggle<CR>',
            desc = 'Code Companion Actions',
            nowait = false,
            remap = false,
          },
        })
      end)
    end,
    opts = {},
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
  },
  {
    'chrisgrieser/nvim-scissors',
    event = 'BufEnter',
    dependencies = 'nvim-telescope/telescope.nvim',
    opts = {
      snippetDir = vim.fn.stdpath('config') .. '/snippets',
    },
    config = function()
      reqcall('which-key').add({
        {
          icon = '',
          '<leader>s',
          group = 'Snippets',
          nowait = false,
          remap = false,
        },
        {
          icon = '',
          '<leader>sa',
          '<cmd>lua require("scissors").addNewSnippet()<CR>',
          desc = 'Add new snippet',
          nowait = false,
          remap = false,
        },
        {
          icon = '󰲶',
          '<leader>se',
          '<cmd>lua require("scissors").editSnippet()<CR>',
          desc = 'Edit snippet',
          nowait = false,
          remap = false,
        },
      })
    end,
  },
}
