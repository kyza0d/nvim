local status_ok, which_key = pcall(require, "which-key")

if not status_ok then
  return
end

local leader = {
  p = {
    name = "Packer",
    d = { ":PackerStatus<cr>", "details" },
    c = { ":PackerCompile profile=true<cr>", "compile" },
    i = { ":PackerInstall<cr>", "install" },
    p = { ":PackerProfile<cr>", "profile" },
    s = { ":PackerSync<cr>", "sync" },
    u = { ":PackerUpdate<cr>", "update" },
  },

  t = {
    name = "Toggle",
    s = { ":set invspell<cr>", "spell" },
  },

  c = {
    name = "Colorscheme",
    a = { "<cmd>colorscheme aura<cr>", "aura" },
    o = { "<cmd>colorscheme onedark<cr>", "onedark" },
    D = { "<cmd>colorscheme dark-pines<cr>", "dark-pines" },
    d = { "<cmd>colorscheme doom-one<cr>", "doom-one" },
    e = { "<cmd>colorscheme everforest<cr>", "everforest" },
    n = { "<cmd>colorscheme nord<cr>", "nord" },
    s = { "<cmd>colorscheme summer-time<cr>", "summer-time" },
    i = { "<cmd>colorscheme iceberg<cr>", "iceberg" },
    g = { "<cmd>colorscheme gruvbox<cr>", "gruvbox" },
    z = { "<cmd>colorscheme zenburn<cr>", "zenburn" },
    v = { "<cmd>colorscheme vscode<cr>", "vscode" },
    t = { "<cmd>colorscheme tokyonight<cr>", "tokyonight" },
  },

  g = {
    name = "Git",
    ["%"] = { ":!git add %<cr>", "Add current file" },
    ["d"] = { "<cmd>lua _lazygit_toggle()<CR>", "details" },
    ["i"] = { "<cmd>Octo issue search<cr>", "issues" },
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

  d = {
    name = "Dotfile",
    v = { ":Telescope find_files cwd=~/.config/nvim/<cr>", ".nvim" },
    p = { ":e ~/.config/polybar/config.ini<cr>", ".polybar" },
    c = { ":e ~/.config/picom/picom.conf<cr>", ".picom" },
    q = { ":e ~/.config/qutebrowser/config.py<cr>", ".qutebrowser" },
    b = { ":e ~/.config/bspwm/bspwmrc<cr>", ".bspwmrc" },
    d = { ":e ~/.config/dunst/dunstrc<cr>", ".dunst" },
    x = { ":e ~/.xprofile<cr>", ".xprofile" },
    z = { ":e ~/.zshrc<cr>", ".zsh" },
    s = { ":e ~/.config/sxhkd/sxhkdrc<cr>", ".sxhkd" },
    r = { ":e ~/.config/rofi/config.rasi<cr>", ".rofi" },
    k = { ":e ~/.config/kitty/kitty.conf<cr>", ".kitty" },
    l = { ":e ~/.config/lsd/config.yaml<cr>", ".lsd" },
  },
}

local cr_mappings = {
  r = { ':lua require("telescope.builtin").oldfiles(dropdown())<cr>', "Recent files" },
  g = { ':lua require("telescope.builtin").live_grep(bottom_borders())<cr>', "Grep" },
  d = { ":WhichKey \\<leader>d<cr>", "Dotfiles" },
  t = { ":TodoTrouble <cr>", "  Todo" },
  w = { ":w!<cr>", "Write buffer" },
  a = { ":norm @a<CR>", "Preform 'a' macro", silent = false },
  n = { ":norm ", "Normal command", silent = false },
  ["<CR>"] = {
    name = "dap",
    i = { ":lua require('dap').step_into()<cr>", "into" },
    o = { ":lua require('dap').step_over()<cr>", "over" },
    -- c = { ":lua require('dap').continue()<cr>", "continue" },
    c = {
      function()
        if vim.bo.filetype == "lua" then
          require("osv").run_this()
        else
          require("dap").continue()
        end
      end,
      "continue",
    },
    b = { ":lua require('dap').toggle_breakpoint()<cr>", "breakpoint" },
    B = { ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", "breakpoint condition" },
    r = { ":lua require('dap').repl.open()<cr>", "repl" },
    l = { ":lua require('dap').repl.run_last()<cr>", "repl last" },
    u = { ":lua require('dapui').open()<cr>", "ui" },
    h = { ":lua require('dap').run_to_cursor()<cr>", "run to cursor" },
    t = { ":lua require('dap').terminate({restart = true})<cr>", "terminate" },
  },
  ["/"] = { ":Telescope help_tags<cr>", "Man pages" },
  ["?"] = {
    function()
      require("utils.nui").open_first()
    end,
    "Search",
  },
}

local cr_mappings_visual = {
  a = { ":norm @a<CR>", "Preform 'a' macro", silent = false },
  s = { ":%s/", "Substitute command ", silent = false, noremap = false },
  n = { ":norm ", "Normal command", silent = false },
  h = {
    name = "hunk",
    s = { ":Gitsigns stage_hunk<cr>", "Stage hunk" },
  },
}

-- Mainly used for debugging
-- local backtick_mappings_visual = {
--   a = { ":norm @a<CR>", "Preform 'a' macro", silent = false },
--   s = { ":%s/", "Substitute command ", silent = false, noremap = false },
--   n = { ":norm ", "Normal command", silent = false },
--   h = {
--     name = "hunk",
--     s = { ":Gitsigns stage_hunk<cr>", "Stage hunk" },
--   },
-- }

which_key.register(leader, {
  mode = "n",
  prefix = "<Space>",
})

which_key.register(cr_mappings, {
  mode = "n",
  prefix = "<cr>",
})

which_key.register(cr_mappings_visual, {
  mode = "v",
  prefix = "<cr>",
})

which_key.setup({
  plugins = {
    marks = true,
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
    separator = "",
    group = "",
  },
})
