hl.plugin('Neovide', {
  theme = {
    ['*'] = {
      { Normal = { bg = { from = 'Background' } } },
      { NormalNC = { bg = { from = 'Background' } } },
      { Cursor = { bg = '#26b2ed', reverse = false } },
      { iCursor = { bg = '#26b2ed', reverse = false } },
      { lCursor = { bg = '#26b2ed', reverse = false } },
      { vCursor = { bg = '#26b2ed', reverse = false } },
      { tCursor = { bg = '#26b2ed', reverse = false } },
      { TermBorder = { fg = { from = 'Whitespace' }, strikethrough = false } },
    },
  },
})

ky.ui.border.single = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' }
icons.misc.vertical_bar = ' '
icons.indent_marker = ' '
icons.last_indent_marker = ' '

vim.g.neovide_refresh_rate = 144
vim.g.neovide_cursor_antialiasing = true
vim.g.neovide_cursor_animate_command_line = false
vim.g.neovide_cursor_trail_size = 0.6
vim.g.neovide_cursor_animation_length = 0.05
vim.g.neovide_cursor_vfx_mode = 'pixiedust' -- none, pixiedust, torpedo
vim.g.neovide_cursor_vfx_particle_curl = 3.0
vim.g.neovide_cursor_vfx_particle_density = 1.5
vim.g.neovide_cursor_vfx_particle_speed = 10.0
vim.g.neovide_confirm_quit = true
vim.g.neovide_unlink_border_highlights = true
vim.g.neovide_opacity = 0.95
vim.g.neovide_floating_shadow = false
vim.g.neovide_scale_factor = 0.9
vim.g.neovide_floating_corner_radius = 0.2

-- Iosevka Comfy Wide
-- https://github.com/protesilaos/iosevka-comfy
opt.guifont = 'Iosevka,Symbols Nerd Font:h14.4:w1.6'
-- opt.guifont = 'DM Mono,Symbols Nerd Font:h11.4:w1.0'

opt.linespace = 9
opt.laststatus = 2
opt.signcolumn = 'no'

opt.fillchars = {
  diff = ' ',
  vert = ' ',
  vertleft = ' ',
  vertright = ' ',
  verthoriz = ' ',
  eob = ' ',
}
