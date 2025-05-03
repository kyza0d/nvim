return {
  {
    'chrisgrieser/nvim-spider',
    opts = {},
    keys = {
      { 'w', "<cmd>lua require('spider').motion('w')<CR>", mode = { 'n', 'o', 'x' } },
      { 'e', "<cmd>lua require('spider').motion('e')<CR>", mode = { 'n', 'o', 'x' } },
      { 'b', "<cmd>lua require('spider').motion('b')<CR>", mode = { 'n', 'o', 'x' } },
    },
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    init = function()
      hl.plugin('Flash', {
        theme = {
          FlashLabel = { fg = palette.magenta, bold = true },
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
