--------------------------------------------
-- Syntax
--------------------------------------------

return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    version = false,
    event = 'VeryLazy',
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

      incremental_selection = {
        enable = true,
        disable = { 'help' },
        keymaps = {
          init_selection = '<C-j>',
          node_incremental = '<C-j>',
          node_decremental = '<C-k>',
        },
      },

      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['af'] = { query = '@function.outer', desc = 'ts: all function' },
            ['if'] = { query = '@function.inner', desc = 'ts: inner function' },
            ['ac'] = { query = '@class.outer', desc = 'ts: all class' },
            ['ic'] = { query = '@class.inner', desc = 'ts: inner class' },
            ['ia'] = { query = '@arguments.inner', desc = 'ts: inner argument' },
          },
        },
        move = {
          enable = true,
          set_jumps = false, -- whether to set jumps in the jumplist
          goto_next_start = { ['[m'] = '@function.outer' },
          goto_next_end = { [']m'] = '@function.outer' },
        },
      },

      indent = { enable = true },
      playground = { enable = true },

      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },

      highlight = {
        enable = true,

        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then return true end
        end,
      },
    },
  },

  {
    'nvim-treesitter/playground',
    cmd = { 'TSPlaygroundToggle', 'TSCaptureUnderCursor' },
    dependencies = { 'nvim-treesitter' },
  },

  {
    'kevinhwang91/nvim-ufo',
    event = 'VeryLazy',
    dependencies = { 'kevinhwang91/promise-async' },
    keys = {
      { 'zR', function() require('ufo').openAllFolds() end, 'open all folds' },
      { 'zM', function() require('ufo').closeAllFolds() end, 'close all folds' },
      { 'zP', function() require('ufo').peekFoldedLinesUnderCursor() end, 'preview fold' },
    },
    opts = function()
      local ft_map = { rust = 'lsp' }
      require('ufo').setup({
        open_fold_hl_timeout = 0,
        preview = { win_config = { winhighlight = 'Normal:Normal,FloatBorder:Normal' } },
        enable_get_fold_virt_text = true,
        close_fold_kinds = { 'imports', 'comment' },
        provider_selector = function(_, ft) return ft_map[ft] or { 'treesitter', 'indent' } end,
      })
    end,
  },

  {
    'chrisgrieser/nvim-origami',
    event = 'BufReadPost',
    opts = {},
  },

  {
    'laytan/tailwind-sorter.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' },
    event = 'BufWritePost',
    opts = { on_save_enabled = true },
    config = true,
  },

  {
    'utilyre/barbecue.nvim',
    event = 'VeryLazy',
    opts = {
      show_navic = true,
      show_dirname = false,
      show_modified = false,
      exclude_filetypes = { 'netrw', 'toggleterm', 'Trouble', 'neorg', 'markdown' },
      kinds = ky.icons.symbol_kinds,
    },
    dependencies = {
      {
        'SmiteshP/nvim-navic',
        opts = { separator = '  ', highlight = false },
      },
    },
  },
  {
    'numToStr/Comment.nvim',
    keys = { 'gcc', { 'gc', mode = { 'x', 'n', 'o' } } },
    opts = function(_, opts)
      local ok, integration = pcall(require, 'ts_context_commentstring.integrations.comment_nvim')
      if ok then opts.pre_hook = integration.create_pre_hook() end
    end,
  },
  {
    'echasnovski/mini.ai',
    enabled = false,
    event = 'VeryLazy',
    config = function() require('mini.ai').setup({ mappings = { around_last = '', inside_last = '' } }) end,
  },
}
