local on_attach = require("servers.handlers").on_attach
local capabilities = require("servers.handlers").capabilities

require("lspconfig").sumneko_lua.setup({
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
    completion = {
      keywordSnippet = false,
    },
  },
})
