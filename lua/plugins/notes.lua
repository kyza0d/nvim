return {
  {
    'vhyrro/neorg',
    enabled = false,
    ft = 'norg',
    version = '*',
    build = ':Neorg sync-parsers',
    opts = require('config.neorg'),
  },
  {
    'lukas-reineke/headlines.nvim',
    ft = { 'org', 'norg', 'markdown', 'yaml' },
    config = function()
      require('headlines').setup({
        org = { headline_highlights = false },
        norg = { headline_highlights = { 'Headline' }, codeblock_highlight = true },
        markdown = { headline_highlights = { 'Headline1' } },
      })
    end,
    dependencies = {
      {
        '3rd/image.nvim',
        opts = {
          backend = 'kitty',
          max_width = 150,
          max_height_window_percentage = 60,
        },
        ft = { 'norg', 'markdown' },
      },
    },
  },
}
