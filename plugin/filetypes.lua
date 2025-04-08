if not ky then return end
local settings = ky.settings

vim.treesitter.language.register('bash', 'sh')
vim.treesitter.language.register('gitcommit', 'NeogitCommitMessage')
vim.treesitter.language.register('png', 'jpeg')

settings({
  [{ '*' }] = {
    group = 'default',
    exclude = {
      filetypes = { 'fzf', 'fugitive', 'telescope' },
      buftypes = { 'prompt', 'nofile', 'terminal' },
    },
  },
  [{
    'kitty',
    'lua',
    '.zsh',
  }] = {
    group = 'config',
    options = {
      commentstring = '# %s',
    },
    commands = {
      {
        event = 'BufWritePost',
        pattern = 'kitty.conf',
        callback = function()
          vim.fn.system('kill -SIGUSR1 $(pgrep kitty)')
          vim.notify('Restarted', 'info', { title = 'kitty.conf' })
        end,
      },
    },
  },
  [{
    'javascript',
    'typescript',
    'javascriptreact',
    'typescriptreact',
  }] = {
    group = 'coding',
    options = {
      shiftwidth = 2,
      tabstop = 2,
    },
  },
  [{ 'markdown', 'help' }] = {
    group = 'notes',
  },
  [{
    'neo-tree',
    'neo-tree-popup',
    'Trouble',
  }] = {
    group = 'panel',
  },
  [{ 'toggleterm' }] = {
    group = 'term',
  },
})
