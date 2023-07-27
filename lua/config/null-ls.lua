local null_ls = require('null-ls')
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

null_ls.setup({
  sources = {
    -- Formatting --

    null_ls.builtins.formatting.stylua.with({
      filetypes = {
        'lua',
      },
    }),

    null_ls.builtins.formatting.stylelint.with({
      filetypes = {
        'scss',
        'css',
      },
    }),

    null_ls.builtins.formatting.rustfmt.with({
      filetypes = {
        'rust',
      },
    }),

    null_ls.builtins.formatting.prettierd.with({
      filetypes = {
        'html',
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'json',
        'jsonc',
      },
    }),

    -- Code Actions --

    null_ls.builtins.code_actions.eslint_d.with({
      filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
      },
    }),
  },
  on_attach = function(client, bufnr)
    if client.supports_method('textDocument/formatting') then
      clear_autocmds({ group = augroup, buffer = bufnr })
      create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function() vim.lsp.buf.format({ bufnr = bufnr }) end,
      })
    end
  end,
})
