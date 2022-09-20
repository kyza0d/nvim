local status_ok, neotree = pcall(require, "neo-tree")

if not status_ok then
  return
end

local icons = require("options").icons

neotree.setup({
  enable_git_status = false,
  enable_diagnostics = false,

  hide_root_node = true,
  retain_hidden_root_indent = true,

  default_component_configs = {

    container = {
      enable_character_fade = false,
    },

    indent = {
      -- indent_marker = "🭴",
      -- last_indent_marker = "🭴 ",

      indent_marker = icons.indent_marker,
      last_indent_marker = icons.last_indent_marker,

      indent_size = 2,
      padding = 0,
    },

    icon = {
      folder_open = icons.folder_open,
      folder_closed = icons.folder_closed,
      folder_empty = icons.folder_empty,

      -- folder_closed = "  ",
      -- folder_open = "  ",
      -- folder_empty = "  ",
    },

    name = {
      use_git_status_colors = true,
    },

    modified = {
      symbol = "",
    },
  },

  window = {
    width = 35,
    position = "right",
    mappings = {
      ["l"] = "open",
      ["h"] = "close_node",
    },
  },

  renderers = {
    directory = {
      -- { "indent" },
      { "icon" },
      { "current_filter" },
      { "name" },
      { "symlink_target", highlight = "NeoTreeSymbolicLinkTarget" },
      { "clipboard" },
    },
    file = {
      { "indent" },
      { "icon" },
      {
        "container",
        width = "98%",
        content = {
          { "name", zindex = 1 },
          { "clipboard", zindex = 1 },
          { "bufnr", zindex = 1 },
          { "modified", zindex = 2, align = "right" },
          { "diagnostics", zindex = 2, align = "right" },
          { "git_status", zindex = 2, align = "right" },
        },
      },
    },
  },

  filesystem = {
    filtered_items = {
      visible = true,
      hide_dotfiles = false,
      hide_gitignored = true,
      never_show = {
        ".DS_Store",
      },
    },
  },
})

keymap("n", "<C-n>", ":Neotree focus toggle<cr>") -- Toggle filetree
