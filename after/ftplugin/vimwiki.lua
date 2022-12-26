if vim.b.loaded_vimwiki_overrides then
  return
end

vim.b.loaded_vimwiki_overrides = 1

vim.api.nvim_buf_del_keymap(0, "n", "<C-CR>")
