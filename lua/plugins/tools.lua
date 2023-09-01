--------------------------------------------
-- Editor Tools
--------------------------------------------

return {

  -- Measure startup time
  --- @url https://github.com/dstein64/vim-startuptime
  {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
  },

  {
    'folke/persistence.nvim',
    module = 'persistence',
    opts = {
      options = { 'buffers' }, -- sessionoptions used for saving
    },
  },

  -- Preview markdown files
  --- @url https://github.com/iamcco/markdown-preview.nvim
  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && yarn install',
    ft = 'markdown',
    cmd = 'MarkdownPreview',
  },
}
