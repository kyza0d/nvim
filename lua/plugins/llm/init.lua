return {
  {
    'olimorris/codecompanion.nvim',
    init = function()
      helpers.on_load('codecompanion.nvim', function()
        local wk = reqcall('which-key')
        wk.add({
          {
            icon = '󰱽',
            '<leader>c',
            group = 'Code Companion',
            nowait = false,
            remap = false,
          },
          {
            icon = '󰱽',
            '<leader>co',
            '<cmd>CodeCompanionChat Toggle<CR>',
            desc = 'Open Code',
            nowait = false,
            remap = false,
          },
          {
            icon = '󰱽',
            '<leader>ca',
            '<cmd>CodeCompanionActions<CR>',
            desc = 'Actions',
            nowait = false,
            remap = false,
          },
        })
      end)
    end,
    opts = {
      strategies = {
        chat = {
          keymaps = {
            close = {
              modes = { n = '<Nop>', i = '<Nop>' },
            },
          },
        },
      },
      prompt_library = {},
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
  },
  {
    'ravitemer/mcphub.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    build = 'npm install -g mcp-hub@latest',
    config = function() require('mcphub').setup() end,
  },
  {
    'supermaven-inc/supermaven-nvim',
    opts = {
      ignore_filetypes = {
        ['neo-tree-popup'] = true,
      },
      keymaps = {
        accept_suggestion = '<M-j>',
        accept_word = '<M-w>',
        clear_suggestion = '<C-c>',
      },
    },
  },
}
