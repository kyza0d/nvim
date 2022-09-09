local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")

if not status_ok then
  return
end

-- Incremenal Selection
keymap("v", "<C-j>", ":lua require('nvim-treesitter.incremental_selection').node_incremental()<cr>")
keymap("v", "<C-k>", ":lua require('nvim-treesitter.incremental_selection').node_decremental()<cr>")

treesitter.setup({
  ensure_installed = { "lua", "javascript", "typescript", "tsx", "css", "scss" },

  autotag = {
    enable = true,
  },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  indent = {
    enable = true,
  },

  playground = {
    enable = true,
  },
})
