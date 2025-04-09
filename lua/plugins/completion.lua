local icons = ky.ui.icons
local completion_icons = icons.completion
return {
  {
    'saghen/blink.cmp',
    version = '*',
    dependencies = {
      'rafamadriz/friendly-snippets',
      'MahanRahmati/blink-nerdfont.nvim',
      'fang2hou/blink-copilot',
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
          menu = { auto_show = true },
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
          nerdfont = {
            module = 'blink-nerdfont',
            name = 'Nerd Fonts',
            score_offset = 100,
            opts = { insert = true },
          },
          path = {
            name = 'path',
            score_offset = 600,
          },
          copilot = {
            name = 'copilot',
            module = 'blink-copilot',
            max_items = 1,
            score_offset = 100,
            async = true,
          },
          snippets = {
            name = 'snippets',
            score_offset = 150,
          },
        },
      },
      completion = {
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
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    event = 'InsertEnter',
    build = 'make install_jsregexp',
    dependencies = {
      'rafamadriz/friendly-snippets',
    },
    config = function()
      local ls = require('luasnip')
      local types = require('luasnip.util.types')
      local extras = require('luasnip.extras')
      local fmt = require('luasnip.extras.fmt').fmt

      ls.config.set_config({
        history = false,
        region_check_events = 'CursorMoved,CursorHold,InsertEnter',
        delete_check_events = 'InsertLeave',
        ext_opts = {
          [types.choiceNode] = {
            active = {
              hl_mode = 'combine',
              virt_text = { { '●', 'Operator' } },
            },
          },
          [types.insertNode] = {
            active = {
              hl_mode = 'combine',
              virt_text = { { '●', 'Type' } },
            },
          },
        },
        enable_autosnippets = true,
        snip_env = {
          fmt = fmt,
          m = extras.match,
          t = ls.text_node,
          f = ls.function_node,
          c = ls.choice_node,
          d = ls.dynamic_node,
          i = ls.insert_node,
          l = extras.lamda,
          snippet = ls.snippet,
        },
      })

      require('luasnip.loaders.from_lua').lazy_load()
      -- NOTE: the loader is called twice so it picks up the defaults first then my custom textmate snippets.
      -- see: https://github.com/L3MON4D3/LuaSnip/issues/364
      require('luasnip.loaders.from_vscode').lazy_load()
      require('luasnip.loaders.from_vscode').lazy_load({ paths = './snippets/textmate' })

      ls.filetype_extend('typescriptreact', { 'javascript', 'typescript' })
      ls.filetype_extend('dart', { 'flutter' })
      ls.filetype_extend('NeogitCommitMessage', { 'gitcommit' })
    end,
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
        suggestion = {
          enabled = false,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = '<c-cr>',
            accept_word = '<c-w>',
            accept_line = '<c-space>',
            next = '<M-]>',
            prev = '<M-[>',
            dismiss = '<C-]>',
          },
        },
        panel = {
          enabled = true,
        },
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
      history = {
        max_tokens = 4096,
        carried_entry_count = nil,
        storage_path = vim.fn.stdpath('state') .. '/avante',
        paste = {
          extension = 'png',
          filename = 'pasted-%Y-%m-%d-%H-%M-%S',
        },
      },
      highlights = {
        diff = {
          current = nil,
          incoming = nil,
        },
      },
      mappings = {
        diff = {
          ours = 'co',
          theirs = 'ct',
          all_theirs = 'ca',
          both = 'cb',
          cursor = 'cc',
          next = ']x',
          prev = '[x',
        },
        jump = {
          next = ']]',
          prev = '[[',
        },
        submit = {
          normal = '<CR>',
          insert = '<C-s>',
        },
        cancel = {
          normal = { '<C-c>', '<Esc>', 'q' },
          insert = { '<C-c>' },
        },
        ask = '<leader>aa',
        edit = '<leader>ae',
        refresh = '<leader>ar',
        focus = '<leader>af',
        stop = '<leader>aS',
        toggle = {
          default = '<leader>at',
          debug = '<leader>ad',
          hint = '<leader>ah',
          suggestion = '<leader>as',
          repomap = '<leader>aR',
        },
        sidebar = {
          apply_all = 'A',
          apply_cursor = 'a',
          retry_user_request = 'r',
          edit_user_request = 'e',
          switch_windows = '<Tab>',
          reverse_switch_windows = '<S-Tab>',
          remove_file = 'd',
          add_file = '@',
          close = { '<Esc>', 'q' },
          close_from_input = nil,
        },
        files = {
          add_current = '<leader>ac', -- Add current buffer to selected files
          add_all_buffers = '<leader>aB', -- Add all buffer files to selected files
        },
        select_model = '<leader>a?', -- Select model command
        select_history = '<leader>ah', -- Select history command
      },
      windows = {
        position = 'bottom',
        wrap = true,
        width = 30,
        height = 5,
        sidebar_header = {
          enabled = true,
          align = 'left',
          rounded = false,
        },
        input = {
          prefix = '> ',
          height = 8,
        },
        edit = {
          border = 'none',
          start_insert = true,
        },
        ask = {
          floating = false,
          start_insert = false,
        },
      },
      hints = {
        enabled = false,
      },
      file_selector = {
        provider = 'native',
        provider_opts = {},
      },
      suggestion = {
        debounce = 600,
        throttle = 600,
      },
      disabled_tools = {},
      custom_tools = {},
    },
  },
  {
    'chrisgrieser/nvim-scissors',
    event = 'BufEnter',
    dependencies = 'nvim-telescope/telescope.nvim',
    opts = {
      snippetDir = vim.fn.stdpath('config') .. '/snippets',
    },
    keys = {
      '<Leader>sa',
      '<Leader>se',
    },
    config = function()
      local present, wk = pcall(require, 'which-key')
      if not present then return end

      wk.add({
        { '<leader>s', group = 'Snippets', nowait = false, remap = false },
        { '<leader>sa', '<cmd>lua require("scissors").addNewSnippet()<CR>', desc = 'Add new snippet', nowait = false, remap = false },
        { '<leader>se', '<cmd>lua require("scissors").editSnippet()<CR>', desc = 'Edit snippet', nowait = false, remap = false },
      })

      wk.add({
        { '<leader>as', group = 'Snippets', mode = 'x', nowait = false, remap = false },
        {
          '<leader>sa',
          '<cmd>lua require("scissors").addNewSnippet()<CR>',
          desc = 'Add new snippet from selection',
          mode = 'x',
          nowait = false,
          remap = false,
        },
      })
    end,
  },
  { 'onsails/lspkind-nvim', event = { 'CmdlineEnter', 'InsertEnter' } },
  { 'windwp/nvim-ts-autotag', event = { 'InsertEnter' } },
  { 'saecki/live-rename.nvim' },
}
