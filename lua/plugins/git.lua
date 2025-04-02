local hl, P = ky.hl, ky.ui.palette

return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    init = function()
      hl.plugin('gitsigns', {
        { GitSignsAdd = { fg = P.green, bg = 'none' } },
        { GitSignsDelete = { fg = P.pale_red, bg = 'none' } },
        { GitSignsChange = { fg = P.light_yellow, bg = 'none' } },
      })
    end,
    opts = {
      current_line_blame = false,
      current_line_blame_formatter = '󰚼 <author>, <summary>',
      signs_staged_enable = false,
      signs = {
        add = { text = '🮈 ', highlight = 'GitSignsAdd' },
        change = { text = '🮈 ' },
        untracked = { text = '🮈 ' },
        topdelete = { text = ' ' },
        changedelete = { text = ' ' },
        delete = { text = '' },
      },
    },
  },
}
