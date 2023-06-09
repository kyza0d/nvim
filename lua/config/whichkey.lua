local leader = {

  ----------------------------------------------
  -- Fuzzy find
  ----------------------------------------------

  f = {
    name = "Find",
    f = { "<cmd>Telescope find_files<cr>", "files" },
    r = { "<cmd>Telescope oldfiles<cr>", "recent files" },
    g = { "<cmd>Telescope live_grep<cr>", "grep" },
    b = { "<cmd>Telescope buffers<cr>", "buffers" },
    h = { "<cmd>Telescope help_tags<cr>", "help" },
  },

  ----------------------------------------------
  -- Open buffers
  ----------------------------------------------

  o = {
    name = "Open",
    t = {
      function()
        local Terminal = require("toggleterm.terminal").Terminal
        local window = Terminal:new({
          direction = "tab",
        })

        window:toggle()
      end,
      "terminal",
    },
    n = {
      "<cmd>enew<cr>",
      "new file",
    },
    e = {
      "<cmd>Neotree float<cr>",
      "explorer",
    },
    d = {
      name = "dotfile",
      n = { ":Telescope find_files cwd=~/.config/nvim/<cr>", ".nvim" },
      p = { ":silent e ~/.config/polybar/config.ini<cr>", ".polybar" },
      e = { ":Telescope find_files cwd=~/.config/eww/<cr>", ".eww" },
      c = { ":silent e ~/.config/picom/picom.conf<cr>", ".picom" },
      q = { ":silent e ~/.config/qutebrowser/config.py<cr>", ".qutebrowser" },
      b = { ":silent e ~/.config/bspwm/bspwmrc<cr>", ".bspwmrc" },
      d = { ":silent e ~/.config/dunst/dunstrc<cr>", ".dunst" },
      x = { ":silent e ~/.xprofile<cr>", ".xprofile" },
      z = { ":silent e ~/.zshrc<cr>", ".zsh" },
      s = { ":silent e ~/.config/sxhkd/sxhkdrc<cr>", ".sxhkd" },
      r = { ":silent e ~/.config/rofi/config.rasi<cr>", ".rofi" },
      k = { ":silent e ~/.config/kitty/kitty.conf<cr>", ".kitty" },
      l = { ":silent e ~/.config/lsd/config.yaml<cr>", ".lsd" },
    },
  },

  ----------------------------------------------
  -- Change colorscheme
  ----------------------------------------------
  c = {
    name = "Colorscheme",
    o = { "<cmd>colorscheme onedark<cr>", "onedark" },
    d = { "<cmd>colorscheme doom-one<cr>", "doom-one" },
    e = { "<cmd>colorscheme embark<cr>", "embark" },
    n = { "<cmd>colorscheme nord<cr>", "nord" },
    s = { "<cmd>colorscheme summer-time<cr>", "summer-time" },
    i = { "<cmd>colorscheme iceberg<cr>", "iceberg" },
  },

  ----------------------------------------------
  -- Git actions
  ----------------------------------------------
  g = {
    name = "Git",
    ["%"] = { ":!git add %<cr>", "Add current file" },
    ["d"] = { "<cmd>lua _lazygit_toggle()<CR>", "details" },
    r = {
      name = "reset",
      ["h"] = { ":Gitsigns reset_hunk<cr>", "hunk" },
      ["b"] = { ":Gitsigns reset_buffer<cr>", "buffer" },
    },
    s = {
      name = "stage",
      ["h"] = { ":Gitsigns stage_hunk<cr>", "hunk" },
      ["b"] = { ":Gitsigns stage_buffer<cr>", "buffer" },
    },
  },

  ----------------------------------------------
  -- Navigate to dotfiles
  ----------------------------------------------

  k = {
    name = "Kitty",
    q = { ':!xdotool key --delay 0 --clearmodifiers "ctrl+shift+w"<cr>', "close window" },
  },
}

local cr_mappings = {
  d = { "<cmd>WhichKey <leader>od<cr>", "Dotfiles" },
  s = { "<cmd>Telescope lsp_workspace_symbols<cr>", "Workspace Symbols" },
  b = { "<cmd>Telescope buffers<cr>", "buffers" },
  l = {
    name = "List",
    t = { ":TodoTrouble <cr>", "  Todo" },
    d = { ":Trouble workspace_diagnostics<cr>", "  Diagnostics" },
  },
  w = { ":w!<cr>", "Write buffer" },
  r = { "<cmd>Telescope oldfiles<cr>", "recent" },
  g = { "<cmd>Telescope live_grep<cr>", "ripgrep" },
  n = { "<cmd>Navbuddy<cr>", "Navbuddy" },
  a = { ":norm @a<CR>", "Preform 'a' macro", silent = false },
  h = { ":Telescope help_tags<cr>", "Search" },
  [","] = { ":foldclose<cr>", "Fold Close", silent = false },
  ["."] = { ":foldopen<cr>", "Fold Open", silent = false },
  ["/"] = { ":Telescope live_grep<cr>", "Grep" },
}

local cr_mappings_visual = {
  g = {
    name = "Git",
    s = { ":Gitsigns stage_hunk<cr>", "Stage hunk" },
  },
}

require("which-key").register(leader, {
  mode = "n",
  prefix = "<Space>",
})

require("which-key").register(cr_mappings, {
  mode = "n",
  prefix = "<cr>",
})

require("which-key").register(cr_mappings_visual, {
  mode = "v",
  prefix = "<cr>",
})

require("which-key").setup({
  window = {
    border = "none", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 3, 2, 3 }, -- extra window padding [top, right, bottom, left]
  },

  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 10, -- spacing between columns
    align = "left", -- align columns left, center or right
  },

  plugins = {
    marks = false,
    registers = false,
    spelling = {
      enabled = true,
      suggestions = 20,
    },

    presets = {
      operators = true,
      motions = true,
      text_objects = true,
      windows = true,
      nav = true,
      z = true,
      g = true,
    },
  },

  icons = {
    breadcrumb = "",
    -- separator = "->",
    separator = "",
    group = "",
  },
})
