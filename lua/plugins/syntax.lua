---@diagnostic disable: missing-fields

return {
  { 'vidocqh/auto-indent.nvim', event = 'BufReadPre', opts = {} },
  { 'JoosepAlviste/nvim-ts-context-commentstring', opts = {}, event = 'BufReadPre' },
  {
    'nvim-treesitter/nvim-treesitter',
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
          set_jumps = false, -- whether to set jumps in the jumplist
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
    'windwp/nvim-ts-autotag',
    ft = { 'typescriptreact', 'javascript', 'javascriptreact', 'html', 'vue', 'svelte' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {},
  },
  {
    'nvim-treesitter/playground',
    cmd = { 'TSPlaygroundToggle', 'TSCaptureUnderCursor' },
    dependencies = { 'nvim-treesitter' },
  },
  {
    'kevinhwang91/nvim-ufo',
    event = 'BufRead',
    dependencies = { 'kevinhwang91/promise-async' },
    config = function() require('ufo').setup({}) end,
  },
  {
    'numToStr/Comment.nvim',
    keys = { 'gcc', { 'gc', mode = { 'x', 'n', 'o' } }, '<C-/>' },
    opts = {},
  },
  {
    'folke/todo-comments.nvim',
    event = 'BufReadPost',
    opts = { signs = false },
  },
}
