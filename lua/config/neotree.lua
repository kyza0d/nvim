local icons = require('icons').neotree

local sources = { 'filesystem', 'git_status', 'diagnostics', 'buffers' }

require('neo-tree').setup({
  popup_border_style = 'rounded',
  sources = sources,
  source_selector = {
    winbar = true,
    statusline = false,
    show_separator_on_edge = true,
    separator = { left = ' ', right = ' ' },
    tabs_layout = 'start',
    sources = {
      { source = 'filesystem', display_name = '󰙅 ' },
      { source = 'git_status', display_name = '󰘬 ' },
      { source = 'diagnostics', display_name = ' ' },
      { source = 'buffers', display_name = '  ' },
    },
  },
  commands = {
    filesystem = function() vim.api.nvim_cmd({ cmd = 'Neotree', args = { 'current', 'source=filesystem' } }, {}) end,
    buffers = function() vim.api.nvim_cmd({ cmd = 'Neotree', args = { 'current', 'source=buffers' } }, {}) end,
    git_status = function() vim.api.nvim_cmd({ cmd = 'Neotree', args = { 'current', 'source=git_status' } }, {}) end,
    diagnostics = function() vim.api.nvim_cmd({ cmd = 'Neotree', args = { 'current', 'source=diagnostics' } }, {}) end,
  },
  event_handlers = {
    {
      event = 'neo_tree_window_after_open',
      handler = function() vim.opt_local.statuscolumn = '' end,
    },
  },
  hide_root_node = false,
  enable_git_status = false,
  retain_hidden_root_indent = false,
  default_component_configs = {
    diagnostics = { symbols = { hint = icons.hint, warn = icons.warn, info = icons.info, error = icons.error } },
    indent = {
      indent_size = 3,
      padding = 0,
      indent_marker = icons.indent_marker,
      last_indent_marker = icons.last_indent_marker,
    },
    icon = {
      folder_closed = icons.folders.closed,
      folder_open = icons.folders.expanded,
      folder_empty = icons.folders.empty,
      default = '*',
    },
    name = { trailing_slash = true, use_git_status_colors = false },
  },
  window = {
    width = 40,
    mapping_options = { noremap = true, nowait = true },
    mappings = {
      ['<CR>'] = '',
      ['<C-n>'] = 'close_window',

      ['l'] = 'open',
      ['h'] = 'close_node',
      ['v'] = 'open_vsplit',
      ['K'] = 'expand_all_nodes',

      ['1'] = sources[1],
      ['2'] = sources[2],
      ['3'] = sources[3],
      ['4'] = sources[4],
    },
  },
  filesystem = {
    filtered_items = { hide_dotfiles = false },
    follow_current_file = { enabled = true, leave_dirs_open = true },
  },
})
