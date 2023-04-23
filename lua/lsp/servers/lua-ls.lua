local on_attach = require("lsp.config.handlers").on_attach
local capabilities = require("lsp.config.handlers").capabilities

require("lspconfig").lua_ls.setup({
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
