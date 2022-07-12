local status_ok, indent_blankline = pcall(require, "indent_blankline")

if not status_ok then
  return
end

vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }

vim.g.indent_blankline_show_current_context_start = false

local icons = require("core.utils").getvar("icons")

vim.g.indent_blankline_filetype_exclude = {
  "help",
  "startify",
  "dashboard",
  "packer",
  "TelescopePrompt",
  "NvimTree",
  "Trouble",
}

vim.g.indent_blankline_char = icons.editor_indent
vim.g.indent_blankline_context_char = icons.editor_indent
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_first_indent_level = false
vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_show_current_context = true

indent_blankline.setup({
  show_current_context = true,
})
