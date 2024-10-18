local hl = ky.hl

return {
  { 'nvimdev/dashboard-nvim', config = function() require('config.dashboard') end },
  { '0xAdk/full_visual_line.nvim', keys = 'V', opts = {} },
  {
    dir = '~/Projects/Open Source/Shade.nvim',
    enabled = false,
    opts = {
      -- excluded_filetypes = { 'neo-tree', 'help', 'markdown', 'norg', 'trouble' },
    },
  },
  {
    'Fildo7525/pretty_hover',
    event = 'LspAttach',
    opts = {},
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    init = function()
      hl.plugin('RenderMarkdown', {
        theme = {
          ['*'] = {
            { RenderMarkdownCode = { link = 'Comment' } },
          },
        },
      })
    end,
    opts = {
      file_types = { 'markdown', 'Avante' },
      code = {
        sign = false,
        style = 'none',
      },
      dashed = {
        enable = false,
      },
    },
    ft = { 'markdown', 'Avante' },
  },
  {
    'echasnovski/mini.icons',
    config = function(_)
      require('mini.icons').setup(ky.ui.icons.mini)
      require('mini.icons').mock_nvim_web_devicons()
    end,
  },
  {
    'luukvbaal/statuscol.nvim',
    config = function()
      local builtin = require('statuscol.builtin')
      local space = ' '
      require('statuscol').setup({
        ft_ignore = { 'neo-tree', 'Trouble', 'help' },
        bt_ignore = { 'terminal' },
        thousands = ',',
        segments = {
          { text = { space }, hl = 'Normal' },
          {
            sign = { namespace = { 'gitsign*' }, maxwidth = 1, fillchar = space },
            condition = { not vim.g.neovide and not editor.zen_mode },
          },
          { sign = { name = { '.*' }, maxwidth = 1, colwidth = 1, auto = true } },
          { text = { builtin.lnumfunc, space } },
          { text = { space }, hl = 'Normal' },
        },
      })
    end,
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    config = function() require('config.neo-tree') end,
    dependencies = {
      'mrbjarksen/neo-tree-diagnostics.nvim',
      'MunifTanjim/nui.nvim',
    },
  },
  {
    'akinsho/bufferline.nvim',
    event = 'BufWinEnter',
    dependencies = 'moll/vim-bbye',
    config = function() require('config.bufferline') end,
  },
  {
    'rcarriga/nvim-notify',
    event = 'VeryLazy',
    init = function() vim.notify = require('notify') end,
    opts = require('config.nvim-notify'),
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    enabled = false,
    main = 'ibl',
    opts = {
      exclude = {
        -- stylua: ignore
        filetypes = {
          'neo-tree-popup', 'log', 'gitcommit',
          'txt', 'help', 'neo-tree', 'git',
          'markdown', 'norg', 'dashboard',
        },
        buftypes = {
          'terminal',
          'nofile',
        },
      },
      indent = { char = '▏', highlight = 'IblIndent' },
      scope = { char = '▏', highlight = 'IblScope', show_start = true, show_end = true },
    },
    cond = not vim.g.neovide,
  },
  {
    'NvChad/nvim-colorizer.lua',
    event = 'BufRead',
    opts = {
      filetypes = { '*' },
      user_default_options = {
        mode = 'background',
        names = false,
      },
    },
  },
  {
    'RRethy/vim-illuminate',
    opts = {
      delay = 0,
      large_file_cutoff = 2000,
      filetypes_denylist = {
        'popup',
      },
      large_file_overrides = {
        providers = { 'lsp' },
      },
    },
    config = function(_, opts)
      local illuminate_hl = { clear = true, bg = { from = 'CursorLine', attr = 'bg', alter = 0.85 } }
      hl.plugin('Illuminate', {
        theme = {
          ['*'] = {
            { CurSearch = illuminate_hl },
            { MatchParen = illuminate_hl },
            { IlluminatedWordWrite = illuminate_hl },
            { IlluminatedWordRead = illuminate_hl },
            { IlluminatedWordText = illuminate_hl },
          },
        },
      })
      require('illuminate').configure(opts)
    end,
    event = 'CursorHold',
  },

  { 'folke/zen-mode.nvim', opts = {} },
  { 'svermeulen/text-to-colorscheme.nvim', opts = require('config.text-to-colorscheme') },
  { 'neanias/everforest-nvim' },
  { 'folke/tokyonight.nvim', version = '*' },
  { 'miikanissi/modus-themes.nvim' },
  { 'akinsho/horizon.nvim', version = '*' },
  { 'projekt0n/caret.nvim', lazy = false, priority = 1000 },
  { 'dgox16/oldworld.nvim', lazy = false, priority = 1000 },
  { 'NTBBloodbath/sweetie.nvim' },
  { 'dasupradyumna/midnight.nvim' },
  { 'NLKNguyen/papercolor-theme' },
  { 'EdenEast/nightfox.nvim' },
  { 'cocopon/iceberg.vim' },
  { 'phha/zenburn.nvim' },
  { 'backdround/melting' },
  { 'arzg/vim-substrata' },

  -- Experimental
  {
    '3rd/image.nvim',
    enabled = false,
    -- cond = not vim.g.neovide,
    -- ft = { 'norg', 'markdown', 'neo-tree' },
    opts = {
      backend = 'kitty',
      max_width = 50,
      max_height_window_percentage = 60,
    },
  },
}
