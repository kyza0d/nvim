local status_ok, gitsigns = pcall(require, "gitsigns")

if not status_ok then
  return
end

gitsigns.setup({
  signs = {
    add = { text = "│ " },
      change = { text = "│ " },
    delete = { text = "- " },
    topdelete = { text = "- " },
    changedelete = { text = "~ " },
  },

  numhl = true, -- Toggle with `:Gitsigns toggle_numhl`

  preview_config = {
    border = "single",
  },
})
