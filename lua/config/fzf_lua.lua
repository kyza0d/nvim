local fzf = require('fzf-lua')
local actions = fzf.actions

local function dropdown(opts)
  opts = opts or { winopts = {} }

  return vim.tbl_deep_extend('force', {
    fzf_opts = { ['--layout'] = 'reverse' },

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
    fzf_opts = { ['--layout'] = 'reverse' },

    prompt = '❯ ',

    file_icons = true,
    color_icons = true,

    winopts = {
      split = 'belowright new',

      title = false,
      title_pos = 'left',
      title_flags = false,

      border = 'none',

      height = 0.3,
      width = 1.0,
      row = 0.98,
      col = 0.0,

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
    fd_opts = [[--color=never --type f --hidden --follow -E node_modules -E .git -E .obsidian -E .cache -E .trash -E target -E *.ttf]],
    cwd_prompt = false,
  }),

  oldfiles = dropdown({
    fd_opts = [[--color=never --type f --hidden -E node_modules -E .git -E .obsidian -E .trash -E target -E *.ttf]],
  }),

  grep_curbuf = dropdown({
    rg_opts = '--column --hidden --no-heading --color=always --smart-case --max-columns=4096 -e',
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
    rg_opts = '--column --hidden --no-heading --color=always --smart-case --max-columns=4096 -e',
    no_header = true,
    no_header_i = true,
    winopts = {
      preview = {
        hidden = false,
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

  lsp = {
    cwd_only = true,
    symbols = {
      symbol_style = false,
    },
  },

  fzf_colors = {
    ['fg'] = { 'fg', 'CursorLine' },
    ['bg'] = { 'bg', 'NormalFzf' },
    ['hl'] = { 'fg', 'Comment' },

    ['fg+'] = { 'fg', 'NormalFzf' },
    ['bg+'] = { 'bg', 'PmenuSelFzf' },
    ['hl+'] = { 'fg', 'Statement' },

    ['info'] = { 'fg', 'Comment' },
    ['pointer'] = { 'fg', 'Exception' },
    ['marker'] = { 'fg', '@character' },

    ['prompt'] = { 'fg', 'NormalFzf' },
    ['spinner'] = { 'fg', 'NormalFzf' },

    ['header'] = { 'fg', 'Comment' },

    ['gutter'] = { 'bg', 'NormalFzf' },
    ['separator'] = { 'fg', 'Comment' },
  },

  hls = {
    title = 'FloatTitle',
    normal = 'NormalFzf',
    cursorline = 'none',
    border = 'FloatBorder',

    preview_normal = 'NormalFzf',
    preview_border = 'FloatBorder',
    preview_title = 'FloatTitle',
  },
})
