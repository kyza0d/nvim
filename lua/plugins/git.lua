local hl, P = ky.hl, ky.ui.palette

return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    init = function()
      hl.plugin('gitsigns', {
        { GitSignsAdd = { fg = P.green, bg = 'none' } },
        { GitSignsDelete = { fg = P.pale_red, bg = 'none' } },
        { GitSignsChange = { fg = P.light_yellow, bg = 'none' } },
      })
    end,
    opts = {
      current_line_blame = false,
      current_line_blame_formatter = '󰚼 <author>, <summary>',
      signs_staged_enable = false,
      numhl = true,
      signs = {
        add = { text = '▍ ' },
        change = { text = '▍ ' },
        untracked = { text = '▍ ' },
        topdelete = { text = ' ' },
        changedelete = { text = ' ' },
        delete = { text = '' },
      },
    },
  },
  {
    'NeogitOrg/neogit',
    init = function()
      local normal_bg = hl.get('Normal', 'bg')
      local bg_color = hl.tint(normal_bg, -0.25)
      hl.plugin('neogit', {
        { diffAdded = { fg = P.green, bg = hl.blend({ bg_color, P.green }, -0.25), reverse = false } },
        { diffChanged = { fg = P.light_yellow, bg = hl.blend({ bg_color, P.light_yellow }, -0.25), reverse = false } },
        { diffRemoved = { fg = P.pale_red, bg = hl.blend({ bg_color, P.pale_red }, -0.25), reverse = false } },
      })
    end,
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration
    },
    opts = {
      disable_signs = false,
      disable_hint = true,
      disable_commit_confirmation = true,
      disable_builtin_notifications = true,
      disable_insert_on_commit = false,
      signs = {
        section = { '', '󰘕' },
        item = { '▸', '▾' },
        hunk = { '󰐕', '󰍴' },
      },
      integrations = {
        diffview = true,
      },
    },
  },
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
    keys = {
      { '<localleader>gd', '<Cmd>DiffviewOpen<CR>', desc = 'diffview: open', mode = 'n' },
      { 'gh', [[:'<'>DiffviewFileHistory<CR>]], desc = 'diffview: file history', mode = 'v' },
      {
        '<localleader>gh',
        '<Cmd>DiffviewFileHistory<CR>',
        desc = 'diffview: file history',
        mode = 'n',
      },
    },
    opts = {
      default_args = { DiffviewFileHistory = { '%' } },
      enhanced_diff_hl = true,
      hooks = {
        diff_buf_read = function()
          local opt = vim.opt_local
          opt.wrap, opt.list, opt.relativenumber = false, false, false
          opt.colorcolumn = ''
        end,
      },
      keymaps = {
        view = { q = '<Cmd>DiffviewClose<CR>' },
        file_panel = { q = '<Cmd>DiffviewClose<CR>' },
        file_history_panel = { q = '<Cmd>DiffviewClose<CR>' },
      },
    },
    config = function(_, opts)
      hl.plugin('diffview', {
        { DiffviewDiffAdded = { link = 'diffAdded' } },
        { DiffviewDiffModified = { link = 'diffChanged' } },
        { DiffviewDiffRenamed = { link = 'diffChanged' } },
      })
      require('diffview').setup(opts)
    end,
  },
}
