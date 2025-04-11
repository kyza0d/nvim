local hl = ky.hl

return {
  { 'echasnovski/mini.ai', event = 'BufReadPost', opts = {} },
  {
    'tris203/precognition.nvim',
    opts = {
      hints = {
        Caret = { text = '^', prio = 2, highlight = 'Special' },
        Dollar = { text = '$', prio = 1 },
        MatchingPair = { text = '%', prio = 5 },
        Zero = { text = '0', prio = 1 },
        w = { text = 'w', prio = 10 },
        b = { text = 'b', prio = 9 },
        e = { text = 'e', prio = 8 },
        W = { text = 'W', prio = 7 },
        B = { text = 'B', prio = 6 },
        E = { text = 'E', prio = 5 },
      },
    },
  },
  {
    'chrisgrieser/nvim-spider',
    opts = {},
    keys = {
      { 'w', "<cmd>lua require('spider').motion('w')<CR>", mode = { 'n', 'o', 'x' } },
      { 'e', "<cmd>lua require('spider').motion('e')<CR>", mode = { 'n', 'o', 'x' } },
      { 'b', "<cmd>lua require('spider').motion('b')<CR>", mode = { 'n', 'o', 'x' } },
      { '<C-w>', "<Esc>l<cmd>lua require('spider').motion('w')<CR>i", mode = 'i' },
      { '<C-b>', "<Esc><cmd>lua require('spider').motion('b')<CR>i", mode = 'i' },
    },
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    init = function()
      hl.plugin('Flash', {
        theme = {
          FlashLabel = { fg = ky.ui.palette.magenta, bold = true },
        },
      })
    end,
    opts = {
      modes = { char = { highlight = { backdrop = false } } },
      prompt = { enabled = false },
      highlight = { backdrop = false },
    },
  },
}
