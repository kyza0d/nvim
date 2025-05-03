hl.plugin('Neovide', {
  theme = {
    ['*'] = {
      { Cursor = { bg = '#AFBD30', reverse = false } },
      { iCursor = { bg = '#0F1A0E', reverse = false } },
      { lCursor = { bg = '#0F1A0E', reverse = false } },
      { vCursor = { bg = '#0F1A0E', reverse = false } },
      { tCursor = { bg = '#0F1A0E', reverse = false } },
      { Pmenu = { bg = { from = 'Normal', alter = -0.30 } } },
      { PmenuSel = { bg = { from = 'Normal', alter = 0.20 }, fg = 'none' } },
      { TermBorder = { fg = { from = 'Whitespace' }, strikethrough = false } },
    },
  },
})

ky.ui.border.single = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' }
icons.misc.vertical_bar = ''
icons.indent_marker = ' '
icons.last_indent_marker = ' '

vim.g.neovide_refresh_rate = 60
vim.g.neovide_cursor_antialiasing = true
vim.g.neovide_cursor_animate_command_line = false
vim.g.neovide_cursor_trail_size = 0.6
vim.g.neovide_cursor_animation_length = 0.05
vim.g.neovide_cursor_vfx_mode = 'pixiedust' -- none, pixiedust, torpedo
vim.g.neovide_cursor_vfx_particle_curl = 3.8
vim.g.neovide_cursor_vfx_particle_density = 40.4
vim.g.neovide_cursor_vfx_particle_speed = 10.0
vim.g.neovide_confirm_quit = true
vim.g.neovide_unlink_border_highlights = true
vim.g.neovide_transparency = 1.0
vim.g.transparency = 0.9
vim.g.neovide_floating_shadow = false
vim.g.neovide_floating_blur = 0
vim.g.neovide_scale_factor = 0.9
vim.g.neovide_floating_corner_radius = 0.2

-- Iosevka Comfy Wide
-- https://github.com/protesilaos/iosevka-comfy
-- vim.opt.guifont = 'Iosevka Comfy Wide,Symbols Nerd Font:h10.1:w1.0'
-- vim.opt.guifont = 'Cartograph CF Light,Symbols Nerd Font:h13.4:w1.4'
vim.opt.guifont = 'Cartograph CF Light,Symbols Nerd Font:h11.3:w1.5'
-- vim.opt.guifont = 'Iosevka,Symbols Nerd Font:h14.4:w1.6'
-- vim.opt.guifont = 'Iosevka,Symbols Nerd Font:h12.8:w1.6'
-- vim.opt.guifont = 'Iosevka,Symbols Nerd Font:h10.4:w1.6'
-- -- vim.opt.guifont = 'Jetbrains Mono,Symbols Nerd Font:h9.4:w1.7'
--
opt.linespace = 9
vim.opt.laststatus = 2
vim.opt.signcolumn = 'no'

vim.opt.fillchars = {
  diff = ' ',
  vert = ' ',
  vertleft = ' ',
  vertright = ' ',
  verthoriz = ' ',
  eob = ' ',
}
