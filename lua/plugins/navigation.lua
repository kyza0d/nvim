local hl, helpers = ky.hl, ky.helpers
local ui, reqcall = ky.ui, ky.reqcall
local keymap = vim.keymap.set

local icons = ui.icons
local fzf_lua = reqcall('fzf-lua')
local file_picker = function(cwd) fzf_lua.files({ cwd = cwd }) end

return {
  {
    'folke/which-key.nvim',
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
    keys = {
      '<c-w>',
      '<leader>',
      '<cr>',
    },
  },
  {
    'ibhagwan/fzf-lua',
    init = function()
      reqcall('which-key').add({
        { icon = '', group = 'Find', '<leader>f' },
        { icon = ' ', desc = 'Files', '<c-f>', function() fzf_lua.files() end },
        { icon = ' ', desc = 'Live Grep', '<c-g>', function() fzf_lua.live_grep() end },
        { icon = '󰅩 ', desc = 'Code Actions', '<c-.>', function() fzf_lua.lsp_code_actions() end },
        { icon = ' ', desc = 'Git Files', '<leader>ff', function() fzf_lua.git_files() end },
        { icon = ' ', desc = 'Highlights', '<leader>fh', function() fzf_lua.highlights() end },
        { icon = ' ', desc = 'Fzf Menu', '<leader>fa', '<Cmd>FzfLua<CR>' },
        { icon = ' ', desc = 'Buffer Grep', '<leader>fb', function() fzf_lua.grep_curbuf() end },
        { icon = ' ', desc = 'Resume', '<leader>fr', function() fzf_lua.resume() end },
        { icon = ' ', desc = 'Notes', '<leader>fn', function() file_picker('/home/kyza/Notes') end },
        { icon = ' ', desc = 'Projects (Grep CurBuf)', '<leader>fp', function() fzf_lua.grep_curbuf() end },
        { icon = ' ', desc = 'Help Tags', '<leader>f?', function() fzf_lua.help_tags() end },
        { icon = ' ', desc = 'Old Files', '<cr>r', function() fzf_lua.oldfiles() end },

        { icon = ' ', group = 'Dotfiles', '<leader>fd' },
        { icon = ' ', desc = 'Hypr Config', '<leader>fdh', function() file_picker('/home/kyza/.config/hypr') end },
        { icon = ' ', desc = 'Nvim Config', '<leader>fdn', function() file_picker('/home/kyza/.config/nvim') end },
        { icon = ' ', desc = 'Kitty Config', '<leader>fdk', ':e /home/kyza/.config/kitty/kitty.conf<cr>' },
        { icon = '', desc = 'Zsh Config', '<leader>fdz' },

        { icon = ' ', group = 'Git', '<leader>fg' },
        { icon = ' ', desc = 'Git Commits', '<leader>fgc', fzf_lua.git_commits },
        { icon = ' ', desc = 'Git Branches', '<leader>fgb', fzf_lua.git_branches },

        { icon = ' ', desc = 'Workspace Symbols', '<leader>fs', fzf_lua.lsp_workspace_symbols },
        { icon = ' ', desc = 'Workspace Symbols (Ctrl-S)', '<C-s>', fzf_lua.lsp_workspace_symbols },
      })

      keymap('v', '<c-g>', function() reqcall('fzf-lua').live_grep({ search = helpers.visual_selection() }) end, { desc = 'Live Grep Visual Selection' })
    end,
    config = function()
      local fzf = require('fzf-lua')
      local actions = fzf.actions
      local prompt = icons.misc.fzf
      local function dropdown(opts)
        opts = opts or { winopts = {} }
        return vim.tbl_deep_extend('force', {
          prompt = prompt,
          fzf_opts = { ['--layout'] = 'reverse' },
          winopts = {
            title = opts.winopts.title,
            title_pos = opts.winopts.title and 'left' or nil,
            height = 0.4,
            width = 1.0,
            row = 0.98,
            col = 0.0,
            preview = {
              hidden = 'hidden',
              layout = 'vertical',
              vertical = 'up:50%',
            },
          },
          preview = {
            winopts = {
              border = 'none',
              number = false,
            },
          },
        }, opts)
      end

      fzf.setup({
        prompt = prompt,
        winopts = {
          border = 'empty',
          backdrop = 100,
        },
        actions = {
          files = {
            ['enter'] = actions.file_edit_or_qf,
            ['ctrl-s'] = actions.file_vsplit,
            ['ctrl-x'] = actions.file_split,
          },
        },
        oldfiles = dropdown({
          winopts = {
            title = 'Old files ',
          },
        }),
        files = dropdown({
          fd_opts = [[--color=never --type f --hidden --follow -E node_modules -E .git -E .obsidian -E .trash -E target -E *.ttf]],
          winopts = {
            title = 'Files ',
          },
        }),
        grep = dropdown({
          prompt = ' ',
          winopts = {
            title = 'Grep ',
            preview = {
              hidden = false,
              layout = 'horizontal',
              border = 'empty',
            },
          },
          rg_opts = '--column --hidden --no-heading --color=always --smart-case --max-columns=4096 -e',
          fzf_opts = {
            ['--keep-right'] = '',
          },
        }),
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
          },
          code_actions = dropdown({
            winopts = { title = 'Code actions' },
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
    'folke/trouble.nvim',
    init = function()
      reqcall('which-key').add({
        { icon = ' ', '<cr>d', '<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>', desc = 'Document Diagnostics' },
        { icon = ' ', '<cr>s', '<cmd>Trouble symbols toggle focus=true<cr>', desc = 'Document Symbols' },
        { icon = '󰐻 ', group = 'LSP', '<leader>l' },
        { icon = '󰱽 ', '<leader>ld', '<cmd>Trouble diagnostics toggle focus=true<cr>', desc = 'Workspace Diagnostics' },
        { icon = ' ', '<leader>lr', '<cmd>Trouble lsp_references toggle focus=true<cr>', desc = 'LSP References' },
      })
    end,
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
    cmd = 'Trouble',
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
        modes = { move = { highlight = 'WinMove' } },
      })

      keymap('n', '<C-w>', function() winmove.start_mode(winmove.Mode.Move) end, { desc = 'Enter Window Move Mode' })

      reqcall('which-key').add({
        { icon = '󱂬', group = 'Windows', '<leader>w' },
        { icon = '←', desc = 'Swap left', '<leader>wh', function() winmove.swap_window_in_direction(1000, 'h') end },
        { icon = '→', desc = 'Swap right', '<leader>wl', function() winmove.swap_window_in_direction(1000, 'l') end },
        { icon = '↓', desc = 'Swap down', '<leader>wj', function() winmove.swap_window_in_direction(1000, 'j') end },
        { icon = '↑', desc = 'Swap up', '<leader>wk', function() winmove.swap_window_in_direction(1000, 'k') end },
      })
    end,
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
        '<cmd>Neotree toggle<cr>',
        mode = 'n',
        desc = 'Toggle Neo-tree',
      },
    },
  },
  {
    'kevinhwang91/nvim-ufo',
    event = 'BufRead',
    dependencies = { 'kevinhwang91/promise-async' },
    config = function() require('ufo').setup({}) end,
  },
  {
    'akinsho/bufferline.nvim',
    event = 'UIEnter',
    dependencies = 'moll/vim-bbye',
    config = function() require('config.bufferline') end,
    keys = {
      { '<S-x>', '<cmd>Bd<cr>', desc = 'Delete Buffer' },
      { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
      { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Previous Buffer' },

      { '<C-j>', '<C-w>j', desc = 'Move Down' },
      { '<C-k>', '<C-w>k', desc = 'Move Up' },
      { '<C-h>', '<C-w>h', desc = 'Move Left' },
      { '<C-l>', '<C-w>l', desc = 'Move Right' },
    },
    init = function()
      reqcall('which-key').add({
        { icon = '', group = 'Buffers', '<leader>b' },
        { icon = '󰐃', desc = 'Pin/Unpin Buffer', '<leader>bp', '<cmd>BufferLineTogglePin<cr>', mode = 'n' },
        { icon = '󱉬', desc = 'Yank Buffer Path', '<leader>by', ':silent %y+<cr>', mode = 'n' },

        { icon = '', '<leader>w', group = 'Windows' },
        { icon = '', '<leader>ws', desc = 'Split Vertically', '<cmd>vsplit<cr>', mode = 'n' },
        { icon = '', '<leader>wx', desc = 'Split Horizontally', '<cmd>split<cr>', mode = 'n' },
      })
    end,
  },
}
