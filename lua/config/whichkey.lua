vim.g.fullscreen = false

local leader = {

  ----------------------------------------------
  -- Fuzzy find
  ----------------------------------------------

  f = {
    name = 'Find',
    f = { '<cmd>Telescope find_files<cr>', 'files' },
    r = { '<cmd>Telescope oldfiles<cr>', 'recent files' },
    g = { '<cmd>Telescope live_grep<cr>', 'grep' },
    b = { '<cmd>Telescope buffers<cr>', 'buffers' },
    h = { '<cmd>Telescope help_tags<cr>', 'help' },
  },

  ----------------------------------------------
  -- Open buffers
  ----------------------------------------------

  o = {
    name = 'Open',
    t = {
      function()
        local Terminal = require('toggleterm.terminal').Terminal
        local window = Terminal:new({
          direction = 'tab',
        })

        window:toggle()
      end,
      'terminal',
    },
    n = {
      '<cmd>enew<cr>',
      'new file',
    },
    e = {
      '<cmd>Neotree float<cr>',
      'explorer',
    },
    d = {
      name = 'dotfile',
      n = { ':Telescope find_files cwd=~/.config/nvim/<cr>', '.nvim' },
      p = { ':silent e ~/.config/polybar/config.ini<cr>', '.polybar' },
      e = { ':Telescope find_files cwd=~/.config/eww/<cr>', '.eww' },
      c = { ':silent e ~/.config/picom/picom.conf<cr>', '.picom' },
      q = { ':silent e ~/.config/qutebrowser/config.py<cr>', '.qutebrowser' },
      b = { ':silent e ~/.config/bspwm/bspwmrc<cr>', '.bspwmrc' },
      d = { ':silent e ~/.config/dunst/dunstrc<cr>', '.dunst' },
      x = { ':silent e ~/.xprofile<cr>', '.xprofile' },
      z = { ':silent e ~/.zshrc<cr>', '.zsh' },
      s = { ':silent e ~/.config/sxhkd/sxhkdrc<cr>', '.sxhkd' },
      r = { ':silent e ~/.config/rofi/config.rasi<cr>', '.rofi' },
      k = { ':silent e ~/.config/kitty/kitty.conf<cr>', '.kitty' },
      l = { ':silent e ~/.config/lsd/config.yaml<cr>', '.lsd' },
    },
  },

  ----------------------------------------------
  -- Change colorscheme
  ----------------------------------------------
  c = {
    name = 'Colorscheme',
    o = { '<cmd>colorscheme onedark<cr>', 'onedark' },
    d = { '<cmd>colorscheme doom-one<cr>', 'doom-one' },
    e = { '<cmd>colorscheme embark<cr>', 'embark' },
    n = { '<cmd>colorscheme nord<cr>', 'nord' },
    s = { '<cmd>colorscheme summer-time<cr>', 'summer-time' },
    i = { '<cmd>colorscheme iceberg<cr>', 'iceberg' },
  },

  ----------------------------------------------
  -- Git actions
  ----------------------------------------------
  g = {
    name = 'Git',
    ['%'] = { ':!git add %<cr>', 'Add current file' },
    ['d'] = { '<cmd>lua _lazygit_toggle()<CR>', 'details' },
    r = {
      name = 'reset',
      ['h'] = { ':Gitsigns reset_hunk<cr>', 'hunk' },
      ['b'] = { ':Gitsigns reset_buffer<cr>', 'buffer' },
    },
    s = {
      name = 'stage',
      ['h'] = { ':Gitsigns stage_hunk<cr>', 'hunk' },
      ['b'] = { ':Gitsigns stage_buffer<cr>', 'buffer' },
    },
  },

  ----------------------------------------------
  -- Project wide-actions
  ----------------------------------------------
  s = {
    name = 'Spectre',
    s = { "<cmd>lua require('spectre').open()<CR>", 'Open' },
    w = { "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", 'Search current Word' },
    p = { "viw:lua require('spectre').open_file_search()<cr>", 'Search in current file' },
  },

  ----------------------------------------------
  -- Togglable actions
  ----------------------------------------------
  -- t = {
  --   name = 'Toggle',
  --   n = { ':lua vim.opt.number = not(vim.opt.number:get())<cr>', 'number' },
  --   -- n = { ':set number!<cr>', 'number' },
  --   -- r = { ':set relativenumber!<cr>', 'relativenumber' },
  -- },

  ----------------------------------------------
  -- Navigate to dotfiles
  ----------------------------------------------

  k = {
    name = 'Kitty',
    q = { ':!xdotool key --delay 0 --clearmodifiers "ctrl+shift+w"<cr>', 'close window' },
  },
}

local cr_mappings = {
  d = { '<cmd>WhichKey <leader>od<cr>', 'Dotfiles' },
  s = { '<cmd>Telescope lsp_workspace_symbols<cr>', 'Workspace Symbols' },
  f = {
    function()
      vim.g.fullscreen = not vim.g.fullscreen

      vim.fn.system("bspc node -t '~fullscreen'")
      vim.fn.system("notify-send 'Neovim fullscreened (CR + f) to exit' -r 5555")
      vim.g.neovide_transparency = 1.0

      if not vim.g.fullscreen then
        local alpha = function() return string.format('%x', math.floor(255 * 0.8)) end
        vim.g.neovide_background_color = '#0f1117' .. alpha()
        vim.g.neovide_transparency = 0.92
        vim.g.transparency = 0.92
      end
    end,
    'Fullscreen',
  },
  b = { '<cmd>Telescope buffers<cr>', 'buffers' },
  l = {
    name = 'List',
    t = { ':TodoTrouble <cr>', '  Todo' },
    d = { ':Trouble workspace_diagnostics<cr>', '  Diagnostics' },
  },
  w = { ':w!<cr>', 'Write buffer' },
  r = { '<cmd>Telescope oldfiles<cr>', 'recent' },
  g = { '<cmd>Telescope live_grep<cr>', 'ripgrep' },
  n = { '<cmd>Navbuddy<cr>', 'Navbuddy' },
  a = { ':norm @a<CR>', "Preform 'a' macro", silent = false },
  h = { ':Telescope help_tags<cr>', 'Search' },
  z = { '<cmd>TZMinimalist<cr>', 'Zen mode' },
  ['1'] = { '<cmd>BufferLineGoToBuffer 1<cr>', 'Buffer 1' },
  ['2'] = { '<cmd>BufferLineGoToBuffer 2<cr>', 'Buffer 2' },
  ['3'] = { '<cmd>BufferLineGoToBuffer 3<cr>', 'Buffer 3' },
  ['4'] = { '<cmd>BufferLineGoToBuffer 4<cr>', 'Buffer 4' },
  ['5'] = { '<cmd>BufferLineGoToBuffer 5<cr>', 'Buffer 5' },
  ['/'] = { ':Telescope live_grep<cr>', 'Grep' },
}

local cr_mappings_visual = {
  g = {
    name = 'Git',
    s = { ':Gitsigns stage_hunk<cr>', 'Stage hunk' },
  },
}

require('which-key').register(leader, {
  mode = 'n',
  prefix = '<Space>',
})

require('which-key').register(cr_mappings, {
  mode = 'n',
  prefix = '<cr>',
})

require('which-key').register(cr_mappings_visual, {
  mode = 'v',
  prefix = '<cr>',
})

require('which-key').setup({
  icons = {
    breadcrumb = '',
    separator = '-',
    group = '',
  },

  window = {
    border = 'single', -- none, single, double, shadow
  },
})

-- ohe whichkey mapping will have the following format <
