local icons = ky.ui.icons

local servers = {
  tsserver = {},
  lua_ls = {
    settings = {
      Lua = {
        hints = {
          enable = true,
        },

        codeLens = { enable = true },
        format = { enable = false },
        diagnostics = {
          globals = { 'vim' },
        },
        completion = { keywordSnippet = 'Replace', callSnippet = 'Replace' },
        workspace = { checkThirdParty = false },
      },
    },
  },
  rust_analyzer = {
    settings = {
      ['rust-analyzer'] = {
        rustfmt = {
          enableRangeFormatting = true,
        },
      },
    },
  },
}

-- Diagnostic configuration.
vim.diagnostic.config({
  virtual_text = {
    prefix = '',
    spacing = 2,
    format = function(diagnostic)
      local icon = icons.diagnostics[vim.diagnostic.severity[diagnostic.severity]]
      local message = vim.split(diagnostic.message, '\n')[1]
      return string.format('%s  %s ', icon, message)
    end,
  },
})

return function(name)
  local config = name and servers[name] or {}
  if not config then return end
  if type(config) == 'function' then config = config() end
  local ok, cmp_nvim_lsp = ky.pcall(require, 'cmp_nvim_lsp')
  if ok then config.capabilities = cmp_nvim_lsp.default_capabilities() end

  config.capabilities = vim.tbl_deep_extend('keep', config.capabilities or {}, {
    workspace = { didChangeWatchedFiles = { dynamicRegistration = true } },
    textDocument = { foldingRange = { dynamicRegistration = false, lineFoldingOnly = true } },
  })

  return config
end
