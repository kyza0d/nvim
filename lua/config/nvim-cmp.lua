local cmp = require('cmp')

local luasnip = require('luasnip')
local lspkind = require('lspkind')

local icons = require('options').completion

require('luasnip.loaders.from_vscode').lazy_load()

local function shift_tab(fallback)
  if not cmp.visible() then return fallback() end
  if luasnip.jumpable(-1) then luasnip.jump(-1) end
end

local function tab(fallback)
  if not cmp.visible() then return fallback() end
  if not cmp.get_selected_entry() then return cmp.select_next_item({ behavior = cmp.SelectBehavior.Select }) end
  if luasnip.expand_or_jumpable() then return luasnip.expand_or_jump() end
  cmp.confirm()
end

cmp.setup({
  window = {
    documentation = {
      border = 'single',
    },
    completion = {
      side_padding = 1,
      border = 'none',
    },
  },

  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },

  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i' }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<S-Tab>'] = cmp.mapping(shift_tab, { 'i', 's' }),
    ['<Tab>'] = cmp.mapping(tab, { 'i', 's' }),
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
    { name = 'rg', keyword_length = 4, option = { additional_arguments = '--max-depth 8' } },
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
