local status_ok, null_ls = pcall(require, "null-ls")

if not status_ok then
  return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  sources = {
    -- Sylua
    null_ls.builtins.formatting.stylua,

    -- Prettier
    null_ls.builtins.formatting.prettierd,

    -- EsLint
    null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.code_actions.eslint_d,

    -- Markdown
    null_ls.builtins.formatting.markdownlint,

    -- Code Blocks
    null_ls.builtins.formatting.cbfmt,
  },

  -- Format on save
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})
