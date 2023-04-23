local cmp = require("cmp")
local icons = require("core.options").cmp

local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()

local select_next_item = function(fallback)
	if luasnip.expand_or_jumpable() then
		luasnip.expand_or_jump()
	else
		fallback()
	end
end

cmp.setup({
	experimental = {
		ghost_text = true,
	},
	sources = cmp.config.sources({
		{ name = "buffer" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path", trigger_characters = { "/", "." } },
	}),

	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},

	completion = {
		completeopt = "menu,menuone,noinsert",
	},

	formatting = {
		fields = vim.g.disable_icons and { "abbr", "menu" } or { "kind", "abbr", "menu" },
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

	mapping = cmp.mapping.preset.insert({
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
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-u>"] = cmp.mapping.scroll_docs(-1),
		["<C-d>"] = cmp.mapping.scroll_docs(1),
		["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }),
	}),
})

require("cmp").setup.cmdline(":", {
	sources = {
		{ name = "cmdline" },
		{ name = "path", trigger_characters = { "/" } },
	},
})

require("cmp").setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})
