local status_ok, which_key = pcall(require, "which-key")

if not status_ok then
  return
end

-- Space for leader
vim.g.mapleader = " "
vim.g.localmapleader = " "

local leader = {
  p = {
    name = "Packer",
    c = { ":PackerClean<cr>", "Clean" },
    i = { ":PackerInstall<cr>", "Install" },
    s = { ":PackerSync<cr>", "Sync" },
    u = { ":PackerUpdate<cr>", "Update" },
  },

  t = {
    name = "Toggle",
    s = { ":set invspell<cr>", "spell" },
  },

  c = {
    name = "Colorschemes",
    a = { "<cmd>colorscheme aura<cr>", "aura" },
    o = { "<cmd>colorscheme onedark<cr>", "onedark" },
    D = { "<cmd>colorscheme dark-pines<cr>", "dark-pines" },
    d = { "<cmd>colorscheme doom-one<cr>", "doom-one" },
    n = { "<cmd>colorscheme nord<cr>", "nord" },
    s = { "<cmd>colorscheme summer-time<cr>", "summer-time" },
    g = { "<cmd>colorscheme gruvbox<cr>", "gruvbox" },
    z = { "<cmd>colorscheme zenburn<cr>", "zenburn" },
    v = { "<cmd>colorscheme vscode<cr>", "vscode" },
    t = { "<cmd>colorscheme tokyonight<cr>", "tokyonight" },
  },

  b = {
    name = "Buffer",
    s = { ":Gitsigns stage_buffer<cr>", "Stage Buffer" },
  },

  g = {
    name = "Git",
    ["%"] = { ":!git add %<cr>", "Add current file" },
  },

  d = {
    name = "Dotfiles",
    v = { ":Telescope find_files cwd=~/.config/nvim/<cr>", ".nvim" },
    p = { ":e ~/.config/polybar/config.ini<cr>", ".polybar" },
    c = { ":e ~/.config/picom/picom.conf<cr>", ".picom" },
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
  d = { ":WhichKey \\<leader>d<cr>", "Dotfiles" },
  f = { ":Telescope live_grep<cr>", "Find" },
  w = { ":w!<cr>", "Write buffer" },
  a = { ":norm @a<CR>", "Preform 'a' macro", silent = false },
  n = { ":norm ", "Normal command", silent = false },
  ["/"] = { ":Telescope help_tags<cr>", "Man pages" },
}

local cr_mappings_visual = {
  a = { ":norm @a<CR>", "Preform 'a' macro", silent = false },
  s = { ":s/", "Substitute command ", silent = false, noremap = false },
  n = { ":norm ", "Normal command", silent = false },
  h = {
    name = "hunk",
    s = { ":Gitsigns stage_hunk<cr>", "Stage hunk" },
  },
}

which_key.register(leader, {
  mode = "n",
  prefix = "<leader>",
})

which_key.register(cr_mappings, {
  mode = "n",
  prefix = "<cr>",
})

which_key.register(cr_mappings_visual, {
  mode = "v",
  prefix = "<cr>",
})

which_key.setup({})
