local P = ky.ui.palette
local hl = ky.hl

return {
  { 'chrisgrieser/nvim-spider', opts = {} },
  {
    'mrjones2014/smart-splits.nvim',
    opts = {
      move_cursor_same_row = false,
      ignored_filetypes = { 'neo-tree' },
      resize_mode = {
        quit_key = 'q',
        resize_keys = { 'h', 'j', 'k', 'l' },
        silent = true,
      },
    },
    build = './kitty/install-kittens.bash',
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    init = function()
      hl.plugin('Flash', {
        theme = {
          FlashLabel = { fg = P.magenta, bold = true },
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
