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
    "org",
  },

  highlight = {
    enable = true,
    use_languagetree = true,
    additional_vim_regex_highlighting = { "org" },
  },

  indent = { enable = true },

  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
})
