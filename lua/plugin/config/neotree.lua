local icons = require("core.options").neotree_icons

require("neo-tree").setup({
	-- popup_border_style = { "", "", "", "", "", "", "", "" },
	-- popup_border_style = { " ", " ", " ", " ", "", "", "", " " },
	-- popup_border_style = "none",
	popup_border_style = "single", -- "double", "none", "rounded", "shadow", "single" or "solid"

	source_selector = {
		winbar = false,
		statusline = true,
		sources = { -- table
			{ source = "filesystem", display_name = " 󰉖  Files" }, -- string | nil
			{ source = "buffers", display_name = " 󰈤  Tabs " }, -- string | nil
			{ source = "git_status", display_name = " 󰓂  Git" }, -- string | nil
			{ source = "diagnostics", display_name = " 裂" }, -- string | nil
		},
	},

	event_handlers = {
		{
			event = "neo_tree_window_after_open",
			handler = function(args)
				vim.opt_local.statuscolumn = ""
			end,
		},
	},

	enable_git_status = false,
	enable_diagnostics = true,

	hide_root_node = false,
	retain_hidden_root_indent = true,

	default_component_configs = {
		container = {
			enable_character_fade = false,
		},

		indent = {
			indent_marker = icons.indent_marker,
			last_indent_marker = icons.last_indent_marker,

			indent_size = 2,
			padding = 0,
		},

		icon = {
			folder_open = icons.folder_open,
			folder_closed = icons.folder_closed,
			folder_empty = icons.folder_empty,
		},

		name = {
			use_git_status_colors = true,
		},

		modified = {
			symbol = "",
		},
	},

	window = {
		-- position = "float",
		position = "left",
		width = 36,
		popup = { -- settings that apply to float position only
			size = { height = "80%", width = "80%" },
			position = "50%", -- 50% means center it
		},
		mappings = {
			["l"] = "open",
			["h"] = "close_node",
		},
	},

	renderers = {
		directory = {
			-- { "indent" },
			{ "icon" },
			{ "current_filter" },
			{ "name" },
			{ "symlink_target", highlight = "NeoTreeSymbolicLinkTarget" },
			{ "clipboard" },
		},
		file = {
			{ "indent" },
			{ "icon" },
			{
				"container",
				width = "98%",
				content = {
					{ "name", zindex = 1 },
					{ "clipboard", zindex = 1 },
					{ "bufnr", zindex = 1 },
					{ "modified", zindex = 2, align = "right" },
					{ "diagnostics", zindex = 2, align = "right" },
					{ "git_status", zindex = 2, align = "right" },
				},
			},
		},
	},

	filesystem = {
		filtered_items = {
			visible = true,
			hide_dotfiles = false,
			hide_gitignored = true,
			never_show = {
				".DS_Store",
			},
		},
		follow_current_file = true, -- This will find and focus the file in the active buffer every
		components = {
			icon = function(config, node, state)
				local highlight = config.highlight or "Normal"

				local icon = config.default
				local padding = config.padding or " "

				if node.type == "directory" then
					highlight = "NeoTreeDirectoryName"

					if node:is_expanded() then
						icon = config.folder_open or "-"
					else
						icon = config.folder_closed or "+"
					end

					if node:get_depth() == 1 then
						highlight = "NeoTreeRootName"
						icon = ""
					end

					if node.name == ".git" then
						icon = "󰴌 "
					end

					if node.name == "doc" then
						icon = "󰥩 "
					end

					if node.name == "test" then
						icon = "󱧻 "
					end
				elseif node.type == "file" then
					local success, web_devicons = pcall(require, "nvim-web-devicons")
					if success then
						local devicon, hl = web_devicons.get_icon(node.name, node.ext)
						icon = devicon or icon
						highlight = hl or highlight
					end
				end

				return {
					text = icon .. padding,
					highlight = highlight,
				}
			end,
			name = function(config, node)
				local name = node.name

				local highlight = config.highlight

				if node.type == "directory" then
					name = node.name
					highlight = "NeoTreeDirectoryNode"
				end

				if node:get_depth() == 1 then
					highlight = "NeoTreeRootName"
				end

				return {
					text = name,
					highlight = highlight,
				}
			end,
		},
	},
})
