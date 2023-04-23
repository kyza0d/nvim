--
--
--  ██████   █████                   █████   █████  ███
-- ░░██████ ░░███                   ░░███   ░░███  ░░░
--  ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████
--  ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███
--  ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███
--  ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███
--  █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████
-- ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░
--
-- Author: Evan Smith <hi@kkyza.dev>
-- URL: https://github.com/ky2a/nvim

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.shadafile = "NONE"
vim.opt.shadafile = ""

-- Bootstrap lazy.nvim
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
    enabled = false,
  },
})

require("core.utils.colorscheme").apply()

require("core.options")
require("core.mappings")
require("core.aliases")
require("core.autocmds")

require("lsp")

vim.api.nvim_create_autocmd({ "BufEnter", "InsertEnter" }, {
  callback = function()
    if vim.bo.filetype ~= "neo-tree" then
      vim.o.statusline = "%{%v:lua.require('core.statusline').active()%}"
    end
  end,
})
