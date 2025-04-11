---@diagnostic disable: missing-fields
return {
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    build = ':MasonUpdate',
    dependencies = 'nvim-lua/plenary.nvim',
    opts = { ui = { height = 0.8 } },
  },
  {
    'williamboman/mason-lspconfig.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'mason.nvim',
      {
        'neovim/nvim-lspconfig',
        dependencies = {
          {
            'folke/neodev.nvim',
            ft = 'lua',
            opts = {},
          },
          {
            'folke/neoconf.nvim',
            cmd = { 'Neoconf' },
            opts = { local_settings = '.nvim.json', global_settings = 'nvim.json' },
          },
        },
      },
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
    'dnlhc/glance.nvim',
    event = 'LspAttach',
    init = function()
      local glance = require('glance')
      local actions = glance.actions

      glance.setup({
        theme = { enable = true, mode = 'darken' },
        height = 20,
        list = {
          position = 'right',
          width = 0.40,
        },
        preview_win_opts = {
          cursorline = false,
          number = false,
        },
        mappings = {
          list = {
            ['<Down>'] = actions.next,
            ['<Up>'] = actions.previous,
            ['<C-n>'] = actions.next_location,
            ['<C-p>'] = actions.previous_location,
            ['<cr>'] = actions.jump,
            ['<C-d>'] = actions.next,
            ['<C-u>'] = actions.previous,
          },
          preview = {
            ['q'] = actions.close,
            ['<Tab>'] = actions.enter_win('list'),
            ['<Esc>'] = actions.close,
            ['<M-a>'] = actions.enter_win('list'),
          },
        },
      })
    end,
    keys = {
      {
        'gR',
        '<cmd>Glance references<cr>',
        desc = 'Glance references',
        mode = 'n',
      },
    },
  },
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        javascript = { 'prettierd' },
        json = { 'prettierd' },
        sh = { 'shfmt' },
        rust = { 'rustfmt' },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
    init = function() vim.o.formatexpr = "v:lua.require'conform'.formatexpr()" end,
    config = function(_, opts)
      local util = require('conform.util')
      util.add_formatter_args(require('conform.formatters.shfmt'), { '-i', '2' })
      require('conform').setup(opts)
    end,
  },
  {
    'andrewferrier/debugprint.nvim',
    event = 'BufReadPre',
    opts = {
      keymaps = {
        normal = {
          variable_below = 'g?p',
        },
      },
      commands = {
        toggle_comment_debug_prints = 'ToggleCommentDebugPrints',
      },
    },
    dependencies = {
      'echasnovski/mini.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    version = '*',
  },
}
