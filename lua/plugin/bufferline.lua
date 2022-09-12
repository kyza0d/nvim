local status_ok, bufferline = pcall(require, "bufferline")

if not status_ok then
  return
end

local colors = require("palette").colors

local root = function()
  local root = vim.fn.getcwd()
  local workspace = root:sub(root:find("[^/]*$"))
  return workspace
end

local colors = require("palette").colors

vim.cmd(string.format("hi NeoTreeHeading guibg=%s guifg=%s", colors.background_shaded_0, colors.green))

bufferline.setup({
  options = {
    separator_style = { " ", " " },
    -- separator_style = { "🭲", "🭲" },
    -- separator_style = "slant",
    enforce_regular_tabs = false,
    indicator = "",
    -- indicator = {
    --   icon = "▎", -- this should be omitted if indicator style is not 'icon'
    --   style = "icon",
    -- },
    right_mouse_command = "Bdelete! %d",
    show_buffer_close_icons = false,
    show_buffer_icons = true,
    buffer_close_icon = " ",
    show_close_icon = false,
    themeable = true,
    tab_size = 21,
    modified_icon = "ﱣ",
    left_trunc_marker = "",
    right_trunc_marker = "",

    offsets = {
      {
        filetype = "neo-tree",
        text_align = "left",
        highlight = "NeoTreeHeading",
        padding = 0,
        text = "   " .. root(),
        -- text = "  " .. workspace_root():upper(),
      },
    },
    custom_areas = {
      left = function()
        if vim.g.neo_tree_opened then
          return {
            { text = "▕", fg = colors.foreground_4, bg = colors.background_shaded_0 },
          }
        end
      end,
    },
  },
})

keymap("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>")
keymap("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>")
keymap("n", "<S-d>", "<cmd>Bdelete<cr>")
