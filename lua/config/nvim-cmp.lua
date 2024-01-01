---@diagnostic disable: missing-fields
local cmp = require('cmp')

local luasnip = require('luasnip')
local lspkind = require('lspkind')

local icons = require('icons').completion

require('luasnip.loaders.from_vscode').lazy_load()

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

cmp.setup({
  window = {
    documentation = {
      border = 'single',
    },
    completion = {
      side_padding = 0,
      border = 'none',
    },
  },

  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },

  formatting = {
    deprecated = true,
    fields = { 'kind', 'abbr', 'menu' },
    format = lspkind.cmp_format({
      mode = 'symbol',
      symbol_map = icons,
      menu = {
        nvim_lsp = 'lsp',
        nvim_lua = 'lua',
        emoji = 'emoji',
        path = 'path',
        luasnip = 'snippet',
        dictionary = 'dictionary',
        buffer = 'buffer',
        spell = 'spell',
        rg = 'ripgrep',
        git = 'git',
      },
      maxwidth = 50,
      ellipsis_char = '...',
    }),
  },

  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i' }),
    ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
  }),

  completion = {
    completeopt = 'menu,menuone,noinsert',
  },

  -----------------------------------------
  -- Sources
  -----------------------------------------

  sources = {
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'emoji' },
    { name = 'nvim_lua' },
    { name = 'dictionary', keyword_length = 3 },
    {
      name = 'buffer',
      options = {
        get_bufnrs = function() return vim.api.nvim_list_bufs() end,
      },
    },
  },
})

cmp.setup.cmdline(':', {
  sources = {
    { name = 'cmdline' },
    { name = 'path', trigger_characters = { '/' } },
  },
})

cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' },
  },
})

cmp.setup.filetype({ 'dap-repl', 'dapui_watches' }, { sources = { { name = 'dap' } } })

-----------------------------------------
-- Dictionary
-----------------------------------------

local dict = require('cmp_dictionary')

dict.switcher({
  spelllang = {
    en = '~/.config/nvim/spell/en.utf-8.dict',
  },
})
