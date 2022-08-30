local M = {}
local navic = require("nvim-navic")

M.on_attach = function(client, bufnr)
	vim.g.navic_silence = true
	navic.attach(client, bufnr)

	client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
end

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

capabilities.textDocument.completion.completionItem.snippetSupport = true

capabilities.textDocument.foldingRange = {
	dynamicRegistration = true,
	lineFoldingOnly = true,
}

M.capabilities = capabilities

return M
