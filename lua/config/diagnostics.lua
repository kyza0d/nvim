local M = {}

function M.setup()
  vim.diagnostic.config({
    underline = true,
    virtual_text = false,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = icons.diagnostics.ERROR,
        [vim.diagnostic.severity.WARN] = icons.diagnostics.WARN,
        [vim.diagnostic.severity.INFO] = icons.diagnostics.INFO,
        [vim.diagnostic.severity.HINT] = icons.diagnostics.HINT,
      },
    },
    float = {
      border = 'single',
      format = function(diagnostic)
        return string.format(
          '%s (%s) [%s]',
          diagnostic.message,
          diagnostic.source,
          diagnostic.code or diagnostic.user_data.lsp.code
        )
      end,
    },
  })
end

return M
