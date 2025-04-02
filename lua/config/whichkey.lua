local whichkey = require('which-key')

local row = function()
  local height = vim.api.nvim_win_get_height(0)
  local offset = 2
  return height - offset
end

whichkey.setup({
  preset = 'modern',
  icons = {
    breadcrumb = '»',
    separator = '',
    group = '',
  },
  win = {
    col = 0,
    row = tonumber(row),
    title = false,
    width = vim.o.columns * 0.6,
  },
  show_help = false,
  show_keys = false,
})

whichkey.add({
  { icon = '', group = 'leader', '<leader>' },
  { icon = '', group = 'cr', '<cr>' },

  -- [ AI Completion ] -------------------
  { icon = '', group = '  AI', '<leader>a' },
  { icon = '󰆈', desc = ' Ask (avante.nvim)', '<leader>aa', '<cmd>AvanteAsk<cr>', mode = 'n' },
  { icon = '󰂽', desc = ' Open Window (avante.nvim)', '<leader>ao', '<cmd>AvanteAsk<cr>', mode = 'n' },
  { icon = '', desc = ' Toggle Inlay Hints (avante.nvim)', '<leader>ah', noremap = false, mode = 'n' },
  { icon = '', desc = ' Toggle Debug (avante.nvim)', '<leader>ad', noremap = false, mode = 'n' },
  { icon = '', desc = ' Refresh (avante.nvim)', '<leader>ar', noremap = false, mode = 'n' },
  { icon = '', desc = ' Toggle (avante.nvim)', '<leader>at', noremap = false, mode = 'n' },
  { icon = '', desc = ' Edit Code Block (avante.nvim)', '<leader>ae', noremap = false, mode = 'n' },

  -- [ Editor ]
  { icon = '', group = '  Editor', '<leader>e' },
  { icon = '', desc = 'zen mode', '<leader>ez', ':ZenMode<cr>', mode = 'n' },

  -- [ Yazi ]
  { icon = '', group = '  File Broswer', '<leader>.' },
  { icon = '', desc = 'Open file broswer at the current file', '<leader>..', '<cmd>Yazi<cr>', mode = 'n' },
  { icon = '', desc = "Open the file manager in nvim's working directory", '<leader>.o', '<cmd>Yazi cwd<cr>', mode = 'n' },
  { icon = '', desc = 'Resume the last session', '<leader>.r', '<cmd>Yazi toggle<cr>', mode = 'n' },

  -- [ Find files ] -------------------
  { icon = '', group = '  Find', '<leader>f' },
  { icon = '', desc = 'quickfix', '<leader>fq', '<cmd>Trouble quickfix focus=true<cr>', mode = 'n' },

  -- [ Buffers ] -------------------
  { icon = '', group = '  Buffers', '<leader>b' },
  { icon = '', desc = 'Pin', '<leader>bp', '<cmd>BufferLineTogglePin<cr>', mode = 'n' },
  { icon = '', desc = 'Yank', '<leader>by', ':silent %y+<cr>', mode = 'n' },

  -- [ Open files ] -------------------
  { icon = '', group = '󱇨  Open', '<leader>o' },
  { icon = '', desc = 'explorer', '<leader>oe', ':silent !nemo & %<cr>', mode = 'n' },
  { icon = '', desc = 'projects', '<leader>op', ':NeovimProjectDiscover<cr>', mode = 'n' },

  -- [ Rewrite ] -------------------
  { icon = '', group = '  Rewrite', '<leader>r' },
  {
    icon = '',
    desc = 'word',
    '<leader>rw',
    function() require('live-rename').rename({ insert = true, text = vim.fn.expand('<cword>') }) end,
    mode = 'n',
    silent = false,
  },

  -- [ LSP ] -------------------
  { icon = '', group = '  LSP', '<leader>l' },
  -- [ Git, Source Control ] -------------------
  { icon = '', group = '  Git', '<leader>g' },
  { icon = '', desc = 'Lazy git', '<leader>gl', function() editor.terminals.lazygit_toggle() end, mode = 'n' },
  { icon = '', desc = 'Blame line', '<leader>gb', '<cmd>Gitsigns blame_line<cr>', mode = 'n' },
  { icon = '', desc = 'Stage hunk', '<leader>gs', '<cmd>Gitsigns stage_hunk<cr>', mode = 'n' },
  { icon = '', desc = 'Stage selected hunk', '<leader>gs', '<cmd>Gitsigns stage_hunk<cr>', mode = 'v' },
  { icon = '', desc = 'Undo stage hunk', '<leader>gu', '<cmd>Gitsigns undo_stage_hunk<cr>', mode = 'n' },
  { icon = '', desc = 'Reset hunk', '<leader>gr', '<cmd>Gitsigns reset_hunk<cr>', mode = 'n' },
  { icon = '', desc = 'Reset selected hunk', '<leader>gr', '<cmd>Gitsigns reset_hunk<cr>', mode = 'v' },
  { icon = '', desc = 'Next hunk', '<leader>gn', '<cmd>Gitsigns next_hunk<cr>', mode = 'n' },
  { icon = '', desc = 'Prev hunk', '<leader>gp', '<cmd>Gitsigns prev_hunk<cr>', mode = 'n' },
  { icon = '', desc = 'Preview hunk', '<leader>gh', '<cmd>Gitsigns preview_hunk<cr>', mode = 'n' },
  { icon = '', desc = 'Reset buffer', '<leader>gR', '<cmd>Gitsigns reset_buffer<cr>', mode = 'n' },
  { icon = '', desc = 'Stage buffer', '<leader>gS', '<cmd>Gitsigns stage_buffer<cr>', mode = 'n' },
  { icon = '', desc = 'Refresh', '<leader>g<leader>', '<cmd>Gitsigns refresh<cr>', mode = 'n' },
})
