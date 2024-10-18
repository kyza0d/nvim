local open_with_trouble = require('trouble.sources.telescope').open

require('telescope').setup({
  extensions = {
    undo = {},
    project = {
      base_dirs = {
        '~/Projects',
        '~/.config',
      },
    },
  },
  defaults = {
    layout_config = {
      horizontal = {
        height = 0.6,
        preview_cutoff = 120,
        prompt_position = 'top',
        width = 0.9,
      },
    },
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
    sorting_strategy = 'ascending',
    selection_caret = '  ',
    prompt_prefix = '   ',
    entry_prefix = '  ',
    path_display = { 'truncate' },
    borderchars = ky.ui.border.single,
    file_ignore_patterns = { 'node_modules', 'package-lock.json', 'yarn.lock', 'project/*' },
    mappings = {
      i = {
        ['<C-[>'] = require('telescope.actions').close,
        ['<M-e>'] = require('telescope.actions').select_horizontal,
        ['<M-o>'] = require('telescope.actions').select_vertical,
        ['<c-t>'] = open_with_trouble,
      },
    },
  },
})

require('telescope').load_extension('undo')
require('telescope').load_extension('dirpicker')
