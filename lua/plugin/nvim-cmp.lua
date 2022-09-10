local status_ok, cmp = pcall(require, "cmp")

if not status_ok then
  return
end

local luasnip = require("luasnip")

local select_next_item = function(fallback)
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  else
    fallback()
  end
end

local kind_icons = {
  Text = " ",
  Method = "m ",
  Function = " ",
  Constructor = " ",
  Field = " ",
  Variable = " ",
  Class = " ",
  Interface = " ",
  Module = " ",
  Property = " ",
  Unit = " ",
  Value = " ",
  Enum = " ",
  Keyword = " ",
  Snippet = " ",
  Color = " ",
  File = " ",
  Reference = " ",
  Folder = " ",
  EnumMember = " ",
  Constant = " ",
  Struct = " ",
  Event = " ",
  Operator = " ",
  TypeParameter = " ",
}

local border = {
  { "┌", "FloatBorder" },
  { "─", "FloatBorder" },
  { "┐", "FloatBorder" },
  { "│", "FloatBorder" },
  { "┘", "FloatBorder" },
  { "─", "FloatBorder" },
  { "└", "FloatBorder" },
  { "│", "FloatBorder" },
}

local keymaps = {
  ["<Tab>"] = cmp.mapping({
    i = select_next_item,
    s = select_next_item,
    c = cmp.mapping.confirm({ select = true }),
  }),

  ["<S-Tab>"] = cmp.mapping(function(fallback)
    if luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end, { "i", "s" }),

  ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),

  ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
  ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),

  ["<C-u>"] = cmp.mapping.scroll_docs(-1),
  ["<C-d>"] = cmp.mapping.scroll_docs(1),

  ["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }),
}

local luasnip = require("luasnip")

local select_next_item = function(fallback)
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  else
    fallback()
  end
end

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },

  mapping = cmp.mapping.preset.insert(keymaps),

  window = {
    completion = {
      -- border = border,
      scrollbar = "┃",
    },
    documentation = {
      -- border = border,
      scrollbar = "┃",
    },
  },

  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])

      if entry.source.name == "dictionary" then
        vim_item.kind = " "
      end

      vim_item.menu = ({
        luasnip = "Snippet",
        nvim_lsp = "LSP",
        path = "File",
        calc = "calc",
        spell = "Spell",
        dictionary = "Dictionary",
        buffer = "Buffer",
      })[entry.source.name]

      return vim_item
    end,
  },

  completion = {
    completeopt = "menu,menuone,noinsert",
  },

  sources = cmp.config.sources({
    { name = "nvim_lsp", max_item_count = 10 },
    { name = "calc", max_item_count = 1 },
    { name = "luasnip" },
    { name = "dictionary", keyword_length = 4, max_item_count = 3 },
    { name = "buffer" },
    { name = "path", trigger_characters = { "/", "." } },
  }),

  experimental = {
    ghost_text = true,
  },
})

require("cmp").setup.cmdline(":", {
  sources = {
    { name = "cmdline" },
  },
})

require("cmp").setup.cmdline("/", {
  sources = {
    { name = "buffer" },
  },
})

require("cmp_dictionary").setup({
  dic = {
    ["*"] = { "~/dict/en_US.dic" },
  },
})

require("luasnip/loaders/from_vscode").load({ paths = { "~/.config/nvim/snippets" } })

-- You can also use lazy loading so you only get in memory snippets of languages you use
require("luasnip/loaders/from_vscode").lazy_load()
