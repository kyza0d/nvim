local status_ok, neotree = pcall(require, "neo-tree")

if not status_ok then
	return
end

keymap("n", "<C-n>", ":Neotree focus toggle<cr>")

local highlights = require("neo-tree.ui.highlights")

neotree.setup({

	default_component_configs = {
		indent = {
			with_markers = true,
			indent_marker = "│",
			last_indent_marker = "╰",
			expander_highlight = "NeoTreeExpander",
			with_expanders = false,
		},

		icon = {
			folder_closed = " ",
			folder_open = " ",
			folder_empty = " ",
		},

		modified = {
			symbol = "",
		},
	},

	window = {
		width = 32,
		mappings = {
			["l"] = "open",
			["h"] = "close_node",
		},
	},

	filesystem = {
		follow_current_file = true,
		use_libuv_file_watcher = true,
		components = {
			name = function(config, node)
				local name = node.name
				local highlight = config.highlight or highlights.FILE_NAME
				if node.type == "directory" then
					highlight = highlights.DIRECTORY_NAME
					name = name .. "/"
				end
				return {
					text = name,
					highlight = highlight,
				}
			end,
		},
	},
})
