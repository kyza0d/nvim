vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.shadafile = "NONE"
vim.opt.shadafile = ""

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugin" },
  },
  diff = {
    cmd = "terminal_git",
  },
  change_detection = {
    notify = false,
  },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      -- stylua: ignore
      disabled_plugins = {
        "gzip", "matchparen", "netrwPlugin",
        "rplugin", "tarPlugin", "tohtml",
        "tutor", "zipPlugin",
      },
    },
  },
  defaults = {
    lazy = true,
  },
  checker = {
    enabled = true,
  },
})

require("core.options")
require("core.mappings")
require("core.aliases")
require("core.autocmds")

require("servers")

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  command = "set statusline=%{%v:lua.require('core.statusline').active()%}",
})
