return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      {
        'sindrets/diffview.nvim',
        config = function()
          require('diffview').setup({
            file_panel = {
              listing_style = 'list',
            },

            hooks = {
              diff_buf_win_enter = function(bufnr, winid, ctx)
                -- Turn off cursor line for diffview windows because of bg conflict
                -- https://github.com/neovim/neovim/issues/9800
                vim.wo[winid].culopt = 'number'
                vim.wo[winid].foldcolumn = '0'
              end,
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
        hunk = { '▌', '▌' },
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
    keys = {
      { ']]', '<cmd>Gitsigns next_hunk<cr>', desc = 'Next hunk' },
      { '[[', '<cmd>Gitsigns prev_hunk<cr>', desc = 'Prev hunk' },
    },
    opts = {
      current_line_blame = false,
      current_line_blame_formatter = '󰚼 <author>, <summary>',
      signs_staged_enable = false,
      signcolumn = true,
      signs = {
        add = { text = '▌ ' },
        change = { text = '▌ ' },
        untracked = { text = '▌ ' },
        topdelete = { text = '╴' },
        changedelete = { text = '╴' },
        delete = { text = '╴' },
      },
    },
  },
}
