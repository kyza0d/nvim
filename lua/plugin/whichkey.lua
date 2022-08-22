local status_ok, which_key = pcall(require, "which-key")

if not status_ok then
  return
end

local send_command = require("functions").send_command

local diagnostics_active = true

local b = require("utils").getvar("borders").telescope

local space_mappings = {
  o = {
    r = { ':lua require("telescope.builtin").oldfiles(_preview())<cr>', "Recent files" },
    p = { ":Telescope project<cr>", "Project" },
  },

  p = {
    name = "Packer",
    c = { ":PackerClean<cr>", "Clean" },
    i = { ":PackerInstall<cr>", "Install" },
    s = { ":PackerSync<cr>", "Sync" },
    u = { ":PackerUpdate<cr>", "Update" },
    p = { ":e ~/.config/nvim/lua/plugins/plugins.lua<cr>", "Packer file" },
  },

  g = {
    name = "Git",
    g = { ":lua lazygit_toggle()<cr>", "Source control" },
    b = { ":Gitsigns blame_line<cr>", "Blame" },
    p = { ":Gitsigns preview_hunk<cr>", "Preview hunk" },
    R = { ":Gitsigns reset_buffer<cr>", "Reset buffer" },
    r = { ":Gitsigns reset_hunk<cr>", "Reset hunk" },
    s = { ":Gitsigns stage_buffer<cr>", "Stage buffer" },
    a = { ":Gitsigns stage_hunk<cr>", "Git add" },
    o = { ":Telescope git_status<cr>", "Open changed file" },
    c = { ":Telescope git_commits<cr>", "Checkout commit" },
    d = { ":Gitsigns diffthis HEAD<cr>", "Diff" },
  },

  a = {
    name = "Actions",
    r = { ":lua reload_nvim()<cr>", "Start Server" },
    -- r = { ":lua reload_nvim()<cr>", "Reload neovim" },
  },

  l = {
    name = "LSP",
    a = { ":lua vim.lsp.buf.code_action()<cr>", "Code action" },
    d = { ":Trouble document_diagnostics<cr>", "Document Diagnostics" },
    D = { ":Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
    f = { ":lua vim.lsp.buf.format()<cr>", "Format" },
    r = { ":lua vim.lsp.buf.rename()<cr>", "Rename" },
  },

  ["s"] = {
    name = "Search",
    b = { ":Telescope git_branches<cr>", "Checkout branch" },
    c = { ":Telescope colorscheme<cr>", "Colorscheme" },
    r = { ":Telescope registers<cr>", "Registers" },
    p = { ":Telescope projects<cr>", "Projects" },
    k = { ":Telescope keymaps<cr>", "Keymaps" },
    h = { ":Telescope highlights<cr>", "Highlights" },
  },

  t = {
    name = "Toggle",
    c = { ":ColorizerToggle", "Toggle Colorizer" },
    i = { ":IndentBlanklineToggle<cr>", "Toggle IndentBlankLine" },
    s = { ":set invspell<cr>", "Spell" },
    l = {
      function()
        diagnostics_active = not diagnostics_active
        if diagnostics_active then
          vim.diagnostic.show()
        else
          vim.diagnostic.hide()
        end
      end,
      "Toggle Diagnostics",
    },
  },

  d = {
    name = "Dotfiles",
    v = {
      function()
        require("telescope.builtin").find_files({
          cwd = "~/.config/nvim",
          layout_strategy = "bottom_borders",
          borderchars = {
            prompt = { b.h, b.v, b.h, b.v, b.t_l, b.t_r, b.b_r, b.b_l },
            preview = { b.h, b.v, b.h, b.v, b.h_b, b.t_r, b.b_r, b.b_l },
            results = { b.h, b.v, b.h, b.v, b.v_r, b.v_l, b.h_t, b.b_l },
          },
          preview_title = "",
          prompt_title = "",
          results_title = "",
        })
      end,
      ".neovim",
    },
    e = {
      function()
        require("telescope.builtin").find_files({
          cwd = "~/.config/emacs/",
          layout_strategy = "bottom_borders",
          borderchars = {
            prompt = { b.h, b.v, b.h, b.v, b.t_l, b.t_r, b.b_r, b.b_l },
            preview = { b.h, b.v, b.h, b.v, b.h_b, b.t_r, b.b_r, b.b_l },
            results = { b.h, b.v, b.h, b.v, b.v_r, b.v_l, b.h_t, b.b_l },
          },
          preview_title = "",
          prompt_title = "",
          results_title = "",
        })
      end,
      ".neovim",
    },
    p = { ":e ~/.config/polybar/config.ini<cr>", ".polybar" },
    m = { ":e ~/.config/mpd/mpd.conf<cr>", ".mpd" },
    c = { ":e ~/.config/picom/picom.conf<cr>", ".picom" },
    f = { ":e ~/.config/ranger/rc.conf<cr>", ".ranger" },
    n = { ":e ~/.config/ncmpcpp/config<cr>", ".ncmpcpp" },
    t = { ":e ~/.tmux.conf<cr>", ".tmux" },
    b = { ":e ~/.bashrc<cr>", ".bash" },
    i = { ":e ~/.config/i3/config<cr>", ".i3" },
    q = { ":e ~/.config/qutebrowser/config.py<cr>", ".quitebrowser" },
    d = { ":e ~/.config/dunst/dunstrc<cr>", ".dunst" },
    x = { ":e ~/.xprofile<cr>", ".xprofile" },
    z = { ":e ~/.zshrc<cr>", ".zsh" },
    s = { ":e ~/.config/sxhkd/sxhkdrc<cr>", ".sxhkd" },
    r = { ":e ~/.config/rofi/config.rasi<cr>", ".rofi" },
    k = { ":e ~/.config/kitty/kitty.conf<cr>", ".kitty" },
    l = { ":e ~/.config/lsd/config.yaml<cr>", ".lsd" },
  },

  c = {
    name = "Colorschemes",
    a = { "<cmd>colorscheme aura<cr>", "aura" },
    o = { "<cmd>colorscheme onedark<cr>", "onedark" },
    D = { "<cmd>colorscheme dark-pines<cr>", "dark-pines" },
    -- s = { "<cmd>colorscheme solarized<cr>", "solarized" },
    s = { "<cmd>colorscheme summer-time<cr>", "summer-time" },
    S = { "<cmd>colorscheme summer-night<cr>", "summer_time" },
    g = { "<cmd>colorscheme gruvbox<cr>", "gruvbox" },
    v = { "<cmd>colorscheme vscode<cr>", "vscode" },
    t = { "<cmd>colorscheme tokyonight<cr>", "tokyonight" },
    d = {
      name = "Default themes",
      D = { "<cmd>colorscheme default<cr>", "default" },
      d = { "<cmd>colorscheme desert<cr>", "desert" },
      s = { "<cmd>colorscheme slate<cr>", "slate" },
      p = { "<cmd>colorscheme pablo<cr>", "pablo" },
      t = { "<cmd>colorscheme torte<cr>", "torte" },
      i = { "<cmd>colorscheme industry<cr>", "industry" },
    },
    p = { "<cmd>colorscheme papercolors<cr>", "papercolors" },
    h = { "<cmd>colorscheme hybrid<cr>", "hybrid" },
    u = { "<cmd>colorscheme urara<cr>", "urara" },
    j = { "<cmd>colorscheme j_blow<cr>", "j_blow" },
    m = { "<cmd>colorscheme  menguless<cr>", "menguless" },
    i = { "<cmd>colorscheme iceberg<cr>", "iceberg" },
    r = { "<cmd>colorscheme rasmus<cr>", "rasmus" },
    c = { "<cmd>colorscheme codeschool<cr>", "codeschool" },
    e = { "<cmd>colorscheme everforest<cr>", "everforest" },
    n = { "<cmd>colorscheme nord<cr>", "nord" },
    z = { "<cmd>colorscheme zenburn<cr>", "zenburn" },
  },
}

which_key.register(space_mappings, {
  mode = "n",
  prefix = "<leader>",
})

local cr_mappings = {
  -- r = { ':lua require("telescope.builtin").oldfiles(CMD_LINE())<cr>', "Recent files" },
  r = { ':lua require("telescope.builtin").oldfiles(DROPDOWN())<cr>', "Recent files" },
  -- r = { ':lua require("telescope.builtin").oldfiles(IVY())<cr>', "Recent files" },
  t = { ":ToggleAlternate<cr>", "Toggle Alternate" },
  q = { ":Bdelete!<cr>", "Close buffer" },
  d = { ":WhichKey \\<leader>d<cr>", "Dotfiles" },
  f = { ':lua require("telescope.builtin").live_grep(_preview())<cr>', "Find" },
  w = { ":w!<cr>", "Write buffer" },
  a = { ":norm @a<CR>", "Preform 'a' macro", silent = false },
  c = { ":PickColor<cr>", "Open colorpicker", silent = false },
  n = { ":norm ", "Normal command", silent = false },
  g = {
    name = "Git Actions",
    a = { ":!git add .", "Git add", silent = false },
    s = { ":Gitsigns stage_hunk<cr>", "Stage hunk" },
    u = { ":Gitsigns undo_stage_hunk<cr>", "Undo stage" },
    c = { ':!git commit -m ""<Left>', "Git commit", silent = false },
  },
  ["/"] = { ":lua require('telescope.builtin').help_tags(_preview())<cr>", "Man pages" },
  ["s"] = {
    name = "Search",
    ["s"] = {
      function()
        send_command("Search Google", function(value)
          vim.cmd("silent :!xdg-open 'https://duckduckgo.com/?q=" .. value .. "&ia=definition'")
        end, "   ")
      end,
      "Google",
    },
    ["g"] = {
      function()
        send_command("Search Github", function(value)
          vim.cmd("silent :!xdg-open 'https://github.com/search?q=" .. value .. "&type=code'")
        end, "   ")
      end,
      "Github",
    },
  },
}

local cr_mappings_visual = {
  a = { ":norm @a<CR>", "Preform 'a' macro", silent = false },
  s = { ":s/", "Substitute command ", silent = false, noremap = false },
  n = { ":norm ", "Normal command", silent = false },
}

which_key.register(cr_mappings_visual, {
  mode = "v",
  prefix = [[<cr>]],
})

which_key.register(cr_mappings, {
  mode = "n",
  prefix = [[<cr>]],
})

which_key.setup({
  plugins = {
    marks = false,
    registers = true,
    spelling = {
      enabled = true,
      suggestions = 20,
    },
    presets = {
      operators = false,
      motions = false,
      text_objects = false,
      windows = false,
      z = true,
      g = false,
    },
  },

  key_labels = {
    ["<leader>"] = "Leader",
    ["which_key_ignore"] = "",
  },

  icons = {
    breadcrumb = "",
    separator = "->",
    group = "",
  },

  popup_mappings = {
    scroll_down = "<c-d>",
    scroll_up = "<c-u>",
  },

  window = {
    border = "none",
    position = "bottom",
    margin = { 0, 0, 1, 0 },
    padding = { 0, 0, 1, 0 },
    winblend = 0,
  },

  layout = {
    height = { min = 4, max = 14 }, -- min and max height of the columns
    width = { min = 12, max = 30 }, -- min and max width of the columns
    spacing = 2,
    align = "left",
  },

  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  show_help = false,
})
