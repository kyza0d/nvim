local status_ok, typescript = pcall(require, "typescript")

if not status_ok then
	return
end

local on_attach = require("plugin.lsp-config.handlers").on_attach

typescript.setup({
    disable_commands = false,
    debug = false,
    server = {
        on_attach = on_attach
    },
})
