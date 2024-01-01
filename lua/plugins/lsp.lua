--------------------------------------------
-- LSP, Formatter/Linters
--------------------------------------------

return {
  {
    'RRethy/vim-illuminate',
    opts = {
      delay = 300,
      large_file_cutoff = 2000,
      filetypes_denylist = {
        'popup',
      },
      large_file_overrides = {
        providers = { 'lsp' },
      },
    },
    config = function(_, opts) require('illuminate').configure(opts) end,
    event = 'CursorHold',
  },
  {
    'smjonas/inc-rename.nvim',
    opts = { hl_group = 'Visual', preview_empty_name = true },
    event = 'VeryLazy',
  },
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
            opts = { library = { plugins = { 'nvim-dap-ui' } } },
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
            ['j'] = actions.next,
            ['k'] = actions.previous,
            ['l'] = actions.open_fold,
            ['h'] = actions.close_fold,
            ['<Tab>'] = actions.enter_win('preview'),
            ['<C-u>'] = actions.preview_scroll_win(5),
            ['<C-d>'] = actions.preview_scroll_win(-5),
            ['<CR>'] = actions.jump,
          },
          preview = {
            ['q'] = actions.close,
            ['<Tab>'] = actions.enter_win('list'), -- Focus list window
          },
        },
      })
    end,
  },

  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        -- Customize or remove this keymap to your liking
        '<leader>f',
        function() require('conform').format({ async = true, lsp_fallback = true }) end,
        mode = '',
        desc = 'Format buffer',
      },
    },
    -- Everything in opts will be passed to setup()
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        javascript = { { 'prettierd', 'prettier' } },
        json = { { 'prettierd', 'prettier' } },
      },
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
    },

    init = function()
      -- If you want the formatexpr, here is the place to set it
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,

    -- This function is optional, but if you want to customize formatters do it here
    config = function(_, opts)
      local util = require('conform.util')
      util.add_formatter_args(require('conform.formatters.shfmt'), { '-i', '2' })
      require('conform').setup(opts)
    end,
  },
  {
    'lvimuser/lsp-inlayhints.nvim',
    event = 'VeryLazy',
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
}
