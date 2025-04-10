local reqcall = ky.reqcall
local icons = ky.ui.icons
local completion_icons = icons.completion

return {
  {
    'saghen/blink.cmp',
    version = '*',
    dependencies = {
      'rafamadriz/friendly-snippets',
      'MahanRahmati/blink-nerdfont.nvim',
      {
        'fang2hou/blink-copilot',
        opts = {
          kind_icon = completion_icons.Copilot,
        },
      },
    },
    opts = {
      keymap = { preset = 'enter' },
      appearance = {
        nerd_font_variant = 'mono',
        use_nvim_cmp_as_default = true,
        kind_icons = completion_icons,
      },
      cmdline = {
        keymap = { preset = 'cmdline' },
        completion = {
          list = {
            selection = {
              preselect = true,
              auto_insert = true,
            },
          },
          menu = {
            auto_show = true,
          },
        },
      },
      sources = {
        default = {
          'lsp',
          'copilot',
          'path',
          'snippets',
          'buffer',
          'nerdfont',
        },
        providers = {
          path = {
            name = 'path',
            score_offset = 600,
          },
          copilot = {
            name = 'copilot',
            module = 'blink-copilot',
            max_items = 1,
            score_offset = 250,
            async = true,
          },
          lsp = {
            name = 'lsp',
            score_offset = 200,
          },
          snippets = {
            name = 'snippets',
            score_offset = 150,
          },
          nerdfont = {
            module = 'blink-nerdfont',
            name = 'Nerd Fonts',
            score_offset = 100,
            opts = { insert = true },
          },
        },
      },
      completion = {
        menu = {
          draw = {
            padding = { 0, 1 },
          },
        },
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
        },
        list = {
          selection = {
            auto_insert = function(ctx) return ctx.mode == 'cmdline' and false or true end,
          },
        },
      },
    },
    opts_extend = {
      'sources.default',
    },
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup({
        close_triple_quotes = true,
        disable_filetype = { 'neo-tree-popup' },
        check_ts = true,
        fast_wrap = { map = '<c-e>' },
        ts_config = {
          lua = { 'string' },
          dart = { 'string' },
          javascript = { 'template_string' },
        },
      })
    end,
  },
  {
    'zbirenbaum/copilot.lua',
    config = function()
      require('copilot').setup({
        suggestion = { enabled = false },
        panel = { enabled = true },
        filetypes = {
          markdown = true,
          help = true,
        },
      })
    end,
  },
  {
    'yetone/avante.nvim',
    opts = {
      provider = 'claude',
      system_prompt = nil,
      rag_service = {
        enabled = false,
        runner = 'docker',
        provider = 'openai',
        endpoint = 'https://api.openai.com/v1',
      },
      web_search_engine = {
        provider = 'tavily',
        providers = {
          brave = {
            api_key_name = 'BRAVE_API_KEY',
            extra_request_body = {
              count = '10',
              result_filter = 'web',
            },
            format_response_body = function(body)
              if body.web == nil then return '', nil end

              local jsn = vim.iter(body.web.results):map(
                function(result)
                  return {
                    title = result.title,
                    url = result.url,
                    snippet = result.description,
                  }
                end
              )

              return vim.json.encode(jsn), nil
            end,
          },
        },
      },
      claude = {
        endpoint = 'https://api.anthropic.com',
        model = 'claude-3-7-sonnet-20250219',
        timeout = 30000,
        temperature = 0,
        max_tokens = 20480,
      },
      gemini = {
        endpoint = 'https://generativelanguage.googleapis.com/v1beta/models',
        model = 'gemini-2.0-flash',
        timeout = 30000,
        temperature = 0,
        max_tokens = 8192,
      },
      highlights = {
        diff = {
          current = nil,
          incoming = nil,
        },
      },
      windows = {
        position = 'right',
        input = {
          prefix = '> ',
          height = 8,
        },
      },
      hints = {
        enabled = false,
      },
      suggestion = {
        debounce = 600,
        throttle = 600,
      },
    },
  },
  {
    'chrisgrieser/nvim-scissors',
    event = 'BufEnter',
    dependencies = 'nvim-telescope/telescope.nvim',
    opts = {
      snippetDir = vim.fn.stdpath('config') .. '/snippets',
    },
    config = function()
      local wk = reqcall('which-key')

      wk.add({
        { icon = '', '<leader>s', group = 'Snippets', nowait = false, remap = false },
        { icon = '', '<leader>sa', '<cmd>lua require("scissors").addNewSnippet()<CR>', desc = 'Add new snippet', nowait = false, remap = false },
        { icon = '󰲶', '<leader>se', '<cmd>lua require("scissors").editSnippet()<CR>', desc = 'Edit snippet', nowait = false, remap = false },
      })

      wk.add({
        { icon = '', '<leader>s', group = 'Snippets', mode = 'x', nowait = false, remap = false },
        {
          icon = '󰳼',
          '<leader>sa',
          '<cmd>lua require("scissors").addNewSnippet()<CR>',
          desc = 'Add new snippet from selection',
          mode = 'x',
          nowait = false,
          remap = false,
        },
      })
    end,
    keys = {
      '<Leader>sa',
      '<Leader>se',
    },
  },
  { 'windwp/nvim-ts-autotag', event = { 'InsertEnter' } },
  { 'saecki/live-rename.nvim' },
}
