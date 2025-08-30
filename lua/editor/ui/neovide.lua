hl.plugin('Neovide', {
  theme = {
    ['*'] = {
      { Cursor = { bg = { from = '@accent.fg.500', attr = 'fg' } } },
      { iCursor = { bg = { from = '@accent.fg.500', attr = 'fg' } } },
      { lCursor = { bg = { from = '@accent.fg.500', attr = 'fg' } } },
      { vCursor = { bg = { from = '@accent.fg.500', attr = 'fg' } } },
      { tCursor = { bg = { from = '@accent.fg.500', attr = 'fg' } } },
      { TermBorder = { fg = { from = 'Whitespace' }, strikethrough = false } },
    },
  },
})

keymap({ 'n' }, '<C-ScrollWheelUp>', ':lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>')
keymap({ 'n' }, '<C-ScrollWheelDown>', ':lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>')

ky.ui.border.single = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' }

icons.indent_marker = ' '
icons.last_indent_marker = ' '

vim.g.neovide_refresh_rate = 144

vim.g.neovide_cursor_antialiasing = true
vim.g.neovide_cursor_animate_command_line = false
vim.g.neovide_cursor_trail_size = 2.6
vim.g.neovide_cursor_animation_length = 0.03
-- vim.g.neovide_scroll_animation_length = 0.0 -- disable

vim.g.neovide_scroll_animation_length = 0.2
-- vim.g.neovide_scroll_animation_length = 0.0 -- disable

vim.g.neovide_cursor_vfx_mode = 'none' -- none, pixiedust, torpedo
vim.g.neovide_cursor_vfx_particle_curl = 3.0
vim.g.neovide_cursor_vfx_particle_density = 1.5
vim.g.neovide_cursor_vfx_particle_speed = 11.0

vim.g.neovide_confirm_quit = true
vim.g.neovide_unlink_border_highlights = true
vim.g.neovide_opacity = 1.0
vim.g.neovide_floating_shadow = false
vim.g.neovide_floating_corner_radius = 0.2

opt.linespace = 10

opt.laststatus = 2
opt.signcolumn = 'yes'
opt.cursorline = false
opt.number = true
opt.cmdheight = 0

opt.fillchars = {
  diff = ' ',
  vert = ' ',
  vertleft = ' ',
  vertright = ' ',
  verthoriz = ' ',
  eob = ' ',
}
