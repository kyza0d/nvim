return {
  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    version = '*',
    opts = {
      keymap = { preset = 'enter' },
      appearance = { nerd_font_variant = 'mono', use_nvim_cmp_as_default = true },
      cmdline = {
        keymap = { preset = 'cmdline' },
        completion = {
          list = {
            selection = {
              preselect = true,
              auto_insert = true,
            },
          },
          menu = { auto_show = true },
        },
      },
      sources = {
        default = {
          'lsp',
          'path',
          'snippets',
          'buffer',
        },
      },
      completion = {
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
    opts_extend = { 'sources.default' },
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
          [types.choiceNode] = { active = { hl_mode = 'combine', virt_text = { { ' ', 'Operator' } } } },
          [types.insertNode] = { active = { hl_mode = 'combine', virt_text = { { ' ', 'Type' } } } },
        },
      })
      require('luasnip.loaders.from_vscode').lazy_load()
      luasnip.filetype_extend('typescriptreact', { 'javascript', 'typescript' })
    end,
  },
  {
    'zbirenbaum/copilot.lua',
    config = function()
      require('copilot').setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = '<M-j>',
            next = '<M-]>',
            prev = '<M-[>',
            dismiss = '<C-]>',
          },
        },
        panel = { enabled = false },
      })
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup({
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
  { 'onsails/lspkind-nvim', event = { 'CmdlineEnter', 'InsertEnter' } },
  { 'windwp/nvim-ts-autotag', event = { 'InsertEnter' } },
  { 'saecki/live-rename.nvim' },
}
