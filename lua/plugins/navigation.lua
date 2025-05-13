local fzf_lua = reqcall('fzf-lua')
local file_picker = function(cwd) fzf_lua.files({ cwd = cwd }) end

return {
  {
    'folke/which-key.nvim',
    keys = { '<leader>', '<cr>' },
    event = 'UIEnter',
    config = function()
      reqcall('which-key').setup({
        preset = 'modern',
        icons = {
          separator = '',
          group = '',
        },
        show_help = false,
        show_keys = false,
      })
    end,
  },
  {
    'ibhagwan/fzf-lua',
    init = function()
      keymap('v', '<C-Space>', function()
        reqcall('fzf-lua').live_grep({
          search = helpers.visual_selection(),
        })
      end)

      reqcall('which-key').add({
        { icon = '', group = 'Find', '<leader>f' },
        { icon = ' ', desc = 'Files', '<C-f>', function() fzf_lua.files() end },
        { icon = ' ', desc = 'Live Grep', '<C-Space>', function() fzf_lua.live_grep() end },
        { icon = ' ', desc = 'Git Files', '<leader>ff', function() fzf_lua.git_files() end },
        { icon = ' ', desc = 'Highlights', '<leader>fh', function() fzf_lua.highlights() end },
        { icon = ' ', desc = 'Fzf Menu', '<leader>fa', '<cmd>FzfLua<cr>' },
        { icon = ' ', desc = 'Buffer Grep', '<leader>fb', function() fzf_lua.grep_curbuf() end },
        { icon = ' ', desc = 'Notes', '<leader>fn', function() file_picker('/home/kyza/Notes') end },
        { icon = ' ', desc = 'Help Tags', '<leader>f?', function() fzf_lua.help_tags() end },
        { icon = ' ', desc = 'Old Files', '<cr>r', function() fzf_lua.oldfiles() end },

        { icon = ' ', group = 'Dotfiles', '<leader>fd' },
        { icon = ' ', desc = 'Hypr Config', '<leader>fdh', function() file_picker('/home/kyza/.config/hypr') end },
        { icon = '󱙝 ', desc = 'Ghostty Config', '<leader>fdg', ':e /home/kyza/.config/ghostty/config<cr>' },
        { icon = ' ', desc = 'Nvim Config', '<leader>fdn', function() file_picker('/home/kyza/.config/nvim') end },
        { icon = ' ', desc = 'Kitty Config', '<leader>fdk', ':e /home/kyza/.config/kitty/kitty.conf<cr>' },
        { icon = '', desc = 'Zsh Config', '<leader>fdz', ':e /home/kyza/.zshrc<cr>' },

        { icon = ' ', group = 'Git', '<leader>fg' },
        { icon = ' ', desc = 'Git Commits', '<leader>fgc', fzf_lua.git_commits },
        { icon = ' ', desc = 'Git Branches', '<leader>fgb', fzf_lua.git_branches },

        { icon = ' ', desc = 'Workspace Symbols', '<leader>fs', fzf_lua.lsp_workspace_symbols },
      })
    end,
    config = function() require('config.fzf_lua') end,
  },
  {
    'kevinhwang91/nvim-ufo',
    event = 'BufRead',
    dependencies = { 'kevinhwang91/promise-async' },
    config = function() require('ufo').setup({}) end,
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    keys = { { '<M-e>', '<cmd>Neotree toggle<cr>', mode = 'n' } },
    config = function() require('config.neo_tree') end,
    dependencies = {
      'mrbjarksen/neo-tree-diagnostics.nvim',
      'MunifTanjim/nui.nvim',
    },
  },
  {
    'folke/trouble.nvim',
    init = function()
      reqcall('which-key').add({
        { icon = ' ', '<cr>d', '<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>' },
        { icon = ' ', '<cr>s', '<cmd>Trouble symbols toggle focus=true<cr>' },
        { icon = '󰐻 ', group = 'LSP', '<leader>l' },
        { icon = '󰱽 ', '<leader>ld', '<cmd>Trouble diagnostics toggle focus=true<cr>' },
        { icon = ' ', '<leader>lr', '<cmd>Trouble lsp_references toggle focus=true<cr>' },
        { icon = ' ', 'gr', '<cmd>Trouble lsp_references toggle focus=true<cr>' },
      })
    end,
    config = function(_, opts)
      require('trouble').setup(opts)
      hl.plugin('Trouble', {
        theme = {
          ['*'] = {
            { TroubleNormal = { link = 'Background' } },
            { TroubleFile = { fg = { from = 'Function' }, bg = 'none' } },
            { TroubleSignOther = { fg = { from = 'Special' }, bg = 'none' } },
            { TroubleInformation = { fg = { from = 'Special' }, bg = 'none' } },
          },
        },
      })
    end,
    opts = {
      auto_preview = true,
      indent_guides = false,
    },
    cmd = 'Trouble',
  },
  {
    'akinsho/bufferline.nvim',
    keys = {
      { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
      { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Previous Buffer' },
    },
    init = function()
      reqcall('which-key').add({
        { icon = '', group = 'Buffers', '<leader>b' },
        { icon = '󰐃', desc = 'Pin/Unpin Buffer', '<leader>bp', '<cmd>BufferLineTogglePin<cr>', mode = 'n' },
        { icon = '󱉬', desc = 'Yank Buffer Content', '<leader>by', ':silent %y+<cr>', mode = 'n' },
        { icon = '󰜢', desc = 'Yank Relative Path', '<leader>br', ':let @+ = system("git rev-parse --show-toplevel") . "/" . expand("%")<cr>', mode = 'n' },
        { icon = '󰳻', desc = 'Save Buffer', '<leader>bs', '<cmd>noautocmd silent! w<cr>', mode = 'n' },
      })
    end,
    event = 'UIEnter',
    dependencies = 'moll/vim-bbye',
    config = function() require('config.bufferline') end,
  },
  {
    'dnlhc/glance.nvim',
    keys = {
      {
        'gR',
        '<cmd>Glance references<cr>',
        desc = 'Glance references',
        mode = 'n',
      },
    },
    config = function() require('config.glance') end,
    event = 'LspAttach',
  },
  {
    'mrjones2014/smart-splits.nvim',
    config = function()
      local ss = require('smart-splits')
      keymap({ 'i', 'n', 't' }, '<C-h>', ss.move_cursor_left)
      keymap({ 'i', 'n', 't' }, '<C-j>', ss.move_cursor_down)
      keymap({ 'i', 'n', 't' }, '<C-k>', ss.move_cursor_up)
      keymap({ 'i', 'n', 't' }, '<C-l>', ss.move_cursor_right)
    end,
    opts = {
      move_cursor_same_row = false,
      ignored_filetypes = { 'neo-tree' },
      default_amount = 5,
      resize_mode = {
        quit_key = 'q',
        resize_keys = { 'h', 'j', 'k', 'l' },
        silent = true,
      },
    },
    build = './kitty/install-kittens.bash',
  },
  {
    'MisanthropicBit/winmove.nvim',
    init = function()
      hl.plugin('WinMove', {
        theme = {
          ['*'] = {
            { WinMove = { bg = { from = 'Visual', alter = -0.4 } } },
          },
        },
      })
      local winmove = require('winmove')

      winmove.configure({
        modes = {
          move = { highlight = 'WinMove' },
          swap = { highlight = 'WinMove' },
          resize = { highlight = 'WinMove' },
        },
      })

      keymap('n', '<S-w>', function() winmove.start_mode(winmove.Mode.Move) end, { desc = 'Enter Window Move Mode', nowait = true })
      keymap('n', '<S-r>', function() winmove.start_mode(winmove.Mode.Resize) end, { desc = 'Enter Window Move Mode', nowait = true })

      reqcall('which-key').add({
        { icon = '󱂬', group = 'Windows', '<leader>w' },
        { icon = '←', desc = 'Swap left', '<leader>wh', function() winmove.swap_window_in_direction(1000, 'h') end },
        { icon = '→', desc = 'Swap right', '<leader>wl', function() winmove.swap_window_in_direction(1000, 'l') end },
        { icon = '↓', desc = 'Swap down', '<leader>wj', function() winmove.swap_window_in_direction(1000, 'j') end },
        { icon = '↑', desc = 'Swap up', '<leader>wk', function() winmove.swap_window_in_direction(1000, 'k') end },

        { icon = '', '<leader>w', group = 'Windows' },
        { icon = '', '<leader>ws', desc = 'Split Vertically', '<cmd>vsplit<cr>', mode = 'n' },
        { icon = '', '<leader>wx', desc = 'Split Horizontally', '<cmd>split<cr>', mode = 'n' },
      })
    end,
  },
}
