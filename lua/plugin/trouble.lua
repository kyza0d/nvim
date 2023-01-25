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
