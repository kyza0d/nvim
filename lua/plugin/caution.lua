require("caution").setup({
  formatting = {
    fields = { "sign", "message", "source" },

    format = function(entry)
      entry.sign = entry.sign .. ": "

      return entry
    end,
  },

  update_on_insert_enter = false,
})
