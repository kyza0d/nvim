--------------------------------------------
-- Completion
--------------------------------------------

return {
  {
    'hrsh7th/nvim-cmp',
    event = { 'CmdlineEnter', 'InsertEnter' },
    init = function()
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-emoji',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'saadparwaiz1/cmp_luasnip',
      'uga-rosa/cmp-dictionary',
    },
    config = function() require('config.nvim-cmp') end,
  },
  {
    'windwp/nvim-autopairs',
    event = { 'CmdlineEnter', 'InsertEnter' },
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      local autopairs = require('nvim-autopairs')
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done())
      autopairs.setup({
        close_triple_quotes = true,
        check_ts = true,
      })
    end,
  },
  { 'onsails/lspkind-nvim', event = { 'CmdlineEnter', 'InsertEnter' } },
  {
    'L3MON4D3/LuaSnip',
    event = 'InsertEnter',
    build = 'make install_jsregexp',
    dependencies = { 'rafamadriz/friendly-snippets' },
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
              virt_text = { { ' ', 'Operator' } },
            },
          },
          [types.insertNode] = {
            active = {
              hl_mode = 'combine',
              virt_text = { { ' ', 'Type' } },
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

      require('luasnip.loaders.from_vscode').lazy_load()

      ls.filetype_extend('typescriptreact', { 'javascript', 'typescript' })
    end,
  },
  {
    'github/copilot.vim',
    enabled = false,
    event = 'InsertEnter',
    dependencies = { 'nvim-cmp' },
    init = function() vim.g.copilot_no_tab_map = true end,
    config = function()
      local function accept_word()
        fn['copilot#Accept']('')
        local output = fn['copilot#TextQueuedForInsertion']()
        return fn.split(output, [[[ .]\zs]])[1]
      end

      local function accept_line()
        fn['copilot#Accept']('')
        local output = fn['copilot#TextQueuedForInsertion']()
        return fn.split(output, [[[\n]\zs]])[1]
      end

      keymap('i', '<Plug>(as-copilot-accept)', "copilot#Accept('<Tab>')", {
        expr = true,
        noremap = true,
        silent = true,
      })

      keymap('i', '<M-]>', '<Plug>(copilot-next)', { desc = 'next suggestion' })
      keymap('i', '<M-[>', '<Plug>(copilot-previous)', { desc = 'previous suggestion' })
      keymap('i', '<M-w>', accept_word, { expr = true, noremap = false, desc = 'accept word' })
      keymap('i', '<M-l>', accept_line, { expr = true, noremap = false, desc = 'accept line' })

      vim.g.copilot_filetypes = {
        ['*'] = true,
        ['neo-tree-popup'] = false,
        ['nui-popup'] = false,
        TelescopePrompt = false,
      }
    end,
  },
}
