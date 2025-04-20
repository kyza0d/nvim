local hl = ky.hl

return {
  {
    'echasnovski/mini.ai',
    keys = {
      { 'a', mode = { 'x', 'o' } },
      { 'i', mode = { 'x', 'o' } },
      { 'g[', mode = { 'n', 'x', 'o' } },
      { 'g]', mode = { 'n', 'x', 'o' } },
    },
    opts = function()
      local ai = require('mini.ai')
      return {
        mappings = {
          around_last = 'aN',
          inside_last = 'iN',
        },
        n_lines = 250,
        custom_textobjects = {
          l = { '^()%s*().*()%s*()\n$' },
          e = function()
            return {
              from = { line = 1, col = 1 },
              ---@diagnostic disable-next-line
              to = { line = vim.fn.line('$'), col = math.max(vim.fn.getline('$'):len(), 1) },
            }
          end,
          F = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }, {}),
          c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }, {}),
          o = ai.gen_spec.treesitter({
            a = { '@block.outer', '@conditional.outer', '@loop.outer' },
            i = { '@block.inner', '@conditional.inner', '@loop.inner' },
          }, {}),
        },
      }
    end,
  },
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
