local icons = require("core.options").icons

require("neo-tree").setup({
  event_handlers = {
    {
      event = "neo_tree_window_after_open",
      handler = function(args)
        vim.opt_local.statuscolumn = ""
      end,
    },
  },

  enable_git_status = false,
  enable_diagnostics = false,

  -- hide_root_node = true,
  retain_hidden_root_indent = true,

  source_selector = {
    winbar = false,
    statusline = false,
  },

  default_component_configs = {

    container = {
      enable_character_fade = false,
    },

    indent = {
      indent_marker = icons.indent_marker,
      last_indent_marker = icons.last_indent_marker,

      indent_size = 2,
      padding = 1,
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
    -- width = 32,
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
    follow_current_file = true, -- This will find and focus the file in the active buffer every
    components = {
      icon = function(config, node, state)
        local icon = config.default
        local padding = config.padding or " "

        local highlight = config.highlight or "Normal"

        if node.type == "directory" then
          highlight = "NeoTreeDirectoryName"
          if node:is_expanded() then
            icon = config.folder_open or "-"
          else
            icon = config.folder_closed or "+"
          end
        elseif node.type == "file" then
          local success, web_devicons = pcall(require, "nvim-web-devicons")
          if success then
            local devicon, hl = web_devicons.get_icon(node.name, node.ext)
            icon = devicon or icon
            highlight = hl or highlight
          end
        end

        return {
          text = icon .. padding,
          highlight = highlight,
        }
      end,
      name = function(config, node)
        local name = node.name
        local highlight = config.highlight
        return {
          text = name,
          highlight = highlight,
        }
      end,
    },
  },
})
