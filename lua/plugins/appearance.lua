local hl, P = ky.hl, ky.ui.palette

---@diagnostic disable: missing-fields
return {
  {
    'echasnovski/mini.icons',
    config = function(_)
      require('mini.icons').setup(ky.ui.icons.mini)
      require('mini.icons').mock_nvim_web_devicons()
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    enabled = not vim.g.neovide,
    main = 'ibl',
    event = 'UIEnter',
    init = function()
      hl.plugin('IndentBlankLine', {
        theme = {
          ['*'] = {
            { IndentBlanklineChar = { fg = { from = 'Macro' } } },
            { IndentBlanklineSpaceChar = { fg = { from = 'Comment', alter = -0.4 } } },
          },
        },
      })
    end,
    opts = {
      exclude = {
        -- stylua: ignore
        filetypes = {
          'dbout', 'neo-tree-popup', 'log', 'gitcommit',
          'txt', 'help', 'NvimTree', 'git', 'flutterToolsOutline',
          'undotree', 'markdown', 'norg', 'org', 'orgagenda',
        },
      },
      indent = {
        char = '▏',
        highlight = 'IndentLine',
      },
      scope = {
        char = '▏',
      },
    },
  },
  {
    '0xAdk/full_visual_line.nvim',
    keys = 'V',
    opts = {},
  },
  {
    'kevinhwang91/nvim-bqf',
    opts = {
      preview = {
        border = 'none',
        winblend = 0,
      },
    },
    ft = 'qf',
  },
  {
    'rcarriga/nvim-notify',
    event = 'VeryLazy',
    init = function() vim.notify = require('notify') end,
    config = function()
      local notify = require('notify')
      notify.setup({
        top_down = false,
        render = 'wrapped-compact',
        stages = 'fade_in_slide_out',
        on_open = function(win)
          if api.nvim_win_is_valid(win) then api.nvim_win_set_config(win, { border = 'single' }) end
        end,
      })
    end,
  },
  { 'EdenEast/nightfox.nvim' },
  { 'onsails/lspkind.nvim' },
  {
    'Bekaboo/dropbar.nvim',
    opts = {
      sources = {
        path = {
          relative_to = function(_, win)
            local ok, win_cwd = pcall(vim.fn.getcwd, win)
            local cwd = ok and win_cwd or vim.fn.getcwd()
            local is_subdir_of_home = vim.fn.fnamemodify(cwd, ':~') ~= cwd

            return is_subdir_of_home and vim.env.HOME or '/'
          end,
        },
      },
      bar = {
        sources = function()
          local sources = require('dropbar.sources')
          local utils = require('dropbar.utils')
          return {
            utils.source.fallback({
              sources.lsp,
              sources.path,
            }),
          }
        end,
      },
    },
  },
}
