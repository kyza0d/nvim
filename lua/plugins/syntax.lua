--------------------------------------------
-- Syntax
--------------------------------------------

return {
  -- Syntax Parser
  --- @url https://github.com/nvim-treesitter/nvim-treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    version = false,
    -- event = 'BufEnterPre',
    lazy = false,
    config = function(_, opts) require('nvim-treesitter.configs').setup(opts) end,

    opts = {
      -- stylua: ignore
      ensure_installed = {
        "bash", "css", "gitignore",
        "html", "java", "javascript", "tsx",
        "typescript", "jsdoc", "json", "jsonc",
        "regex", "rust", "scss", "toml", "vim",
      },
      highlight = { enable = true },
      indent = { enable = true },
      playground = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-k>',
          node_incremental = '<C-k>',
          node_decremental = '<C-j>',
        },
      },

      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
    },
  },

  -- Better text objects
  --- @url https://github.com/echasnovski/mini.ai
  {
    'echasnovski/mini.ai',
    keys = {
      { 'a', mode = { 'x', 'o' } },
      { 'i', mode = { 'x', 'o' } },
    },
    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter-textobjects',
        init = function() require('lazy.core.loader').disable_rtp_plugin('nvim-treesitter-textobjects') end,
      },
    },
    opts = function()
      local ai = require('mini.ai')
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { '@block.outer', '@conditional.outer', '@loop.outer' },
            i = { '@block.inner', '@conditional.inner', '@loop.inner' },
          }, {}),
          f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }, {}),
          c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }, {}),
        },
      }
    end,
    config = function(_, opts)
      local ai = require('mini.ai')
      ai.setup(opts)
    end,
  },

  -- Comments
  --- @url https://github.com/echasnovski/mini.comment
  {
    'echasnovski/mini.comment',
    event = 'VeryLazy',
    dependencies = 'JoosepAlviste/nvim-ts-context-commentstring',
    config = function(_, opts) require('mini.comment').setup(opts) end,
    opts = {
      hooks = {
        pre = function() require('ts_context_commentstring.internal').update_commentstring({}) end,
      },
    },
  },

  -- Extra tree-sitter information
  --- @url https://github.com/nvim-treesitter/playground
  {
    'nvim-treesitter/playground',
    cmd = { 'TSPlaygroundToggle', 'TSHighlightCapturesUnderCursor' },
  },

  {
    'kevinhwang91/nvim-ufo',
    config = function() require('config.nvim-ufo') end,
    event = 'BufReadPre',
    dependencies = 'kevinhwang91/promise-async',
    opts = {},
  },

  {
    'razak17/tailwind-fold.nvim',
    opts = {},
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    ft = { 'html', 'svelte', 'astro', 'vue', 'typescriptreact' },
    pin = true,
  },
}
