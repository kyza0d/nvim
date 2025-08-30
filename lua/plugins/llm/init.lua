local user = 'kyza'

local welcome_messages = {
  '󱠡  Hey there! What are you building?',
  '󱠡  Hello! How can I help you today?',
  "󱠡  Greetings! What's on your mind?",
  '󱠡  Hey, Ready to code?',
  "󱠡  Welcome back! Let's make something great.",
}

math.randomseed(os.time())
local random_intro = welcome_messages[math.random(#welcome_messages)]

return {
  {
    'olimorris/codecompanion.nvim',
    init = function()
      keymap('n', '<S-Space>', '<cmd>CodeCompanionChat Toggle<cr>')
      keymap('v', '<cr>c', '<cmd>CodeCompanion<cr>')
    end,
    dependencies = {
      {
        'echasnovski/mini.diff',
        config = function()
          local diff = require('mini.diff')
          diff.setup({
            source = diff.gen_source.none(),
          })
        end,
      },
    },
    config = function()
      require('editor.ui.codecompanion.spinner'):init()

      require('codecompanion').setup({
        display = {
          chat = {
            intro_message = random_intro,
            auto_scroll = true,
          },
        },
        adapter = {
          http = {
            deepseek = function()
              return require('codecompanion.adapters').extend('deepseek', {
                name = 'deepseek-r1',
                schema = {
                  model = { default = ai.models.chat },
                },
              })
            end,
            gemini = function()
              return require('codecompanion.adapters').extend('gemini', {
                schema = {
                  model = { default = ai.models.chat },
                  temperature = { default = 0.8 },
                  max_completion_tokens = { default = 1000 },
                },
              })
            end,
            openai = function()
              return require('codecompanion.adapters').extend('openai', {
                env = {
                  url = 'https://api.openai.com/v1',
                  api_key = os.getenv('OPENAI_API_KEY'),
                  chat_url = '/v1/chat/completions',
                },
                schema = {
                  model = { default = 'gpt-4o' },
                  temperature = { default = 0.8 },
                  max_completion_tokens = { default = 1000 },
                },
              })
            end,
          },
        },
        strategies = {
          inline = {
            adapter = 'gemini',
          },
          chat = {
            adapter = 'deepseek',
            roles = { user = fmt('  %s', user) },
            tools = {
              opts = {
                completion_provider = 'blink',
                auto_submit_success = true,
              },
            },
            keymaps = {
              close = {
                modes = { n = '<Nop>', i = '<Nop>' },
              },
              send = {
                callback = function(chat)
                  vim.cmd('stopinsert')
                  chat:submit()
                  chat:add_buf_message({ role = 'llm', content = '' })
                end,
                index = 1,
                description = 'Send',
              },
            },
          },
        },
      })
    end,
  },
  {
    'ravitemer/mcphub.nvim',
    enabled = false,
    build = 'sudo npm install -g mcp-hub@latest',
    init = function() vim.g.mcphub_auto_approve = true end,
    opts = {},
  },
}
