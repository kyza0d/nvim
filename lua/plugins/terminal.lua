return {
  {
    'akinsho/toggleterm.nvim',
    event = 'VeryLazy',
    enabled = true,
    opts = {
      open_mapping = '<C-\\>',
      autochdir = true,
      shade_terminals = false,
      persist_mode = true,
      start_in_insert = true,
      on_open = function(term)
        vim.opt_local.foldcolumn = '0'
        vim.opt_local.foldenable = false
        vim.opt_local.number = false
        vim.opt_local.statuscolumn = ''
        vim.opt_local.laststatus = 0
        vim.opt_local.signcolumn = 'no'
        vim.opt_local.cmdheight = 0
        vim.defer_fn(function() vim.wo[term.window].winbar = '' end, 0)
      end,

      on_close = function()
        local original_options = require('options')
        for option, value in pairs(original_options) do
          vim.opt[option] = value
        end
      end,
    },
  },
  {
    'willothy/flatten.nvim',
    priority = 1001,
    lazy = false,
    config = {
      window = { open = 'alternate' },
      callbacks = { block_end = function() require('toggleterm').toggle() end },
    },
  },
}
