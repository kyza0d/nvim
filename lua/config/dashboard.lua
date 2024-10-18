local line = ''

-- we're going to be calulating how many lines should be renderd so that the menu is in the middle of the screen.
-- we will begin by getting the height of the window using vim.api.nvim_win_get_height(0)
local height = vim.api.nvim_win_get_height(0)

-- now we will consturct a table based on the height of the window
local padding = {}

for i = 1, height / 4 do
  table.insert(padding, '')
end

require('dashboard').setup({
  theme = 'doom',
  hide = {
    tabline = false,
    statusline = true,
  },
  config = {
    header = padding,
    center = {
      {
        icon = '   ',
        desc = 'Notes',
        key = 'n',
        keymap = 'Space o n ',
        key_hl = 'Function',
        action = 'WhichKey <leader>on',
      },
      {
        icon = '󰱽   ',
        desc = 'Find Files',
        key = 'f',
        key_hl = 'Function',
        keymap = 'Space f f ',
        action = 'Telescope find_files',
      },
      {
        icon = '  ',
        desc = 'Projects',
        key = 'p',
        key_hl = 'Function',
        keymap = 'Space o p ',
        action = 'WhichKey <leader>op',
      },
      {
        icon = '󱋢   ',
        desc = 'Recent Files',
        key = 'r',
        keymap = 'Space f r ',
        key_hl = 'Function',
        action = 'WhichKey <cr>r',
      },
      {
        icon = '󱁼   ',
        desc = 'Dotfiles',
        key = 'd',
        keymap = 'Space o d ',
        key_hl = 'Function',
        action = 'WhichKey <leader>od',
      },
      {
        icon = '󰙅   ',
        desc = 'Explore',
        key = 'e',
        keymap = 'Space o e ',
        key_hl = 'Function',
        action = 'Neotree float',
      },
      {
        icon = '󰅚   ',
        key_hl = 'Hide',
        desc = 'Quit',
        action = 'q!',
      },
    },
    footer = { '  ' .. vim.fn.matchstr(vim.fn.execute('version'), [[NVIM v\zs[^\n]*]]) },
  },
})
