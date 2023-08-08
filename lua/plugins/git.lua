--------------------------------------------
-- Git integration
--------------------------------------------

return {
  -- Git integration
  --- @url https://github.com/lewis6991/gitsigns.nvim
  {
    'lewis6991/gitsigns.nvim',
    -- event = 'VeryLazy',
    opts = {
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_formatter = '@<author>, <summary>',

      signs = {
        add = { text = '┇' },
        change = { text = '┇' },
        untracked = { text = '┇' },
        topdelete = { text = '' },
        changedelete = { text = '' },
        delete = { text = '' },
      },
    },
  },
}
