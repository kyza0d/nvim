local status_ok, trouble = pcall(require, "trouble")

if not status_ok then
  return
end

require("trouble").setup()

keymap("n", "gr", ":Trouble lsp_references<cr>")
keymap("n", "gD", ":Trouble workspace_diagnostics<cr>")
