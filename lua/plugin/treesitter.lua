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
    additional_vim_regex_highlighting = { "markdown" },
  },

  indent = {
    enable = true,
  },

  playground = {
    enable = true,
  },
})

require("ufo").setup({
  provider_selector = function(bufnr, filetype, buftype)
    return { "treesitter", "indent" }
  end,
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.markdown.filetype_to_parsername = "octo"
