return {
  {
    'toppair/peek.nvim',
    event = 'VeryLazy',
    build = 'deno task --quiet build:fast',
    opts = {
      app = 'zen-browser',
    },
    config = function()
      ky.command('PeekOpen', require('peek').open, {})
      ky.command('PeekClose', require('peek').close, {})
    end,
  },
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
}
