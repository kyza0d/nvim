local status_ok, trouble = pcall(require, "trouble")

if not status_ok then
  return
end

require("trouble").setup({
  padding = false,

  height = 10,

  fold_open = "",
  fold_closed = "",

  action_keys = {
    jump = { "o" },
    jump_close = { "<cr>" },
  },

  use_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client
})

keymap("n", "gr", ":Trouble lsp_references<cr>")
keymap("n", "gD", ":Trouble workspace_diagnostics<cr>")
