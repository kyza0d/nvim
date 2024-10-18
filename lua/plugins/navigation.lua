local hl, P = ky.hl, ky.ui.palette

return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'UIEnter',
    init = function() require('config.telescope') end,
    dependencies = {
      'nvim-telescope/telescope-symbols.nvim',
      'nvim-telescope/telescope-project.nvim',
      'debugloop/telescope-undo.nvim',
      {
        'synic/telescope-dirpicker.nvim',
        opts = {
          prompt_title = 'Pick a Directory',
          enable_preview = true,
          on_select = function(dir) require('telescope.builtin').find_files({ cwd = dir }) end,
        },
      },
      'nvim-lua/plenary.nvim',
    },
  },
  -- [ File Browser ] ------------------------
  -- @url: https://github.com/mikavilpas/yazi.nvim
  {
    'mikavilpas/yazi.nvim',
    event = 'VeryLazy',
    opts = {
      open_for_directories = false,
      keymaps = {
        show_help = '<f1>',
      },
    },
  },
  -- {
  --   'chrisgrieser/nvim-origami',
  --   event = 'BufReadPost',
  --   opts = {},
  -- },
  {
    'folke/which-key.nvim',
    lazy = false,
    event = 'UIEnter',
    config = function() require('config.whichkey') end,
    keys = { '<c-w>', '<leader>', '<cr>' },
  },
  {
    'folke/trouble.nvim',
    event = 'UIEnter',
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
    opts = {
      icons = {
        fold_open = ' ',
        fold_closed = ' ',
      },
      modes = {
        preview_float = {
          mode = 'diagnostics',
          preview = {
            type = 'float',
            relative = 'editor',
            title = 'Preview',
            title_pos = 'center',
          },
        },
        diagnostics = {
          groups = {
            { 'filename', format = '{file_icon} {basename:Title} {count}' },
          },
        },
      },
      keys = {
        ['<C-n>'] = 'next',
        ['<C-p>'] = 'prev',
      },
    },
  },
}
