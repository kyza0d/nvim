return {
  {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    opts = {
      current_line_blame = false,
      current_line_blame_formatter = '󰚼 <author>, <summary>',

      signs = {
        add = { text = ' 🮇' },
        change = { text = ' 🮇' },
        untracked = { text = ' 🮇' },
        topdelete = { text = ' ' },
        changedelete = { text = ' ' },
        delete = { text = ' ' },
      },
    },
  },
}
