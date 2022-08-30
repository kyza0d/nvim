local status_ok, ufo = pcall(require, "ufo")

keymap("n", "<C-s-h>", ":foldclose<cr>")
keymap("n", "<C-s-l>", ":foldopen<cr>")

if not status_ok then
	return
end

ufo.setup()
