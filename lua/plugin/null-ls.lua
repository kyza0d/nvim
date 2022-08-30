local status_ok, null_ls = pcall(require, "null-ls")

if not status_ok then
  return
end

require("null-ls").setup({
  sources = {
    null_ls.builtins.formatting.stylua,
  },
  debug = true,
})
