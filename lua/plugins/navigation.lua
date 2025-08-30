local fzf_lua = reqcall('fzf-lua')
local file_picker = function(cwd) fzf_lua.files({ cwd = cwd }) end
local hl = ky.hl

return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'folke/which-key.nvim',
    keys = { '<leader>', '<cr>' },
    event = 'UIEnter',
    init = function() require('config.whichkey') end,
    config = function()
      reqcall('which-key').setup({
        preset = 'modern',
        icons = { separator = ' ', group = '' },
        win = { width = 0.9 },
        show_help = false,
        show_keys = false,
      })
    end,
  },
  {
    'ibhagwan/fzf-lua',
    init = function()
      keymap(
        'v',
        '<C-Space>',
        function()
          reqcall('fzf-lua').live_grep({
            search = helpers.visual_selection(),
          })
        end
      )
    end,
    config = function() require('config.fzf_lua') end,
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
      {
        'luukvbaal/statuscol.nvim',
        config = function()
          local builtin = require('statuscol.builtin')
          require('statuscol').setup({
            relculright = true,
            segments = {
              { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
              { text = { '%s' }, click = 'v:lua.ScSa' },
              { text = { builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' },
            },
          })
        end,
      },
    },
    config = function()
      -- Hide fold columnn for some file types (still have them enable)
      local folding_group = vim.api.nvim_create_augroup('folding_group', { clear = true })
      vim.api.nvim_create_autocmd('FileType', {
        desc = 'Hide foldcolumn for some file types',
        pattern = { 'Outline', 'toggleterm', 'neotest-summary' },
        group = folding_group,
        callback = function() vim.opt_local.foldcolumn = '0' end,
      })

      -- Disable fold completely for alpha
      vim.api.nvim_create_autocmd('FileType', {
        desc = 'Disable folding for alpha',
        pattern = { 'alpha' },
        group = folding_group,
        callback = function() vim.opt_local.foldenable = false end,
      })

      require('ufo').setup({
        provider_selector = function(_, _, _) -- function(bufnr, filetype, buftype)
          return { 'treesitter', 'indent' }
        end,
      })
    end,
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    enabled = true,
    keys = { { '<M-e>', '<cmd>Neotree toggle<cr>', mode = 'n' } },
    config = function() require('config.neo_tree') end,
    dependencies = {
      'mrbjarksen/neo-tree-diagnostics.nvim',
      'MunifTanjim/nui.nvim',
    },
  },
  {
    'folke/trouble.nvim',
    config = function(_, opts)
      require('trouble').setup(opts)
      hl.plugin('Trouble', {
        theme = {
          ['*'] = {
            { TroubleNormal = { link = 'Background' } },
            { TroubleNormalNC = { link = 'Background' } },
            { TroubleFile = { fg = { from = 'Function' }, bg = 'none' } },
            { TroubleSignOther = { fg = { from = 'Special' }, bg = 'none' } },
            { TroubleInformation = { fg = { from = 'Special' }, bg = 'none' } },
            { TroublePreview = { clear = true } },
          },
        },
      })
    end,
    opts = {
      auto_preview = true,
      indent_guides = false,
      icons = {
        indent = {
          top = '│ ',
          middle = '│ ',
          last = '└╴',
          ws = ' ',
        },
        kinds = icons.completion,
      },
    },
    cmd = 'Trouble',
  },
  {
    'akinsho/bufferline.nvim',
    enabled = true,
    keys = {
      { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
      { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Previous Buffer' },
    },
    init = function() end,
    event = 'UIEnter',
    dependencies = 'moll/vim-bbye',
    config = function() require('config.bufferline') end,
  },
  {
    'Bekaboo/dropbar.nvim',
    enabled = true,
    init = function() keymap('n', '<C-d>', require('dropbar.api').pick) end,
    opts = {
      icons = {
        -- enable = false,
        ui = {
          bar = {
            separator = ' 󰅂 ',
            extends = '…',
          },
        },
      },
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
  {
    'dnlhc/glance.nvim',
    keys = {
      { 'gr', '<cmd>Glance references<cr>', desc = 'Glance references', mode = 'n' },
    },
    config = function() require('config.glance') end,
    event = 'LspAttach',
  },
  {
    'mrjones2014/smart-splits.nvim',
    config = function()
      local ss = require('smart-splits')
      keymap({ 'i', 'n', 't' }, '<C-h>', ss.move_cursor_left)
      keymap({ 'i', 'n', 't' }, '<C-j>', ss.move_cursor_down)
      keymap({ 'i', 'n', 't' }, '<C-k>', ss.move_cursor_up)
      keymap({ 'i', 'n', 't' }, '<C-l>', ss.move_cursor_right)
    end,
    opts = {
      move_cursor_same_row = false,
      ignored_filetypes = { 'neo-tree' },
      default_amount = 5,
      resize_mode = {
        quit_key = 'q',
        resize_keys = { 'h', 'j', 'k', 'l' },
        silent = true,
      },
    },
  },
  {
    'MisanthropicBit/winmove.nvim',
    init = function()
      hl.plugin('WinMove', {
        theme = {
          ['*'] = {
            { WinMove = { bg = { from = 'Visual', alter = -0.4 } } },
          },
        },
      })
      local winmove = require('winmove')

      winmove.configure({
        modes = {
          move = { highlight = 'WinMove' },
          swap = { highlight = 'WinMove' },
          resize = { highlight = 'WinMove' },
        },
      })

      keymap(
        'n',
        '<S-w>',
        function() winmove.start_mode(winmove.Mode.Move) end,
        { desc = 'Enter Window Move Mode', nowait = true }
      )
    end,
  },
}
