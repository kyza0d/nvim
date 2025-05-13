return {
  {
    'github/copilot.vim',

    init = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true

      keymap('i', '<M-j>', 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
      keymap('i', '<M-w>', '<plug>(copilot-accept-word)')
      keymap('i', '<M-l>', '<plug>(copilot-accept-line)')
      keymap('i', '<M-p>', '<Plug>(copilot-next)')
      keymap('i', '<M-n>', '<Plug>(copilot-previous)')
    end,
    lazy = false,
  },
  {
    'ravitemer/mcphub.nvim',
    build = 'sudo npm install -g mcp-hub@latest',
    init = function() vim.g.mcphub_auto_approve = true end,
    opts = {},
  },
  {
    'olimorris/codecompanion.nvim',
    init = function()
      local wk = reqcall('which-key')
      wk.add({
        { icon = '', '<leader>c', group = 'Companion' },
        { icon = '', desc = 'Chat', '<leader>cc', '<cmd>CodeCompanionChat Toggle<CR>' },
        { icon = '󰱽', desc = 'Actions', '<leader>ca', '<cmd>CodeCompanionActions<CR>' },
        { icon = '󰦨', desc = 'Ad Copy', '<leader>cad', function() require('codecompanion').prompt('adcopy') end },
        { icon = '󰦨', desc = 'Refine Copy', '<leader>cr', function() require('codecompanion').prompt('refine') end },
      })
    end,
    config = function()
      require('codecompanion').setup({
        extensions = {
          mcphub = {
            callback = 'mcphub.extensions.codecompanion',
            opts = {
              show_result_in_chat = true,
              make_vars = true,
              make_slash_commands = true,
            },
          },
        },
        adapters = {
          deepseek = function()
            return require('codecompanion.adapters').extend('openai_compatible', {
              env = {
                url = 'https://api.deepseek.com/v1',
                api_key = os.getenv('DEEPSEEK_API_KEY'),
                chat_url = '/v1/chat/completions',
              },
              schema = {
                model = {
                  default = 'deepseek-r1-671b',
                },
                temperature = {
                  default = 0.8,
                },
                max_completion_tokens = {
                  default = 1000,
                },
              },
            })
          end,
        },
        strategies = {
          chat = {
            adapter = 'deepseek',
            keymaps = {
              close = {
                modes = { n = '<Nop>', i = '<Nop>' },
              },
            },
          },
          inline = {
            adapter = 'deepseek',
          },
        },
        prompt_library = {
          ['AdCopy'] = require('plugins.llm.prompts.ad_copy'),
          ['RefineCopy'] = require('plugins.llm.prompts.refine_copy'),
        },
        display = {
          action_palette = {
            width = 95,
            height = 10,
            prompt = 'Copywriting Prompt ',
            opts = {
              show_default_actions = true,
              show_default_prompt_library = true,
            },
          },
        },
        opts = {
          log_level = 'DEBUG', -- For troubleshooting prompt issues
        },
      })
    end,
  },
}
