return {
  {
    'nvim-treesitter/nvim-treesitter',
    keys = {
      {
        '<C-j>',
        function() require('nvim-treesitter.incremental_selection').init_selection() end,
        desc = 'Initialize incremental selection',
        mode = 'v',
      },
      {
        '<C-j>',
        function() require('nvim-treesitter.incremental_selection').node_incremental() end,
        desc = 'Increment selection',
        mode = 'v',
      },
      {
        '<C-k>',
        function() require('nvim-treesitter.incremental_selection').node_decremental() end,
        desc = 'Decrement selection',
        mode = 'v',
      },
      {
        '<C-S-k>',
        ':TSTextobjectSwapPrevious @parameter.inner<cr>',
        desc = 'Swap previous parameter (Treesitter)',
        mode = 'n',
      },
      {
        '<C-S-j>',
        ':TSTextobjectSwapNext @parameter.inner<cr>',
        desc = 'Swap next parameter (Treesitter)',
        mode = 'n',
      },
    },
    build = ':TSUpdate',
    dependencies = { { 'nvim-treesitter/nvim-treesitter-textobjects' } },
    config = function(_, opts) require('nvim-treesitter.configs').setup(opts) end,
    opts = {
      -- stylua: ignore
      ensure_installed = {
        "bash", "css", "gitignore",
        "html", "java", "javascript", "tsx",
        "typescript", "jsdoc", "json", "jsonc",
        "regex", "rust", "scss", "toml", "vim",
      },
      highlight = {
        enable = true,
        disable = function(_, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then return true end
        end,
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
          },
        },
        move = {
          enable = true,
          set_jumps = false,
          goto_next_start = { ['[m'] = '@function.outer' },
          goto_next_end = { [']m'] = '@function.outer' },
        },
      },
      incremental_selection = { enable = true },
      indent = { enable = true },
      playground = { enable = true },
    },
  },
  {
    'numToStr/Comment.nvim',
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    init = function()
      local comment = require('Comment.api')
      local key = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
      keymap('n', '<C-/>', function() comment.toggle.linewise.current() end)
      keymap('x', '<C-/>', function()
        vim.api.nvim_feedkeys(key, 'nx', false)
        comment.locked('toggle.linewise')(vim.fn.visualmode())
      end)
    end,
    opts = function(_, opts)
      local ok, tcc = pcall(require, 'ts_context_commentstring.integrations.comment_nvim')
      if ok then opts.pre_hook = tcc.create_pre_hook() end
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    ft = { 'typescriptreact', 'javascript', 'javascriptreact', 'html', 'vue', 'svelte' },
    opts = {},
  },
}
