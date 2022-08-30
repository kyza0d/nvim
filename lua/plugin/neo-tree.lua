local status_ok, neotree = pcall(require, "neo-tree")

if not status_ok then
  return
end

local highlights = require("neo-tree.ui.highlights")

neotree.setup({
  enable_git_status = true,
  enable_diagnostics = false,

  default_component_configs = {
    git_status = {
      symbols = {
        -- Change type
        added = "✚ ", -- or "✚", but this is redundant info if you use git_status_colors on the name
        modified = "  ", -- or "", but this is redundant info if you use git_status_colors on the name
        deleted = "✖ ", -- this can only be used in the git_status source
        renamed = " ", -- this can only be used in the git_status source
        -- Status type
        untracked = " ",
        ignored = " ",
        unstaged = " ",
        staged = " ",
        conflict = " ",
      },
    },
    container = {
      enable_character_fade = false,
    },
    indent = {
      with_markers = true,
      indent_marker = "│",
      last_indent_marker = "╰",
      expander_highlight = "NeoTreeExpander",
      with_expanders = false,
    },

    icon = {
      folder_closed = " ",
      folder_open = " ",
      folder_empty = " ",
    },

    modified = {
      symbol = "",
    },
  },

  window = {
    width = 40,
    mappings = {
      ["l"] = "open",
      ["h"] = "close_node",
    },
  },

  renderers = {
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
