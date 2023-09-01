return {
  {
    'dnlhc/glance.nvim',
    event = 'BufReadPre',
    opts = {},
  },

  -- lazy.nvim
  {
    'folke/noice.nvim',
    event = 'BufReadPre',
    enabled = function()
      if vim.g.neovide then return false end
      return false
    end,
    opts = {
      presets = {
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
      },
      cmdline = {
        enabled = true, -- enables the Noice cmdline UI
        view = 'cmdline', -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
        format = {
          cmdline = { pattern = '^:', icon = '▎ ', lang = 'vim' },
        },
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
  },

  -- File Explorer
  --- @url https://github.com/nvim-neo-tree/neo-tree.nvim
  {
    'nvim-neo-tree/neo-tree.nvim',
    cmd = 'Neotree',
    branch = 'v3.x',
    config = function() require('config.neotree') end,
    dependencies = 'MunifTanjim/nui.nvim',
  },

  -- Bufferline
  --- @url https://github.com/akinsho/bufferline.nvim
  {
    'akinsho/bufferline.nvim',
    enabled = true,
    event = 'BufWinEnter',
    dependencies = 'moll/vim-bbye',
    opts = require('config.bufferline'),
  },

  -- Terminal
  --- @url https://github.com/akinsho/toggleterm.nvim
  {
    'akinsho/toggleterm.nvim',
    keys = { '<C-\\>' },
    opts = require('config.toggleterm'),
    dependencies = {
      {
        'willothy/flatten.nvim',
        config = true,
        lazy = false,
        priority = 1001,
        opts = function()
          local saved_terminal

          return {
            window = {
              open = 'alternate',
            },
            callbacks = {
              should_block = function(argv) return vim.tbl_contains(argv, '-b') end,
              pre_open = function()
                local term = require('toggleterm.terminal')
                local termid = term.get_focused_id()
                saved_terminal = term.get(termid)
              end,
              post_open = function(bufnr, winnr, ft, is_blocking)
                if is_blocking and saved_terminal then
                  saved_terminal:close()
                else
                  vim.api.nvim_set_current_win(winnr)
                end
              end,
              block_end = function()
                -- After blocking ends (for a git commit, etc), reopen the terminal
                vim.schedule(function()
                  if saved_terminal then
                    saved_terminal:open()
                    saved_terminal = nil
                  end
                end)
              end,
            },
          }
        end,
      },
    },
  },
}
