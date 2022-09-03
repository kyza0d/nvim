local signs = {
  { name = "DiagnosticSignError", text = " " },
  { name = "DiagnosticSignWarn", text = "𥉉" },
  { name = "DiagnosticSignInfo", text = "𥉉" },
  { name = "DiagnosticSignHint", text = " " },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.max_width = 60
  opts.max_height = 10
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

vim.diagnostic.config({
  virtual_text = false,

  signs = {
    active = signs,
  },

  update_in_insert = true,
  severity_sort = true,
  underline = true,

  float = {
    prefix = "",
    source = "always",
    style = "minimal",
    header = "",
  },
})