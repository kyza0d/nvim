local on_attach = require("servers.handlers").on_attach
local capabilities = require("servers.handlers").capabilities

require("servers.config.lua_ls")
require("servers.config.tsserver")

require("lspconfig").jedi_language_server.setup({})

-- UI Settings

local icons = require("core.options").icons

local signs = {
	{ name = "DiagnosticSignError", text = icons.error },
	{ name = "DiagnosticSignWarn", text = icons.warning },
	{ name = "DiagnosticSignInfo", text = icons.info },
	{ name = "DiagnosticSignHint", text = icons.hint },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.max_width = 90
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
