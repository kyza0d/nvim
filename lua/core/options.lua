vim.g.disable_icons = false

local concat = require("core.utils.concat")

-- stylua: ignore
local M = {
	icons               = {
		file               = " ",
		book               = " ",
		book_alt           = "",
		error              = " ",
		warning            = " ",
		hint               = " ",
		info               = " ",
		chevron            = "  ",
		keyboard           = "",
		git_branch         = "󰘬 ",
		indent             = "▏",
	},
	cmp                 = {
		Class              = "  ",
		Color              = "  ",
		Constant           = "  ",
		Constructor        = "  ",
		Enum               = "   ",
		EnumMember         = "  ",
		Event              = "  ",
		Field              = "  ",
		Folder             = "  ",
		Function           = "  ",
		Interface          = "ﰮ  ",
		Keyword            = "  ",
		Method             = "  ",
		Module             = "  ",
		Array              = "  ",
		Operator           = "  ",
		Property           = "  ",
		Reference          = "  ",
		Snippet            = "  ",
		Struct             = "  ",
		Text               = "  ",
		TypeParameter      = "  ",
		Unit               = "   ",
		Value              = "  ",
		Variable           = "  ",
		Dictionary         = "  ",
		Signature          = "  ",
		Directory          = "  ",
		File               = "  ",
	},
	navic               = {
		File               = " ",
		Module             = " ",
		Namespace          = " ",
		Package            = " ",
		Class              = " ",
		Method             = " ",
		Property           = " ",
		Field              = " ",
		Constructor        = " ",
		Enum               = "  ",
		Interface          = "  ",
		Function           = " ",
		Variable           = " ",
		Constant           = " ",
		String             = " ",
		Number             = " ",
		Boolean            = "◩ ",
		Array              = " ",
		Object             = " ",
		Key                = " ",
		Null               = "ﳠ ",
		EnumMember         = " ",
		Struct             = " ",
		Event              = " ",
		Operator           = " ",
		TypeParameter      = " ",
	},
	neotree_icons       = {
		folder_open        = " 󰷏 ",
		folder_closed      = " 󰉖 ",
		-- folder_open        = "",
		-- folder_closed      = "",
		folder_empty       = "󰉖 ",
		folder_empty_open  = " ",
		file               = " ",
		symlink            = " ",
		symlink_open       = " ",
		default            = " ",
		default_open       = " ",
		-- indent_marker      = " ",
		-- last_indent_marker = " ",
		indent_marker      = "│",
		-- indent_marker      = "│",
		last_indent_marker = "└╴",
		-- indent_marker      = "🭴",
		-- last_indent_marker = "🭴",
	},
}

local options = {
  -- Appearance
  -- numberwidth = 5,
  cursorline = false,
  laststatus = 2,
  cmdheight = 1,
  pumheight = 12,
  termguicolors = true,
  mouse = "a",
  scrolloff = 6,
  showmode = false,

  number = true,
  relativenumber = false,
  signcolumn = "no",

  -- stylua: ignore
	statuscolumn = concat({
		"%= ",
		"%l",
		"%s ",
		'%#StatusColumnBorder#%{foldlevel(v:lnum) > 0 ? (foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? "󰅀  " : "󰅂 " ) : "   ") : "   "}',
		'%#FoldIndicator#%{(foldclosed(v:lnum) == -1 ? "" : "▎" )}',
	}),

  -- statuscolumn = " %l ",

  -- Indenting
  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  autoindent = true,
  breakindent = true,
  breakindentopt = "shift:3",
  wrap = true,
  linebreak = true,

  -- Folding
  foldenable = true,
  foldlevel = 99,

  -- Searching
  ignorecase = true,
  smartcase = true,

  -- Memory and file
  shell = "/usr/bin/zsh",
  hidden = true,
  lazyredraw = true,
  swapfile = false,
  backup = false,

  -- Update times
  timeoutlen = 400,
  updatetime = 200,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.fillchars:append({
  vertright = " ",
  vert = "▏",
  vertleft = " ",
  horiz = "─",
  foldclose = "",
  foldopen = "",
  eob = " ",
})

if vim.g.disable_icons then
  vim.opt.fillchars:append({
    foldclose = ">",
    foldopen = "v",
  })

  local tables = {
    M.icons,
    M.cmp,
    M.navic,
    M.neotree_icons,
  }

  for _, t in ipairs(tables) do
    for k in pairs(t) do
      t[k] = ""
    end
  end
end

return M
