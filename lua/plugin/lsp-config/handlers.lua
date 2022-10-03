local M = {}

local status_ok, nvim_navic = pcall(require, "nvim-navic")

if not status_ok then
  return
end

M.on_attach = function(client, bufnr)
  vim.g.navic_silence = true
  nvim_navic.attach(client, bufnr)

  client.server_capabilities.documentFormattingProvider = false

  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup("lsp_document_highlight", {
      clear = false,
    })
    vim.api.nvim_clear_autocmds({
      buffer = bufnr,
      group = "lsp_document_highlight",
    })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end

  keymap("n", "<C-S-j>", function()
    local opts = {
      focusable = true,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      source = "always",
      prefix = " ",
    }
    vim.diagnostic.open_float(nil, opts)
  end)
end

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

capabilities.textDocument.completion.completionItem.snippetSupport = true

capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

M.capabilities = capabilities

return M
