--------------------------------------------
-- Editor Tools
--------------------------------------------

return {

  -- Discord Rich Presence
  --- @url https://github.com/andweeb/presence.nvim
  {
    'andweeb/presence.nvim',
    -- event = 'BufReadPre',
    enabled = true,
    opts = {
      auto_update = true,
    },
  },

  -- Measure startup time
  --- @url https://github.com/dstein64/vim-startuptime
  {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
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
