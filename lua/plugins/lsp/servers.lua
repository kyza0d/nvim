local servers = {
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim', 'P', 'describe', 'it', 'before_each', 'after_each', 'packer_plugins', 'pending' },
        },
      },
      runtime = {
        version = 'LuaJIT',
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
    },
  },
  jedi_language_server = {},
  astro_language_server = {},
  markdown_toc = {},
  qmlls = {},
}

return function(name)
  local config = name and servers[name] or {}
  if not config then return end
  if type(config) == 'function' then config = config() end
  config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
  return config
end
