return {
  {
    'MagicDuck/grug-far.nvim',
    event = 'BufReadPost',
    cmd = 'GrugFar',
    opts = {},
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
