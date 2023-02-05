local on_attach = require("servers.handlers").on_attach
local capabilities = require("servers.handlers").capabilities

require("lspconfig").tsserver.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
