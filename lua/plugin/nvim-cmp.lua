local status_ok, cmp = pcall(require, "cmp")

if not status_ok then
  return
end

local icons = require("options").cmp

local luasnip = require("luasnip")

local select_next_item = function(fallback)
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  else
    fallback()
  end
end

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

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },

  sorting = {
    priority_weight = 100,
    comparators = {
      cmp.config.compare.exact,
      cmp.config.compare.offset,
      cmp.config.compare.score,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },

  mapping = cmp.mapping.preset.insert(keymaps),

  -- window = {
  --   completion = {
  --     border = { " ", "", " ", "▏", " ", "", " ", "▕" },
  --     winhighlight = "Pmenu:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
  --     side_padding = 1,
  --   },
  -- },

  formatting = {
    fields = vim.g.icons_enabled and { "kind", "abbr", "menu" } or { "abbr", "menu" },

    format = function(entry, vim_item)
      vim_item.menu = ({
        nvim_lsp = "LSP",
        buffer = "Buffer",
      })[entry.source.name]

      local label = vim_item.abbr

      vim_item.kind = string.format("%s", icons[vim_item.kind])
      vim_item.abbr = string.format("%s%s", label, "")

      return vim_item
    end,
  },

  completion = {
    completeopt = "menu, menuone, noinsert",
  },

  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "calc", max_item_count = 1 },
    { name = "nvim_lsp_signature_help" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "orgmode" },
    { name = "path", trigger_characters = { "/", "." } },
    { name = "dictionary", keyword_length = 5, max_item_count = 3 },
  }),

  experimental = {
    -- ghost_text = true,
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

require("luasnip/loaders/from_vscode").lazy_load()

local status_ok, dictonary = pcall(require, "cmp_dictionary")

if not status_ok then
  return
end

dictonary.setup({
  dic = {
    ["*"] = { "~/dict/en_US.dic" },
  },
})
