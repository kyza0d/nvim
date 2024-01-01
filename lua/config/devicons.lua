local nvim_web_devicons = require('nvim-web-devicons')
local icons = require('icons')

local new_icons = {}

require('nvim-web-devicons').set_default_icon(' ', '#6d8086', 65)

nvim_web_devicons.setup({
  override = icons.filetypes,
  override_by_filename = {
    ['readme.md'] = {
      icon = '',
      name = 'Readme',
      color = '#3498DB',
    },
    ['.gitignore'] = {
      icon = ' ',
      name = 'Gitignore',
    },
    ['.prettierrc'] = {
      icon = ' ',
      name = 'prettierrc',
    },
    ['.eslintrc.json'] = {
      icon = ' ',
      name = 'eslintrc',
      color = '#2ECC71',
    },
    ['.eslintignore'] = {
      icon = ' ',
      name = 'eslintignore',
      color = '#F1C40F', -- a sunny yellow
    },
  },
})

local current_icons = nvim_web_devicons.get_icons()

for _, icon in pairs(current_icons) do
  icon.icon = string.format('%s ', icon.icon)
end

nvim_web_devicons.set_icon(new_icons)
