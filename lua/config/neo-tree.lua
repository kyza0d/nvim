local icons = ky.ui.icons.neo_tree

local highlight, P = ky.hl, ky.ui.palette
local uv = vim.loop

local neotree = {
  bg = { from = 'Normal', alter = -0.12 },
  fg = { from = 'Normal', alter = -0.2 },
}

highlight.plugin('NeoTree', {
  theme = {
    ['*'] = {
      { ProjectRoot = { bg = neotree.bg, bold = true } },
      { NeoTreeStatusLine = { bg = neotree.bg, fg = neotree.fg } },
      { NeoTreeStatusLineNC = { bg = neotree.bg, fg = neotree.fg } },
      { NeoTreeNormal = { bg = neotree.bg, fg = neotree.fg } },
      { NeoTreeNormalNC = { bg = neotree.bg, fg = neotree.fg } },
      { NeoTreeWinSeparator = { bg = neotree.bg, fg = { from = 'WinSeparator' } } },
      { NeoTreeDotFile = { fg = { from = 'Comment', alter = -0.4 } } },
      { NeoTreeMessage = { fg = { from = 'Comment', alter = -0.4 } } },
      { NeoTreeEndOfBuffer = { bg = neotree.bg } },
      { NeoTreeCursorLine = { bg = { from = 'NeoTreeNormal', alter = 0.60 } } },
      { NeoTreeRootName = { underline = true } },
      { NeoTreeTabActive = { bg = { from = 'Normal' }, bold = true } },
      { NeoTreeTabInactive = { bg = { from = 'Normal', alter = 0.15 }, fg = { from = 'Comment' } } },
      { NeoTreeTabSeparatorActive = { inherit = 'Normal', fg = { from = 'Comment' } } },
      { NeoTreeTabSeparatorInactive = { inherit = 'NeoTreeTabInactive', fg = { from = 'Normal', attr = 'bg' } } },
      { NeoTreeDirectoryName = { fg = { from = 'Normal', alter = -0.20 } } },
      { NeoTreeDirectoryIcon = { fg = { from = 'Normal', alter = -0.20 } } },
      { NeoTreeGitAdded = { fg = P.green } },
      { NeoTreeGitModified = { fg = P.light_yellow } },
      { NeoTreeGitDeleted = { fg = P.pale_red } },
    },
  },
})

require('neo-tree').setup({
  popup_border_style = 'single',
  sources = { 'filesystem', 'git_status', 'diagnostics', 'buffers', 'document_symbols' },
  source_selector = {
    sources = {
      { source = 'filesystem', display_name = '󰙅 ' },
      { source = 'git_status', display_name = '󰘬 ' },
      { source = 'diagnostics', display_name = ' ' },
      { source = 'buffers', display_name = '  ' },
    },
  },

  default_component_configs = {
    container = {
      right_padding = 0,
      enable_character_fade = false,
    },
    name = {
      trailing_slash = true,
      use_git_status_colors = true,
    },
    modified = {
      symbol = '',
    },
    git_status = {
      symbols = {
        added = icons.git.add,
        modified = icons.git.modified,
        deleted = icons.git.deleted,
        staged = icons.git.staged,
        renamed = icons.git.rename,
        ignored = '',
        conflict = '',
        unstaged = '',
        untracked = '',
      },
    },
    icon = {
      folder_closed = icons.folders.closed,
      folder_open = icons.folders.open,
      folder_empty = icons.folders.empty,
      folder_empty_open = icons.folders.empty_open,
      -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
      -- then these will never be used.
      default = '*',
      highlight = 'NeoTreeFileIcon',
    },
    indent = {
      indent_size = 2,
      padding = 0,
      indent_marker = icons.indent_marker,
      last_indent_marker = icons.last_indent_marker,
    },
  },

  commands = {
    filesystem = function() vim.api.nvim_cmd({ cmd = 'Neotree', args = { 'current', 'source=filesystem' } }, {}) end,
    buffers = function() vim.api.nvim_cmd({ cmd = 'Neotree', args = { 'current', 'source=buffers' } }, {}) end,
    git_status = function() vim.api.nvim_cmd({ cmd = 'Neotree', args = { 'current', 'source=git_status' } }, {}) end,
    diagnostics = function() vim.api.nvim_cmd({ cmd = 'Neotree', args = { 'current', 'source=diagnostics' } }, {}) end,
    open_in_explorer = function()
      -- Open current directory in nemo in the background
      local cmd = 'sh'
      local args = { '-c', string.format('nohup nemo "%s" </dev/null >/dev/null 2>&1 &', vim.fn.expand('%:p:h')) }

      uv.spawn(cmd, {
        args = args,
        detached = true,
      }, function(code)
        if code ~= 0 then print('Shell command exited with code ' .. code) end
      end)
    end,
  },

  hide_root_node = true,
  enable_git_status = false,
  enable_modified_markers = false,
  enable_diagnostics = false,
  git_status_async = true,

  window = {
    width = function()
      local max_width = 30
      return math.min(max_width, math.floor(vim.o.columns * 0.4))
    end,
    height = function() return math.floor(vim.o.lines * 0.4) end,
    mapping_options = { noremap = true, nowait = true },
    mappings = {
      ['P'] = { 'toggle_preview', config = { use_float = true, use_image_nvim = true } },
      ['e'] = 'open_in_explorer',
      ['l'] = 'open',
      ['h'] = 'close_node',
      ['v'] = 'open_vsplit',
      ['K'] = 'expand_all_nodes',
      ['1'] = 'filesystem',
      ['2'] = 'git_status',
      ['3'] = 'diagnostics',
      ['4'] = 'buffers',
    },
  },
  filesystem = {
    components = {
      icon = function(config, node, _)
        local mini_icons = require('mini.icons')
        local icon = config.default or '*'
        local hl = 'MiniIconsBlue'

        if node.type == 'directory' then
          _, hl = mini_icons.get('directory', node.name)
          if node.loaded and not node:has_children() then
            icon = not node.empty_expanded and config.folder_empty or config.folder_empty_open
          elseif node:is_expanded() then
            icon = config.folder_open
          else
            icon, hl = mini_icons.get('directory', node.name)
          end
        else
          icon, hl = mini_icons.get(node.type, node.name)
        end

        return {
          text = icon .. '  ',
          highlight = hl,
        }
      end,
    },
    filtered_items = {
      hide_dotfiles = false,
      hide_hidden = false,
    },
    follow_current_file = {
      enabled = true,
      leave_dirs_open = true,
    },
  },
})
