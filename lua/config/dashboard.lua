require('dashboard').setup({
  theme = 'doom',
  hide = {
    tabline = false,
    statusline = true,
  },
  config = {
    header = {
      -- '                                                                        ',
      -- '                                                                        ',
      -- '                                                                        ',
      -- '    ██████   █████                   █████   █████  ███                 ',
      -- '   ░░██████ ░░███                   ░░███   ░░███  ░░░                  ',
      -- '    ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████  ',
      -- '    ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███ ',
      -- '    ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███ ',
      -- '    ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███ ',
      -- '    █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████',
      -- '   ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░ ',
      -- '                                                                        ',
      -- '                                                                        ',
      -- '       ────────────────────────────────────────────────────────────     ',
      -- '                                                                        ',
      '',
      '',
      '',
      '',
      '',
    },
    center = {
      {
        icon = '󰻭   ',
        icon_hl = 'Color1',
        desc = 'New File                   ',
        key = 'n',
        key_hl = 'Function',
        keymap = 'Space f n ',
        action = 'enew',
      },
      {
        icon = '󰱽   ',
        icon_hl = 'Color2',
        desc = 'Find Files',
        key = 'f',
        key_hl = 'Function',
        keymap = 'Space f f ',
        action = 'Telescope find_files',
      },
      {
        icon = '  ',
        icon_hl = 'Color1',
        desc = 'Projects',
        key = 'f',
        key_hl = 'Function',
        keymap = 'Space f p ',
        action = 'Telescope find_files',
      },
      {
        icon = '󱋢   ',
        icon_hl = 'Color3',
        desc = 'Recent Files',
        key = 'r',
        keymap = 'Space f r ',
        key_hl = 'Function',
        action = 'Telescope oldfiles',
      },
      {
        icon = '󱁼   ',
        icon_hl = 'Color4',
        desc = 'Dotfiles',
        key = 'd',
        keymap = 'Space o d ',
        key_hl = 'Function',
        action = 'WhichKey <leader>od',
      },
      {
        icon = '󰙅   ',
        icon_hl = 'Color7',
        desc = 'Explore',
        key = 'e',
        keymap = 'Space o e ',
        key_hl = 'Function',
        action = 'Neotree float',
      },
      {
        icon = '󰅚   ',
        icon_hl = 'Color6',
        key_hl = 'Hide',
        desc = 'Quit',
        action = 'q!',
      },
    },
    footer = { vim.fn.matchstr(vim.fn.execute('version'), [[NVIM v\zs[^\n]*]]) },
  },
})
