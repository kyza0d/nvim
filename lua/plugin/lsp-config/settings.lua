local signs = {
	{ name = "DiagnosticSignError", text = "!" },
	{ name = "DiagnosticSignWarn", text = "!" },
	{ name = "DiagnosticSignHint", text = "?" },
	{ name = "DiagnosticSignInfo", text = "i" },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
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
