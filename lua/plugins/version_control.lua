return {
  {
    'NeogitOrg/neogit',
    init = function()
      reqcall('which-key').add({
        { '<leader><leader>', '<cmd>Neogit<cr>', desc = 'Neogit', icon = '󰊢 ' },
        { '<leader>g', group = 'Git', icon = ' ' },
        { '<leader>gc', '<cmd>Neogit commit<cr>', desc = 'Commit', icon = ' ' },
        { '<leader>gp', '<cmd>Neogit push<cr>', desc = 'Push', icon = '󰏕 ' },
        { '<leader>gl', '<cmd>Neogit pull<cr>', desc = 'Pull', icon = '󰏔 ' },
        { '<leader>gL', '<cmd>Neogit log<cr>', desc = 'Log', icon = '󰋚 ' },
      })
    end,
    dependencies = {
      {
        'sindrets/diffview.nvim',
        config = function()
          require('diffview').setup({
            file_panel = {
              listing_style = 'list',
            },
            keymaps = {
              file_panel = {
                ['j'] = require('diffview.config').actions.select_next_entry,
                ['k'] = require('diffview.config').actions.select_prev_entry,
                ['q'] = '<cmd>DiffviewClose<CR>',
              },
              view = {
                ['q'] = '<cmd>DiffviewClose<CR>',
              },
            },
          })
        end,
      },
      'ibhagwan/fzf-lua',
    },
    opts = {
      disable_signs = false,
      disable_hint = true,
      disable_commit_confirmation = false,
      disable_builtin_notifications = true,
      disable_insert_on_commit = false,
      signs = {
        section = { '', '󰘕' },
        item = { '󰅂 ', ' ' },
        hunk = { '▎', '▎' },
      },
      integrations = {
        fzf_lua = true,
        diffview = true,
      },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    init = function()
      reqcall('which-key').add({
        { icon = ' ', desc = 'Git', '<cr>g' },
        { icon = '󰊢 ', desc = 'Stage ', '<cr>gs', '<cmd>Gitsigns stage_hunk<cr>' },
        { icon = '󰕌 ', desc = 'Undo', '<cr>gu', '<cmd>Gitsigns undo_stage_hunk<cr>' },
        { icon = '󰕍 ', desc = 'Reset', '<cr>gr', '<cmd>Gitsigns reset_hunk<cr>' },
        { icon = ' ', desc = 'Reset', '<cr>gR', '<cmd>Gitsigns reset_buffer<cr>' },
        { icon = ' ', desc = 'Prview', '<cr>gp', '<cmd>Gitsigns preview_hunk<cr>' },
      })

      hl.plugin('gitsigns', {
        { GitSignsAdd = { fg = palette.green, bg = 'none' } },
        { GitSignsDelete = { fg = palette.pale_red, bg = 'none' } },
        { GitSignsChange = { fg = palette.light_yellow, bg = 'none' } },
      })
    end,
    keys = {
      { ']g', '<cmd>Gitsigns next_hunk<cr>', desc = 'Next hunk' },
      { '[g', '<cmd>Gitsigns prev_hunk<cr>', desc = 'Prev hunk' },
    },
    opts = {
      current_line_blame = false,
      current_line_blame_formatter = '󰚼 <author>, <summary>',
      signs_staged_enable = false,
      signcolumn = true,
      signs = {
        add = { text = '▎ ', highlight = 'GitSignsAdd' },
        change = { text = '▎ ' },
        untracked = { text = '▎ ' },
        topdelete = { text = '╴' },
        changedelete = { text = '╴' },
        delete = { text = '╴' },
      },
    },
  },
}
