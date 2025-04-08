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
}
