local status_ok, bufferline = pcall(require, "bufferline")

if not status_ok then
	return
end

keymap("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>")
keymap("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>")
keymap("n", "<S-d>", "<cmd>Bdelete<cr>")

local workspace_root = function()
	local workspace_root = vim.fn.getcwd()
	local workspace = workspace_root:sub(workspace_root:find("[^/]*$"))
	if workspace == "evan" then
		workspace = "~"
	end
	return workspace
end

bufferline.setup({
	options = {
		indicator = {
			style = "icon",
		},
		separator_style = { "", "" },
		right_mouse_command = "Bdelete! %d",
		show_buffer_close_icons = true,
		enforce_regular_tabs = false,
		show_buffer_icons = false,
		buffer_close_icon = " ",
		show_close_icon = false,
		themeable = true,
		tab_size = 24,
		modified_icon = "ﱣ",
		left_trunc_marker = "",
		right_trunc_marker = "",
		offsets = {
			{
				filetype = "neo-tree",
				text_align = "left",
				padding = 0,
				text = "  " .. workspace_root(),
			},
		},
	},
})
