local status_ok, trouble = pcall(require, "trouble")

if not status_ok then
  return
end

require("trouble").setup({
  padding = false,

  height = 15,

  fold_open = "",
  fold_closed = "",

  action_keys = {
    jump = { "o" },
    jump_close = { "<cr>" },
  },
})

keymap("n", "gr", ":Trouble lsp_references<cr>")
keymap("n", "gD", ":Trouble workspace_diagnostics<cr>")
