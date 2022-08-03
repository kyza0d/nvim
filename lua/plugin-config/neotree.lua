local highlights = require("neo-tree.ui.highlights")

require("neo-tree").setup({

  enable_diagnostics = false,
  enable_git_status = true,

  default_component_configs = {
    name = {
      use_git_status_colors = true,
    },

    indent = {
      indent_marker = "▕",
      last_indent_marker = "▕",
      expander_highlight = "NeoTreeExpander",
    },

    icon = {
      folder_closed = " ",
      folder_open = " ",
      folder_empty = " ",
    },

    modified = {
      symbol = "",
    },

    git_status = {
      symbols = false,
    },
  },

  window = {
    width = 40,
    height = vim.o.lines,

    mappings = {
      ["l"] = "open",
      ["h"] = "close_node",
    },
  },

  filesystem = {
    follow_current_file = true,
    use_libuv_file_watcher = true,
    components = {
      name = function(config, node)
        local name = node.name
        local highlight = config.highlight or highlights.FILE_NAME
        if node.type == "directory" then
          highlight = highlights.DIRECTORY_NAME
          name = name .. "/"
        end
        return {
          text = name,
          highlight = highlight,
        }
      end,
    },
  },

  renderers = {
    root_directory = {},
    directory = {
      { "indent" },
      { "icon" },
      { "current_filter" },
      {
        "container",
        width = "100%",
        right_padding = 1,
        --max_width = 60,
        content = {
          { "name", zindex = 10 },
          { "clipboard", zindex = 10 },
          { "diagnostics", errors_only = true, zindex = 20, align = "right" },
        },
      },
    },
    file = {
      { "indent" },
      { "icon" },
      {
        "container",
        width = "100%",
        right_padding = 1,
        content = {
          {
            "name",
            use_git_status_colors = true,
            zindex = 10,
          },
          { "clipboard", zindex = 10 },
          { "bufnr", zindex = 10 },
          { "modified", zindex = 20, align = "right" },
          { "diagnostics", zindex = 20, align = "right" },
          { "git_status", zindex = 20, align = "right" },
        },
      },
    },
  },
})
