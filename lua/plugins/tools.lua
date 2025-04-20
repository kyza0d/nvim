return {
  {
    'olimorris/persisted.nvim',
    lazy = false,
    init = function()
      ky.augroup('PersistedEvents', {
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
  {
    'NStefan002/speedtyper.nvim',
    branch = 'v2',
    lazy = false,
  },
}
