local icons = require('options').neotree

local highlights = require('neo-tree.ui.highlights')

require('neo-tree').setup({
  popup_border_style = 'single',

  event_handlers = {
    {
      event = 'neo_tree_window_after_open',
      handler = function() vim.opt_local.statuscolumn = '' end,
    },
  },

  enable_git_status = false,
  enable_diagnostics = true,

  hide_root_node = true,
  retain_hidden_root_indent = true,

  default_component_configs = {
    diagnostics = {
      symbols = {
        hint = '• ',
        info = '• ',
        warn = '• ',
        error = '• ',
      },
    },
    git_status = {
      symbols = {
        -- Change type
        added = '+ ',
        modified = '~ ',
        deleted = '- ',
        renamed = '✘ ',
        untracked = 'x ',
        ignored = 'i ',
        unstaged = '+ ',
        staged = '✔ ',
        conflict = '✘ ',
      },
    },

    container = {
      enable_character_fade = false,
    },

    indent = {
      indent_marker = ' ',
      last_indent_marker = '',
      -- indent_marker = icons.indent_marker,
      -- last_indent_marker = icons.last_indent_marker,

      indent_size = 2,
      padding = 0,
    },

    name = {
      use_git_status_colors = true,
    },

    modified = {
      symbol = '',
    },
  },

  window = {
    position = 'left',
    width = 26,
    mappings = {
      ['l'] = 'open',
      ['h'] = 'close_node',
    },
  },

  filesystem = {
    components = {
      icon = function(config, node)
        local icon = ''
        local padding = ''
        local highlight = config.highlight or highlights.FILE_ICON

        if node.type == 'directory' then
          if node:is_expanded() then
            icon = icons.folder_open
          else
            icon = icons.folder_closed
          end
        end

        if node.type == 'file' then
          local success, web_devicons = pcall(require, 'nvim-web-devicons')
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
        local highlight = config.highlight or highlights.FILE_NAME
        if node.type == 'directory' then
          highlight = highlights.DIRECTORY_NAME
          name = name .. '/'
        end
        if node:get_depth() == 1 then highlight = highlights.ROOT_NAME end
        return {
          text = name,
          highlight = highlight,
        }
      end,
    },

    filtered_items = {
      visible = true,
      hide_dotfiles = true,
      hide_gitignored = true,
      never_show = {
        '.DS_Store',
      },
    },
    follow_current_file = true,
  },
})
