local lsp = vim.lsp

local servers = {
  jedi_language_server = {},
  ts_ls = function()
    local function do_organize_imports()
      local params = {
        command = '_typescript.organizeImports',
        arguments = { vim.api.nvim_buf_get_name(0) },
        title = '',
      }
      lsp.buf.execute_command(params)
    end

    return {
      -- cmd = lsp_cmd_override({ ".bin/typescript-language-server", "typescript-language-server" }, { "stdio" }),
      init_options = {
        hostInfo = 'neovim',
        logVerbosity = 'verbose',
      },
      commands = {
        OrganizeImports = {
          do_organize_imports,
          description = 'Organize Imports',
        },
      },
      filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
      },
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = 'literal', -- alts: all
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = false,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      },
    }
  end,
  lua_ls = {
    settings = {
      Lua = {
        codeLens = { enable = true },
        hint = { enable = true, arrayIndex = 'Disable', setType = false, paramName = 'Disable', paramType = true },
        format = { enable = false },
        diagnostics = {
          globals = { 'vim', 'P', 'describe', 'it', 'before_each', 'after_each', 'packer_plugins', 'pending' },
        },
        completion = { keywordSnippet = 'Replace', callSnippet = 'Replace' },
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
  },
}

return function(name)
  local config = name and servers[name] or {}
  if not config then return end
  if type(config) == 'function' then config = config() end
  config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
  return config
end
