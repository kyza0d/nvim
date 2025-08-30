local glance = require('glance')

local actions = glance.actions

glance.setup({
  height = 20,
  detached = true,
  list = {
    position = 'right',
    width = 0.40,
  },
  preview_win_opts = {
    cursorline = false,
    number = false,
  },
  mappings = {
    list = {
      ['<Down>'] = actions.next,
      ['<Up>'] = actions.previous,
      ['<C-n>'] = actions.next_location,
      ['<C-p>'] = actions.previous_location,
      ['<cr>'] = actions.jump,
      ['<C-d>'] = actions.next,
      ['<C-u>'] = actions.previous,
    },
    preview = {
      ['q'] = actions.close,
      ['<Tab>'] = actions.enter_win('list'),
      ['<Esc>'] = actions.close,
      ['<M-a>'] = actions.enter_win('list'),
    },
  },
})
