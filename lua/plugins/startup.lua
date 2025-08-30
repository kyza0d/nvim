return {
  {
    'dstein64/vim-startuptime',
    enabled = false,
    lazy = false,
    cmd = 'StartupTime',
  },
  {
    'NStefan002/screenkey.nvim',
    enabled = false,
    lazy = false,
    version = '*',
    init = function()
      local group = create_augroup('screenkey', {
        clear = true,
      })

      create_autocmd('UIEnter', {
        command = 'Screenkey',
        group = group,
      })
    end,
    opts = {
      win_opts = {
        height = 1,
        border = 'none',
      },
      hl_groups = {
        ['screenkey.hl.key'] = { link = 'Normal' },
        ['screenkey.hl.map'] = { link = 'Normal' },
        ['screenkey.hl.sep'] = { link = 'Normal' },
      },
    },
  },
  {
    'olimorris/persisted.nvim',
    enabled = false,
    lazy = false,
    init = function()
      augroup('PersistedEvents', {
        event = 'User',
        pattern = 'PersistedSavePre',
        command = function() vim.cmd('%argdelete') end,
      })
    end,
    opts = {
      silent = true,
      autoload = true,
      use_git_branch = true,
      allowed_dirs = { '/home/kyza/Projects' },
      ignored_dirs = { fn.stdpath('data') },
    },
  },
}
