local status_ok, indent_blankline = pcall(require, "indent_blankline")

if not status_ok then
  return
end

-- vim.cmd.nvim_command()

vim.g.indent_blankline_char = "▏"
vim.g.indent_blankline_context_char = "▏"
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_use_treesitter = false

vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "markdown", "vimwiki", "packer" }

indent_blankline.setup({
  enabled = true,
  show_current_context = true,
  -- show_current_context_start = true,
})
