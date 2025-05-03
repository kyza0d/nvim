return {
  {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
  },
  {
    'olimorris/persisted.nvim',
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
