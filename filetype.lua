if not vim.filetype then return end

vim.filetype.add({
  extension = {
    lock = 'yaml',
  },
  filename = {
    ['NEOGIT_COMMIT_EDITMSG'] = 'NeogitCommitMessage',
    ['kitty.conf'] = 'kitty',
    ['sxhkdrc'] = 'sxhkdrc',
  },
  pattern = {
    ['.*%.rasi'] = 'rasi',
    ['.*%.conf'] = 'conf',
    ['^.env%..*'] = 'bash',
    ['fonts%.conf'] = 'xml',
  },
})
