require('telescope').setup({
  extensions = {
    undo = {},
  },
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--ignore-case',
    },

    dynamic_preview_title = true,

    file_ignore_patterns = { 'node_modules', 'package-lock.json', 'yarn.lock', 'dist' },
    sorting_strategy = 'ascending',

    borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },

    selection_caret = ' ',
    prompt_prefix = '   ',
    entry_prefix = ' ',

    path_display = { 'truncate' },

    mappings = {
      i = {
        ['<C-[>'] = require('telescope.actions').close,
      },
    },

    layout_config = {
      prompt_position = 'top',
      width = 0.8,
      height = 0.7,
    },

    preview_title = '',
    prompt_title = '',
    results_title = '',

    pickers = {
      file_ignore_patterns = { 'node_modules', 'package-lock.json' },
    },
  },
})

require('telescope').load_extension('undo')
require('telescope').load_extension('project')
