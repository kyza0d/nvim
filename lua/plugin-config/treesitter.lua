local status_ok, nvim_treesitter = pcall(require, "nvim-treesitter.configs")

if not status_ok then
  return
end

nvim_treesitter.setup({
  ensure_installed = {
    "javascript",
    "typescript",
    "tsx",
    "lua",
    "vim",
    "css",
    "scss",
    "html",
    "toml",
    "json",
    "bash",
    "jsonc",
    "python",
  },

  incremental_selection = {
    enable = true,
  },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  playground = {
    enable = true,
  },

  indent = {
    enable = true,
    disable = { "scss", "css" },
  },
})
