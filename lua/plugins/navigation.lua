local hl = ky.hl
local ui, reqcall = ky.ui, ky.reqcall
local icons = ui.icons
local fzf_lua = reqcall('fzf-lua')
local file_picker = function(cwd) fzf_lua.files({ cwd = cwd }) end

return {
  {
    'folke/which-key.nvim',
    lazy = false,
    event = 'UIEnter',
    config = function() require('config.whichkey') end,
    keys = { '<c-w>', '<leader>', '<cr>' },
  },
  {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    config = function(_, opts)
      hl.plugin('Trouble', {
        theme = {
          ['*'] = {
            { TroubleFile = { fg = { from = 'Function' }, bg = 'none' } },
            { TroubleSignOther = { fg = { from = 'Special' }, bg = 'none' } },
            { TroubleInformation = { fg = { from = 'Special' }, bg = 'none' } },
          },
        },
      })
      require('trouble').setup(opts)
    end,
    keys = {
      { '<leader>ld', '<cmd>Trouble diagnostics toggle focus=true<cr>', desc = 'Diagnostics (Trouble)' },
      { '<cr>d', '<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>', desc = 'Buffer Diagnostics (Trouble)' },
      { '<leader>cs', '<cmd>Trouble symbols toggle focus=true<cr>', desc = 'Symbols (Trouble)' },
      { '<leader>cl', '<cmd>Trouble lsp toggle focus=true win.position=right<cr>', desc = 'LSP Definitions / references / ... (Trouble)' },
      { '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List (Trouble)' },
      { '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix List (Trouble)' },
    },
  },
  -- {
  --   'aaronik/treewalker.nvim',
  --   keys = {
  --     { '<C-h>', ':Treewalker Left<cr>', silent = true, mode = { 'n' } },
  --     { '<C-j>', ':Treewalker Down<cr>', silent = true, mode = { 'n' } },
  --     { '<C-k>', ':Treewalker Up<cr>', silent = true, mode = { 'n' } },
  --     { '<C-l>', ':Treewalker Right<cr>', silent = true, mode = { 'n' } },
  --   },
  -- },
  {
    'ibhagwan/fzf-lua',
    cmd = 'FzfLua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '<c-f>', function() reqcall('fzf-lua').files() end, desc = 'find files' },
      { '<c-g>', function() reqcall('fzf-lua').live_grep() end, desc = 'live grep' },
      { '<c-.>', function() reqcall('fzf-lua').lsp_code_actions() end, desc = 'code actions' },
      { '<leader>ff', function() reqcall('fzf-lua').git_files() end, desc = 'find files' },
      { '<leader>fa', '<Cmd>FzfLua<CR>', desc = 'builtins' },
      { '<leader>fb', function() reqcall('fzf-lua').grep_curbuf() end, desc = 'current buffer fuzzy find' },
      { '<leader>fr', function() reqcall('fzf-lua').resume() end, desc = 'resume picker' },
      { '<leader>f?', function() reqcall('fzf-lua').help_tags() end, desc = 'help' },
      { '<cr>r', function() reqcall('fzf-lua').oldfiles() end, desc = 'Most (f)recently used files' },
      { '<leader>fdn', function() file_picker('/home/kyza/.config/nvim') end, desc = 'nvim config' },
      { '<leader>fdk', ':e /home/kyza/.config/kitty/kitty.conf<cr>', desc = 'kitty config' },
      { '<leader>fgc', fzf_lua.git_commits, desc = 'commits' },
      { '<leader>fgb', fzf_lua.git_branches, desc = 'branches' },
      { '<leader>fs', fzf_lua.lsp_workspace_symbols, desc = 'workspace symbols' },
    },
    config = function()
      local fzf = require('fzf-lua')
      local lsp_kind = require('lspkind')
      local actions = fzf.actions
      local prompt = icons.misc.fzf

      local function dropdown(opts)
        opts = opts or { winopts = {} }
        return vim.tbl_deep_extend('force', {
          prompt = prompt,
          fzf_opts = { ['--layout'] = 'reverse' },
          winopts = {
            title = opts.winopts.title,
            title_pos = opts.winopts.title and 'center' or nil,
            height = 0.70,
            width = 0.45,
            row = 0.1,
            preview = { hidden = 'hidden', layout = 'vertical', vertical = 'up:50%' },
          },
        }, opts)
      end

      local function cursor_dropdown(opts)
        return dropdown(vim.tbl_deep_extend('force', {
          winopts = { row = 1, relative = 'cursor', height = 0.33, width = 0.20 },
        }, opts))
      end

      fzf.setup({
        prompt = prompt,
        actions = {
          files = {
            ['enter'] = actions.file_edit_or_qf,
            ['ctrl-v'] = actions.file_split,
            ['ctrl-s'] = actions.file_vsplit,
          },
        },
        files = dropdown({
          winopts = { width = 0.8, title = '  Files ' },
        }),
        grep = {
          prompt = ' ',
          winopts = { title = ' 󰈭 Grep ' },
          rg_opts = '--column --hidden --line-number --no-heading --color=always --smart-case --max-columns=4096 -e',
          fzf_opts = {
            ['--keep-right'] = '',
          },
        },
        fzf_opts = {
          ['--info'] = 'default',
          ['--reverse'] = false,
          ['--layout'] = 'default',
          ['--ellipsis'] = icons.misc.ellipsis,
        },
        lsp = {
          cwd_only = true,
          prompt = ' ',
          symbols = {
            symbol_style = 1,
            symbol_icons = lsp_kind.symbols,
          },
          code_actions = cursor_dropdown({
            winopts = { title = '  Code actions' },
          }),
        },
        fzf_colors = {
          ['fg'] = { 'fg', 'CursorLine' },
          ['bg'] = { 'bg', 'NormalFloat' },
          ['hl'] = { 'fg', 'Comment' },
          ['fg+'] = { 'fg', 'Normal' },
          ['bg+'] = { 'bg', 'PmenuSel' },
          ['hl+'] = { 'fg', 'Statement', 'italic' },
          ['info'] = { 'fg', 'Comment', 'italic' },
          ['pointer'] = { 'fg', 'Exception' },
          ['marker'] = { 'fg', '@character' },
          ['prompt'] = { 'fg', 'Underlined' },
          ['spinner'] = { 'fg', 'DiagnosticOk' },
          ['header'] = { 'fg', 'Comment' },
          ['gutter'] = { 'bg', 'NormalFloat' },
          ['separator'] = { 'fg', 'Comment' },
        },
        hls = {
          title = 'FloatTitle',
          border = 'FloatBorder',
          preview_border = 'FloatBorder',
        },
      })
    end,
  },
  {
    'chrisgrieser/nvim-spider',
    opts = {},
    keys = {
      { 'w', "<cmd>lua require('spider').motion('w')<CR>", desc = 'Spider-w', mode = { 'n', 'o', 'x' } },
      { 'e', "<cmd>lua require('spider').motion('e')<CR>", desc = 'Spider-e', mode = { 'n', 'o', 'x' } },
      { 'b', "<cmd>lua require('spider').motion('b')<CR>", desc = 'Spider-b', mode = { 'n', 'o', 'x' } },
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
  {
    'mrjones2014/smart-splits.nvim',
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
    config = function()
      local ss = require('smart-splits')

      keymap({ 'n', 't', 'i' }, '<C-h>', ss.move_cursor_left)
      keymap({ 'n', 't', 'i' }, '<C-j>', ss.move_cursor_down)
      keymap({ 'n', 't', 'i' }, '<C-k>', ss.move_cursor_up)
      keymap({ 'n', 't', 'i' }, '<C-l>', ss.move_cursor_right)

      keymap({ 'n', 't' }, '<C-S-h>', ss.resize_left)
      keymap({ 'n', 't' }, '<C-S-j>', ss.resize_down)
      keymap({ 'n', 't' }, '<C-S-k>', ss.resize_up)
      keymap({ 'n', 't' }, '<C-S-l>', ss.resize_right)
    end,
    build = './kitty/install-kittens.bash',
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    config = function() require('config.neo-tree') end,
    dependencies = {
      'mrbjarksen/neo-tree-diagnostics.nvim',
      'MunifTanjim/nui.nvim',
    },
    keys = {
      {
        '<M-e>',
        function()
          local width = vim.o.columns
          require('neo-tree.command').execute({
            source = 'last',
            position = width > 120 and 'left' or 'bottom',
            toggle = true,
          })
        end,
        desc = 'Toggle Neo-tree',
        mode = 'n',
      },
    },
  },
  {
    'akinsho/bufferline.nvim',
    event = 'BufWinEnter',
    dependencies = 'moll/vim-bbye',
    config = function() require('config.bufferline') end,
    keys = {
      {
        '<S-l>',
        '<cmd>BufferLineCycleNext<cr>',
        desc = 'Next buffer (Bufferline)',
        mode = 'n',
      },
      {
        '<S-h>',
        '<cmd>BufferLineCyclePrev<cr>',
        desc = 'Previous buffer (Bufferline)',
        mode = 'n',
      },
      {
        '<S-x>',
        '<cmd>Bd<cr>',
        desc = 'Close buffer (Bufferline)',
        mode = 'n',
      },
    },
  },
}
