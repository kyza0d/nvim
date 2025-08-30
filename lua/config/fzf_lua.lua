local fzf = require('fzf-lua')
local actions = fzf.actions

local function dropdown(opts)
  opts = opts or { winopts = {} }

  return vim.tbl_deep_extend('force', {
    winopts = {
      title = false,
      border = 'none',
      height = 0.3,
      width = 1.0,
      row = 0.98,
      col = 0.0,

      preview = {
        title = false,
        border = 'none',
        number = false,
        hidden = 'hidden',
        layout = 'vertical',
        vertical = 'up:50%',
        scrollbar = false,

        winopts = {
          number = false,
        },
      },
    },
  }, opts)
end

fzf.setup({
  defaults = {
    prompt = '❯ ',

    file_icons = true,
    color_icons = true,

    winopts = {
      split = 'belowright new',

      height = 0.3,
      width = 1.0,
      row = 0.98,
      col = 0.0,

      title = false,
      title_pos = 'left',
      title_flags = false,

      border = 'none',

      backdrop = 100,

      preview = {
        title = false,
        border = 'none',
        number = false,
        layout = 'horizontal',
        vertical = 'up:50%',
        scrollbar = false,

        winopts = {
          number = false,
          layout = 'horizontal',
          vertical = 'up:50%',
        },
      },
    },
  },

  actions = {
    files = {
      ['enter'] = actions.file_edit_or_qf,
      ['ctrl-s'] = actions.file_vsplit,
      ['ctrl-x'] = actions.file_split,
    },
  },

  files = dropdown({
    fd_opts = [[--color=never --type f --hidden --follow -E .next -E node_modules -E .venv -E dist -E .git -E .obsidian -E .cache -E .trash -E target -E *.ttf]],
    cwd_prompt = false,
  }),

  oldfiles = dropdown({
    fd_opts = [[--color=never --type f --hidden -E node_modules -E .git -E .obsidian -E .trash -E target -E *.ttf]],
  }),

  grep_curbuf = dropdown({
    winopts = {
      preview = {
        hidden = false,
        layout = 'horizontal',
        winopts = {
          number = false,
          border = 'none',
        },
      },
    },
  }),

  grep = dropdown({
    file_icons = false,
    color_icons = false,
    no_header = true,
    no_header_i = true,
    winopts = {
      preview = {
        title = true,
        title_pos = 'left',
        hidden = false,
        border = 'empty',
        layout = 'horizontal',
      },
    },
  }),

  fzf_opts = {
    ['--info'] = 'hidden',
    ['--layout'] = 'default',
    ['--border'] = 'none',
    ['--no-separator'] = '',
    ['--no-scrollbar'] = '',
  },

  fzf_colors = {
    ['pointer'] = { 'fg', '@accent.fg.500' },
    ['fg'] = { 'fg', 'Normal' },
    ['bg+'] = { 'bg', { 'Pmenu' } },
    ['fg+'] = { 'fg', '@base.fg.300' },
    ['hl'] = { 'fg', '@base.fg.300' },
    ['hl+'] = { 'fg', '@base.fg.100' },
    ['prompt'] = { 'fg', '@base.fg.500' },
    ['gutter'] = '-1',
  },

  hls = {
    title = 'PickerTitle',
    border = 'PickerBorder',
    preview_border = 'Normal',
    preview_normal = 'Normal',
    preview_title = '@accent.fg.500',
  },

  lsp = {
    cwd_only = true,
    symbols = {
      symbol_style = false,
    },
  },
})
