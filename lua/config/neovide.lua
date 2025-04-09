local hl, P = ky.hl, ky.ui.palette

hl.plugin('Neovide', {
  theme = {
    ['*'] = {
      { Cursor = { bg = '#3DDBD9', reverse = false } },
      { iCursor = { bg = '#3DDBD9', reverse = false } },
      { lCursor = { bg = '#3DDBD9', reverse = false } },
      { vCursor = { bg = '#3DDBD9', reverse = false } },
      { tCursor = { bg = '#3DDBD9', reverse = false } },
      { Pmenu = { bg = { from = 'Normal', alter = -0.30 } } },
      { PmenuSel = { bg = { from = 'Normal', alter = 0.20 }, fg = 'none' } },

      { TermBorder = { fg = { from = 'Whitespace' }, strikethrough = false } },
    },
  },
})

keymap('n', '<M-CR>', '<cmd>split<cr>', { desc = 'Split window' })

editor.zen_mode = true

ky.ui.border.single = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' }
ky.ui.icons.misc.vertical_bar = ''
ky.ui.icons.neo_tree.indent_marker = ' '
ky.ui.icons.neo_tree.last_indent_marker = ' '

vim.g.neovide_refresh_rate = 144
vim.g.neovide_cursor_antialiasing = true
vim.g.neovide_cursor_animate_command_line = true
vim.g.neovide_cursor_trail_size = 0.6
vim.g.neovide_cursor_animation_length = 0.05
vim.g.neovide_cursor_vfx_mode = 'pixiedust' -- none, pixiedust, torpedo
vim.g.neovide_cursor_vfx_particle_curl = 3.8
vim.g.neovide_cursor_vfx_particle_density = 40.4
vim.g.neovide_cursor_vfx_particle_speed = 10.0
vim.g.neovide_confirm_quit = true
vim.g.neovide_unlink_border_highlights = true
vim.g.neovide_transparency = 1.0
vim.g.transparency = 1.0
vim.g.neovide_floating_shadow = false
vim.g.neovide_floating_blur = 0
vim.g.neovide_scale_factor = 0.9

-- Iosevka Comfy Wide
-- https://github.com/protesilaos/iosevka-comfy
-- vim.opt.guifont = 'Iosevka Comfy Wide,Symbols Nerd Font:h10.1:w1.0'
vim.opt.guifont = 'Cartograph CF Light,Symbols Nerd Font:h11.4:w1.4'
-- vim.opt.guifont = 'Jetbrains Mono,Symbols Nerd Font:h9.4:w1.7'

opt.linespace = 11
vim.opt.laststatus = 2
vim.opt.statuscolumn = table.concat({ '  %@NumCb@%l  ' })
vim.opt.fillchars = { diff = ' ', vert = ' ', vertleft = ' ', vertright = ' ', verthoriz = ' ', eob = ' ' }
