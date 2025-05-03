local fzf = require('fzf-lua')
local actions = fzf.actions

local function dropdown(opts)
  opts = opts or { winopts = {} }

  return vim.tbl_deep_extend('force', {
    prompt = icons.misc.fzf,
    fzf_opts = { ['--layout'] = 'reverse' },
    winopts = {
      title = opts.winopts.title,
      title_pos = opts.winopts.title and 'left' or nil,
      height = 0.3,
      width = 1.0,
      row = 0.98,
      col = 0.0,
      preview = {
        number = false,
        hidden = 'hidden',
        layout = 'vertical',
        vertical = 'up:50%',
      },
    },
  }, opts)
end

fzf.setup({
  winopts = {
    border = 'empty',
    backdrop = 100,
  },
  actions = {
    files = {
      ['enter'] = actions.file_edit_or_qf,
      ['ctrl-s'] = actions.file_vsplit,
      ['ctrl-x'] = actions.file_split,
    },
  },
  oldfiles = dropdown({
    winopts = {
      title = 'Old files ',
    },
  }),
  files = dropdown({
    fd_opts = [[--color=never --type f --hidden --follow -E node_modules -E .git -E .obsidian -E .trash -E target -E *.ttf]],
    winopts = {
      title = 'Files ',
    },
  }),
  grep = dropdown({
    prompt = ' ',
    winopts = {
      title = 'Grep ',
      preview = {
        hidden = false,
        layout = 'horizontal',
        border = 'empty',
      },
    },
    rg_opts = '--column --hidden --no-heading --color=always --smart-case --max-columns=4096 -e',
    fzf_opts = {
      ['--keep-right'] = '',
    },
  }),
  fzf_opts = {
    ['--info'] = 'default',
    ['--reverse'] = false,
    ['--layout'] = 'default',
    ['--ellipsis'] = icons.misc.ellipsis,
  },
  lsp = {
    cwd_only = true,
    prompt = ' ',
    symbols = {
      symbol_style = 1,
    },
    code_actions = dropdown({
      winopts = { title = 'Code actions' },
    }),
  },
  fzf_colors = {
    ['fg'] = { 'fg', 'CursorLine' },
    ['bg'] = { 'bg', 'NormalFloat' },
    ['hl'] = { 'fg', 'Comment' },
    ['fg+'] = { 'fg', 'Normal' },
    ['bg+'] = { 'bg', 'PmenuSel' },
    ['hl+'] = { 'fg', 'Statement', 'italic' },
    ['info'] = { 'fg', 'Comment', 'italic' },
    ['pointer'] = { 'fg', 'Exception' },
    ['marker'] = { 'fg', '@character' },
    ['prompt'] = { 'fg', 'Underlined' },
    ['spinner'] = { 'fg', 'DiagnosticOk' },
    ['header'] = { 'fg', 'Comment' },
    ['gutter'] = { 'bg', 'NormalFloat' },
    ['separator'] = { 'fg', 'Comment' },
  },
  hls = {
    title = 'FloatTitle',
    border = 'FloatBorder',
    preview_border = 'FloatBorder',
  },
})
