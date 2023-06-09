local icons = require("options").neotree

require("neo-tree").setup({
  popup_border_style = "single",

  event_handlers = {
    {
      event = "neo_tree_window_after_open",
      handler = function()
        vim.opt_local.statuscolumn = " "
      end,
    },
  },

  enable_git_status = false,
  enable_diagnostics = true,

  hide_root_node = false,
  retain_hidden_root_indent = true,

  default_component_configs = {
    container = {
      enable_character_fade = false,
    },

    indent = {
      indent_marker = icons.indent_marker,
      last_indent_marker = icons.last_indent_marker,

      indent_size = 2,
      padding = 0,
    },

    icon = {
      folder_open = icons.folder_open,
      folder_closed = icons.folder_closed,
      folder_empty = icons.folder_empty,
    },

    name = {
      use_git_status_colors = true,
    },

    modified = {
      symbol = "",
    },
  },

  window = {
    width = 36,
    mappings = {
      ["l"] = "open",
      ["h"] = "close_node",
    },
  },

  filesystem = {
    filtered_items = {
      visible = true,
      hide_dotfiles = true,
      hide_gitignored = true,
      never_show = {
        ".DS_Store",
      },
    },
    follow_current_file = true,
  },
})
