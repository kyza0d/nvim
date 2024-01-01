--------------------------------------------
-- Editor Tools
--------------------------------------------

return {
  {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
  },
  {
    'nvim-colortils/colortils.nvim',
    cmd = 'Colorutils',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = 'MarkdownPreview',
    build = 'cd app && yarn install',
    ft = 'markdown',
  },
}
