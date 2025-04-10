local wk = require('which-key')

local row = function()
  local height = vim.api.nvim_win_get_height(0)
  local offset = 2
  return height - offset
end

wk.setup({
  preset = 'modern',
  icons = {
    breadcrumb = '»',
    separator = '',
    group = '',
  },
  win = {
    col = 0,
    row = tonumber(row),
    title = false,
    width = vim.o.columns * 0.6,
  },
  show_help = false,
  show_keys = false,

  -- dont show if icon isn't defined, or if it's the avante plugin
  filter = function(key)
    if key.icon == '' then return false end
    return true
  end,
})

wk.add({
  { group = 'leader', icon = '', '<leader>' },
  { icon = '', group = 'cr', '<cr>' },

  { icon = ' ', group = 'Dotfiles', '<leader>fd' },
  { icon = '` ', desc = 'Hypr Config', '<leader>fdh' },
  { icon = ' ', desc = 'Nvim Config', '<leader>fdn' },
  { icon = ' ', desc = 'Kitty Config', '<leader>fdk' },
  { icon = '', desc = 'Zsh Config', '<leader>fdz' },
  { icon = ' ', group = 'Git', '<leader>fg' },
  { icon = ' ', desc = 'Git Commits', '<leader>fgc' },
  { icon = ' ', desc = 'Git Branches', '<leader>fgb' },
  { icon = ' ', desc = 'Workspace Symbols', '<leader>fs' },

  { icon = '', group = 'Avante.nvim', '<leader>a' },
  { icon = '󰆈', desc = ' Ask', '<leader>aa' },
  { icon = '󰆈', desc = ' Clear Avante', '<leader>ax', '<cmd>AvanteClear<cr>' },
  { icon = '󰂽', desc = ' Open Window', '<leader>ao' },
  { icon = '', desc = ' Toggle Inlay Hints', '<leader>ah' },
  { icon = '', desc = ' Toggle Debug', '<leader>ad' },
  { icon = '', desc = ' Refresh', '<leader>ar' },
  { icon = '', desc = ' Edit Code Block', '<leader>ae' },

  { icon = '', group = 'LSP', '<leader>l' },
  { icon = ' ', desc = 'Diagnostics', '<cr>d' },
  { icon = ' ', desc = 'Symbols', '<cr>s' },
  { icon = '󰱽 ', desc = 'Workspace Diagnostics', '<leader>ld' },
  { icon = ' ', desc = 'References', '<leader>lr' },
})
