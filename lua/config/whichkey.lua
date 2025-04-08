local whichkey = require('which-key')

local row = function()
  local height = vim.api.nvim_win_get_height(0)
  local offset = 2
  return height - offset
end

whichkey.setup({
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
})

whichkey.add({
  { icon = '', group = 'leader', '<leader>' },
  { icon = '', group = 'cr', '<cr>' },

  { icon = '', group = 'Find', '<leader>f' },
  { icon = ' ', desc = 'Live Grep', '<c-g>' },
  { icon = '󰅩 ', desc = 'Code Actions', '<c-.>' },
  { icon = ' ', desc = 'Git Files', '<leader>ff' },
  { icon = ' ', desc = 'Highlights', '<leader>fh' },
  { icon = ' ', desc = 'Fzf Menu', '<leader>fa' },
  { icon = ' ', desc = 'Buffer Grep', '<leader>fb' },
  { icon = ' ', desc = 'Recent', '<leader>fr' },
  { icon = ' ', desc = 'Projects', '<leader>fp' },
  { icon = ' ', desc = 'Help', '<leader>f?' },
  { icon = ' ', desc = 'Recent Files', '<cr>r' },

  { icon = ' ', desc = 'Notes', '<leader>n' },

  { icon = ' ', group = 'Notes', '<cr>n' },
  { icon = ' ', desc = 'Open Daily', '<cr>nd', '<cmd>ObsidianToday<cr>' },
  { icon = '󱞳 ', desc = 'Open Daily (Yesterday)', '<cr>ny', '<cmd>ObsidianYesterday<cr>' },
  { icon = '󱞫 ', desc = 'Open Daily (Tomorrow)', '<cr>nt', '<cmd>ObsidianTomorrow<cr>' },
  { icon = ' ', desc = 'Open Ideas', '<cr>ni', '<cmd>e ~/Notes/2025/Journal/Ideas.md<cr>' },

  { icon = ' ', group = 'Dotfiles', '<leader>fd' },
  { icon = ' ', desc = 'Nvim Config', '<leader>fdn' },
  { icon = ' ', desc = 'Kitty Config', '<leader>fdk' },
  { icon = '', desc = 'Zsh Config', '<leader>fdz' },
  { icon = ' ', group = 'Git', '<leader>fg' },
  { icon = ' ', desc = 'Git Commits', '<leader>fgc' },
  { icon = ' ', desc = 'Git Branches', '<leader>fgb' },
  { icon = ' ', desc = 'Workspace Symbols', '<leader>fs' },

  { group = 'Buffers', '<leader>b' },
  { desc = 'Pin', '<leader>bp', '<cmd>BufferLineTogglePin<cr>', mode = 'n' },
  { desc = 'Yank', '<leader>by', ':silent %y+<cr>', mode = 'n' },
})
