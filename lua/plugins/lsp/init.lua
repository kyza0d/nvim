return {
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    build = ':MasonUpdate',
    dependencies = 'nvim-lua/plenary.nvim',
    opts = { ui = { height = 0.8 } },
  },
  {
    'saecki/live-rename.nvim',
    init = function()
      vim.keymap.set(
        'v',
        'gR',
        function()
          require('live-rename').rename({
            text = helpers.visual_selection(),
            cursorpos = -1,
          })
        end,
        { silent = false }
      )
      vim.keymap.set('n', 'gR', function()
        require('live-rename').rename({
          cursorpos = -1,
        })
      end, { silent = false })
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      automatic_installation = false,
      ensure_installed = {
        'ts_ls',
        'lua_ls',
      },
      handlers = {
        function(name)
          local config = require('plugins.lsp.servers')(name)
          if config then require('lspconfig')[name].setup(config) end
        end,
      },
    },
    dependencies = {
      'mason.nvim',
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
        astro = { 'prettierd' },
        json = { 'prettierd' },
        sh = { 'shfmt' },
        rust = { 'rustfmt' },
      },
      formatters = {
        prettier = {
          prepend_args = { '--prose-wrap', 'always', '--print-width', '80', '--tab-width', '2' },
        },
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
}
