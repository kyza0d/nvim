local on_attach = require("lsp.config.handlers").on_attach
local capabilities = require("lsp.config.handlers").capabilities

require("lspconfig").tsserver.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
