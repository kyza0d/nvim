return {
  --------------------------------------------
  -- LSP, Formatter/Linters
  --------------------------------------------

  -- LSP Configurations
  --- @url https://github.com/williamboman/mason-lspconfig.nvim
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

  -- Extended LSP Capabilities
  --- @url https://github.com/jose-elias-alvarez/null-ls.nvim
  {
    'jose-elias-alvarez/null-ls.nvim',
    init = function() require('config.null-ls') end,
  },

  -- LSP Server Installer
  --- @url https://github.com/williamboman/mason.nvim
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    build = ':MasonUpdate',
    dependencies = 'nvim-lua/plenary.nvim',
    opts = { ui = { height = 0.8 } },
  },

  -- LSP Inlay Hints
  --- @url https://github.com/lvimuser/lsp-inlayhints.nvim
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

  -- Schemas for JSON files
  --- @url https://github.com/b0o/schemastore.nvim
  'b0o/schemastore.nvim',

  -- Goto definitions/references window
  --- @url https://github.com/dnlhc/glance.nvim
  {
    'dnlhc/glance.nvim',
    opts = { preview_win_opts = { relativenumber = false } },
    event = 'LspAttach',
  },

  -- Incremental Renames
  --- @url https://github.com/smjonas/inc-rename.nvim
  {
    'smjonas/inc-rename.nvim',
    opts = { hl_group = 'Visual', preview_empty_name = true },
    event = 'LspAttach',
  },

  -- Show LSP progress
  --- @url https://github.com/j-hui/fidget.nvim
  {
    'j-hui/fidget.nvim',
    event = 'BufReadPost',
    tag = 'legacy',
    opts = {
      window = {
        blend = 0,
      },
      text = { spinner = 'dots_ellipsis' },
    },
  },
}
