return {
  {
    'vidocqh/auto-indent.nvim',
    event = 'BufReadPre',
  },
  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
  },
  {
    'MagicDuck/grug-far.nvim',
    event = 'BufReadPost',
    cmd = 'GrugFar',
    init = function()
      reqcall('which-key').add({
        { icon = ' ', '<leader>fr', '<cmd>GrugFar<cr>' },
      })
    end,
    opts = {
      icons = {
        enabled = true,
        fileIconsProvider = 'first_available',
        actionEntryBullet = ' ',
        searchInput = '  ',
        replaceInput = '  ',
        filesFilterInput = '  ',
        flagsInput = '󰮚  ',
        pathsInput = '󰉖  ',
      },
    },
    keys = {
      {
        '<M-s>',
        function()
          require('grug-far').grug_far({
            prefills = {
              search = vim.fn.expand('<cword>'),
            },
          })
        end,
        desc = 'Search and replace current word',
        mode = 'n',
      },
      {
        '<M-s>',
        function() require('grug-far').with_visual_selection() end,
        desc = 'Search and replace visual selection',
        mode = 'v',
      },
    },
  },
}
