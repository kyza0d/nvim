local status_ok, comment = pcall(require, "nvim_comment")

keymap({ "n", "v" }, "<C-/>", ":CommentToggle<cr>")

if not status_ok then
	return
end

comment.setup()
