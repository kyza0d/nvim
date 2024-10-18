---@diagnostic disable: missing-fields

local cmp = require('cmp')
local luasnip = require('luasnip')
local lspkind = require('lspkind')
local hl, P = ky.hl, ky.ui.palette

-- Cache Pmenu background to avoid repeated lookups
local pmenu_bg = hl.get('Pmenu', 'bg')

-- Function to blend a color with the Pmenu background based on a percentage
local function blend(color, blend_amount) return hl.blend({ color, pmenu_bg }, blend_amount) end

-- Define shade based on light/dark mode
local shade_value = is_light and 0.1 or 0.20

-- List of highlight groups and their corresponding colors
local colors = {
  { 'CmpItemKindTypeParameter', P.pale_orange },
  { 'CmpItemKindText', P.pale_blue },
  { 'CmpItemKindVariable', P.green },
  { 'CmpItemKindProperty', P.pale_pink },
  { 'CmpItemKindModule', P.pale_red },
  { 'CmpItemKindInterface', P.pale_orange },
  { 'CmpItemKindClass', P.pale_orange },
  { 'CmpItemKindField', P.pale_pink },
  { 'CmpItemKindUnit', P.pale_pink },
  { 'CmpItemKindConstructor', P.pale_orange },
  { 'CmpItemKindFunction', P.pale_pink },
  { 'CmpItemKindMethod', P.pale_blue },
  { 'CmpItemKindEnum', P.pale_orange },
  { 'CmpItemKindOperator', P.pale_orange },
  { 'CmpItemKindKeyword', P.pale_orange },
  { 'CmpItemKindEvent', P.pale_red },
  { 'CmpItemKindColor', P.pale_red },
  { 'CmpItemKindSnippet', P.light_yellow },
  { 'CmpItemKindFile', P.teal },
  { 'CmpItemKindFolder', P.teal },
  { 'CmpItemKindEnumMember', P.light_red },
  { 'CmpItemKindConstant', P.green },
  { 'CmpItemKindStruct', P.pale_orange },
  { 'CmpItemKindType', P.pale_orange },
  { 'CmpItemKindReference', P.pale_orange },
}

-- Generate the highlights table dynamically
local highlights = {}

for _, color_item in ipairs(colors) do
  local name, color = unpack(color_item)
  highlights[#highlights + 1] = {
    [name] = { fg = color },
  }
end

-- Additional special highlight cases
table.insert(highlights, { CmpItemMenu = { fg = { from = 'LineNr' } } })
table.insert(highlights, { CmpItemAbbr = { fg = { from = 'Normal', alter = -0.10 } } })

-- Apply the highlights to the Cmp plugin
hl.plugin('Cmp', {
  theme = {
    ['*'] = {
      unpack(highlights),
    },
  },
})

-- Padding to the end of each icon
local icons = ky.ui.icons.completion

local function pad_table(tbl)
  local padded_table = {}
  for k, v in pairs(tbl) do
    padded_table[k] = v .. ' '
  end
  return padded_table
end

--[[ 
  Retrieve LSP completion context based on the source.
  Different LSP servers store this information in various ways.
  This function manually extracts it based on known LSP behaviors.
]]
local function get_lsp_completion_context(completion, source)
  local ok, source_name = pcall(function() return source.source.client.config.name end)
  if not ok then return nil end

  if source_name == 'tsserver' then
    return completion.detail
  elseif source_name == 'pyright' and completion.labelDetails then
    return completion.labelDetails.description
  elseif source_name == 'texlab' or source_name == 'clangd' then
    local doc = completion.documentation
    if not doc then return nil end
    local import_str = doc.value
    local i, j = string.find(import_str, '["<].*[">]')
    if i then return string.sub(import_str, i, j) end
  end
end

-- Format completion items for display in cmp
local function format_completion(entry, vim_item)
  if not require('cmp.utils.api').is_cmdline_mode() then
    local abbr_max_width = 25
    local menu_max_width = 20

    local choice = lspkind.cmp_format({
      ellipsis_char = '...',
      maxwidth = abbr_max_width,
      symbol_map = pad_table(icons),
      mode = 'symbol',
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
    })(entry, vim_item)

    choice.abbr = vim.trim(choice.abbr)

    -- Ensure abbreviation meets the max/min width
    local abbr_len = string.len(choice.abbr)
    if abbr_len < abbr_max_width then vim_item.abbr = choice.abbr .. string.rep(' ', abbr_max_width - abbr_len) end

    -- Retrieve LSP completion context
    local cmp_context = get_lsp_completion_context(entry.completion_item, entry.source)
    if cmp_context and cmp_context ~= '' then choice.menu = cmp_context end

    local menu_len = string.len(choice.menu)
    if menu_len > menu_max_width then
      choice.menu = vim.fn.strcharpart(choice.menu, 0, menu_max_width - 1) .. '...'
    else
      choice.menu = string.rep(' ', menu_max_width - menu_len) .. choice.menu
    end

    return choice
  else
    local abbr_min_width = 20
    local abbr_max_width = 50

    local choice = lspkind.cmp_format({
      ellipsis_char = '...',
      maxwidth = abbr_max_width,
      symbol_map = pad_table(icons),
      mode = 'symbol',
    })(entry, vim_item)

    choice.abbr = vim.trim(choice.abbr)

    local abbr_len = string.len(choice.abbr)
    if abbr_len < abbr_min_width then vim_item.abbr = choice.abbr .. string.rep(' ', abbr_min_width - abbr_len) end

    return choice
  end
end

-- Set up completion
cmp.setup({
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },
  window = {
    completion = { side_padding = 0, scrollbar = false, col_offset = -4 },
  },
  formatting = {
    deprecated = false,
    fields = { 'kind', 'abbr', 'menu' },
    format = format_completion,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<C-l>'] = cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Replace }),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  completion = { completeopt = 'menu,menuone,noinsert', autocompleteopt = false },
  sources = cmp.config.sources({
    { name = 'luasnip', priority = 1000, group_index = 2 },
    { name = 'nvim_lsp', priority = 950, group_index = 2 },
    { name = 'nvim_lua', priority = 850, group_index = 2 },
    { name = 'buffer', priority = 500, group_index = 2 },
    { name = 'path', priority = 250, group_index = 2 },
  }),
})

-- Command-line completion setup
cmp.setup.cmdline(':', {
  sources = {
    { name = 'cmdline' },
    { name = 'path', trigger_characters = { '/' } },
  },
})

cmp.setup.cmdline('/', {
  sources = { { name = 'buffer' } },
})
