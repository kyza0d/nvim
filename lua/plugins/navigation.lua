local hl, helpers = ky.hl, ky.helpers
local ui, reqcall = ky.ui, ky.reqcall

local icons = ui.icons
local fzf_lua = reqcall('fzf-lua')
local file_picker = function(cwd) fzf_lua.files({ cwd = cwd }) end

return {
  {
    'folke/which-key.nvim',
    event = 'UIEnter',
    config = function() require('config.whichkey') end,
    keys = { '<c-w>', '<leader>', '<cr>' },
  },
  {
    'ibhagwan/fzf-lua',
    init = function()
      local wk = reqcall('which-key')
      wk.add({
        { icon = '', group = 'Find', '<leader>f' },
        { icon = ' ', desc = 'Live Grep', '<c-g>' },
        { icon = '󰅩 ', desc = 'Code Actions', '<c-.>' },
        { icon = ' ', desc = 'Git Files', '<leader>ff' },
        { icon = ' ', desc = 'Highlights', '<leader>fh' },
        { icon = ' ', desc = 'Fzf Menu', '<leader>fa' },
        { icon = ' ', desc = 'Buffer Grep', '<leader>fb' },
        { icon = ' ', desc = 'Recent', '<leader>fr' },
        { icon = ' ', desc = 'Notes', '<leader>fn' },
        { icon = ' ', desc = 'Projects', '<leader>fp' },
        { icon = ' ', desc = 'Help', '<leader>f?' },
        { icon = ' ', desc = 'Recent Files', '<cr>r' },

        { icon = ' ', group = 'Dotfiles', '<leader>fd' },
        { icon = '` ', desc = 'Hypr Config', '<leader>fdh' },
        { icon = ' ', desc = 'Nvim Config', '<leader>fdn' },
        { icon = ' ', desc = 'Kitty Config', '<leader>fdk' },
        { icon = '', desc = 'Zsh Config', '<leader>fdz' },
        { icon = ' ', group = 'Git', '<leader>fg' },
        { icon = ' ', desc = 'Git Commits', '<leader>fgc' },
        { icon = ' ', desc = 'Git Branches', '<leader>fgb' },
        { icon = ' ', desc = 'Workspace Symbols', '<leader>fs' },
      })

      keymap('v', '<c-g>', function()
        reqcall('fzf-lua').live_grep({
          search = helpers.visual_selection(),
        })
      end)
    end,
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
            preview = {
              hidden = 'hidden',
              layout = 'vertical',
              vertical = 'up:50%',
            },
          },
        }, opts)
      end

      local function cursor_dropdown(opts)
        return dropdown(vim.tbl_deep_extend('force', {
          winopts = {
            row = 1,
            relative = 'cursor',
            height = 0.33,
            width = 0.60,
          },
        }, opts))
      end

      fzf.setup({
        prompt = prompt,
        winopts = {
          border = vim.g.neovide and 'empty' or 'single',
        },
        actions = {
          files = {
            ['enter'] = actions.file_edit_or_qf,
            ['ctrl-s'] = actions.file_vsplit,
            ['ctrl-v'] = actions.file_split,
          },
        },
        oldfiles = dropdown({
          winopts = {
            width = 0.8,
            title = '  Old files ',
          },
        }),
        files = dropdown({
          winopts = {
            width = 0.8,
            title = '  Files ',
          },
        }),
        grep = {
          prompt = ' ',
          winopts = {
            title = ' 󰈭 Grep ',
            width = 0.8,
          },
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
    keys = {
      { '<c-f>', function() reqcall('fzf-lua').files() end },
      { '<c-g>', function() reqcall('fzf-lua').live_grep({ resume = true }) end },
      { '<c-.>', function() reqcall('fzf-lua').lsp_code_actions() end },
      { '<leader>ff', function() reqcall('fzf-lua').git_files() end },
      { '<leader>fh', function() reqcall('fzf-lua').highlights() end },
      { '<leader>fa', '<Cmd>FzfLua<CR>' },
      { '<leader>fb', function() reqcall('fzf-lua').grep_curbuf() end },
      { '<leader>fp', function() reqcall('fzf-lua').grep_curbuf() end },
      { '<leader>fr', function() reqcall('fzf-lua').resume() end },
      { '<leader>f?', function() reqcall('fzf-lua').help_tags() end },
      { '<cr>r', function() reqcall('fzf-lua').oldfiles() end },
      { '<leader>fgc', fzf_lua.git_commits },
      { '<leader>fgb', fzf_lua.git_branches },
      { '<leader>fs', fzf_lua.lsp_workspace_symbols },
      { '<leader>fs', fzf_lua.lsp_workspace_symbols },
      { '<C-s>', fzf_lua.lsp_workspace_symbols },

      { '<leader>fn', function() file_picker('/home/kyza/Notes') end },
      { '<leader>fdh', function() file_picker('/home/kyza/.config/hypr') end },
      { '<leader>fdn', function() file_picker('/home/kyza/.config/nvim') end },
      { '<leader>fdk', ':e /home/kyza/.config/kitty/kitty.conf<cr>' },
    },
  },
  {
    'folke/trouble.nvim',
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
      { '<cr>d', '<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>' },
      { '<cr>s', '<cmd>Trouble symbols toggle focus=true<cr>' },
      { '<leader>ld', '<cmd>Trouble diagnostics toggle focus=true<cr>' },
      { '<leader>lr', '<cmd>Trouble lsp_references toggle focus=true<cr>' },
    },
    cmd = 'Trouble',
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
      },
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
      keymap({ 'n', 't' }, '<C-h>', ss.move_cursor_left)
      keymap({ 'n', 't' }, '<C-j>', ss.move_cursor_down)
      keymap({ 'n', 't' }, '<C-k>', ss.move_cursor_up)
      keymap({ 'n', 't' }, '<C-l>', ss.move_cursor_right)

      keymap({ 'n', 't' }, '<C-S-h>', ss.resize_left)
      keymap({ 'n', 't' }, '<C-S-j>', ss.resize_down)
      keymap({ 'n', 't' }, '<C-S-k>', ss.resize_up)
      keymap({ 'n', 't' }, '<C-S-l>', ss.resize_right)
    end,
    build = './kitty/install-kittens.bash',
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
      { '<S-x>', '<cmd>Bd<cr>' },
      { '<S-l>', '<cmd>BufferLineCycleNext<cr>' },
      { '<S-h>', '<cmd>BufferLineCyclePrev<cr>' },
      { '!', '<cmd>BufferLineGoToBuffer 1<cr>' },
      { '@', '<cmd>BufferLineGoToBuffer 2<cr>' },
      { '#', '<cmd>BufferLineGoToBuffer 3<cr>' },
    },
    init = function()
      local wk = reqcall('which-key')
      wk.add({
        { icon = '', group = 'Buffers', '<leader>b' },
        { icon = '󰐃', desc = 'Pin', '<leader>bp', '<cmd>BufferLineTogglePin<cr>', mode = 'n' },
        { icon = '󱉬', desc = 'Yank', '<leader>by', ':silent %y+<cr>', mode = 'n' },
      })
    end,
  },
}
