return {
  {
    'saghen/blink.cmp',
    version = '*',
    dependencies = {
      'MahanRahmati/blink-nerdfont.nvim',
    },
    opts = {
      keymap = {
        preset = 'default',
        ['<CR>'] = { 'accept', 'fallback' },
      },
      appearance = {
        nerd_font_variant = 'mono',
        use_nvim_cmp_as_default = true,
        kind_icons = icons.completion,
      },
      cmdline = {
        keymap = {
          preset = 'cmdline',
        },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'nerdfont' },
        per_filetype = {
          codecompanion = { 'codecompanion', 'snippets', 'path' },
          markdown = { 'lsp', 'path', 'snippets', 'buffer', 'nerdfont' },
          picker = {},
        },
        providers = {
          path = { name = 'path', score_offset = 600 },
          lsp = { name = 'lsp', score_offset = 200 },
          snippets = { name = 'snippets', score_offset = 150 },
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
          scrollbar = false,
          draw = {
            padding = { 1, 1 },
            columns = {
              { 'label', gap = 1 },
              { 'kind_icon', 'kind' },
            },
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
    'vidocqh/auto-indent.nvim',
    event = 'BufReadPre',
  },
  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
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
    'chrisgrieser/nvim-scissors',
    event = 'BufEnter',
    opts = { snippetDir = vim.fn.stdpath('config') .. '/snippets' },
  },
}
