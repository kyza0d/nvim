local status_ok, lsp_config = pcall(require, "lspconfig")

if not status_ok then
	return
end

local on_attach = require("plugin.lsp-config.handlers").on_attach
local capabilities = require("plugin.lsp-config.handlers").capabilities

lsp_config.sumneko_lua.setup({
	on_attach = on_attach,
	capabilities = capabilities,

	settings = {
		Lua = {
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

require'lspconfig'.tsserver.setup{
	on_attach = on_attach,
	capabilities = capabilities,
}
