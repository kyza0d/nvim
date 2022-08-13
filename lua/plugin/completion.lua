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

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

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

  ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
  ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
  ["<C-u>"] = cmp.mapping.scroll_docs(-1),
  ["<C-d>"] = cmp.mapping.scroll_docs(1),
  ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
  ["<CR>"] = cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Insert }),
}

local b = require("utils").getvar("borders").completion

local icons = require("utils").getvar("icons")

local kind_icons = {
  Text = icons.Text,
  Method = icons.Method,
  Function = icons.Function,
  Constructor = icons.Constructor,
  Field = icons.Field,
  Variable = icons.Variable,
  Class = icons.Class,
  Interface = icons.Interface,
  Module = icons.Module,
  Property = icons.Property,
  Unit = icons.Unit,
  Value = icons.Value,
  Enum = icons.Enum,
  Keyword = icons.Keyword,
  Snippet = icons.Snippet,
  Color = icons.Color,
  File = icons.File,
  Reference = icons.Reference,
  Folder = icons.Folder,
  EnumMember = icons.EnumMember,
  Constant = icons.Constant,
  Struct = icons.Struct,
  Event = icons.Event,
  Operator = icons.Operator,
  TypeParameter = icons.TypeParameter,
}

local border = {
  { b.t_l, "FloatBorder" },
  { b.h, "FloatBorder" },
  { b.t_r, "FloatBorder" },
  { b.v, "FloatBorder" },
  { b.b_r, "FloatBorder" },
  { b.h, "FloatBorder" },
  { b.b_l, "FloatBorder" },
  { b.v, "FloatBorder" },
}

-- vim.cmd([[hi Completion guifg=#666666]])
-- vim.cmd([[hi CompletionTop guifg=#666666 gui=underline guisp=#ffffff]])
-- vim.cmd([[hi CompletionBottom guifg=#666666 gui=strikethrough]])
--
-- local border = {
--   { "", "Completion" },
--   { "", "CompletionTop" },
--   { "", "Completion" },
--   { "▏", "Completion" },
--   { "", "Completion" },
--   { "", "CompletionBottom" },
--   { "", "Completion" },
--   { "▕", "Completion" },
-- }

require("cmp").setup({

  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },

  window = {
    documentation = {
      max_width = 50,
      max_height = 15,
      border = border,
    },
    completion = {
      border = border,
      col_offset = 0,
      side_padding = 1,
    },
  },

  mapping = cmp.mapping.preset.insert(keymaps),

  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      vim_item.menu = ({
        luasnip = "Snippet",
        nvim_lsp = "LSP",
        path = "File",
        calc = "calc",
        spell = "Spell",
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

require("luasnip/loaders/from_vscode").load({ paths = { "~/.config/nvim/snippets" } })

-- You can also use lazy loading so you only get in memory snippets of languages you use
require("luasnip/loaders/from_vscode").lazy_load()
