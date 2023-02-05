local fn_match = require("core.utils.fn_match")
local get_buf_info = require("core.utils.get_buf_info")

local group = vim.api.nvim_create_augroup("General", {
  clear = false,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  command = "silent! lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 40})",
  group = group,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  command = "set formatoptions-=cro",
  group = group,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help" },
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.opt_local.breakindent = false
    vim.opt_local.linebreak = true
  end,
  group = group,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  callback = function()
    fn_match(".zshrc", "silent set ft=bash")
    fn_match("polybar/config.ini", "silent set ft=toml")
    fn_match("kitty.conf", "silent set ft=conf")
  end,
  group = group,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  callback = function()
    fn_match("polybar/config.ini", ":silent !polybar-msg cmd restart && notify-send 'polybar restarted'")
    fn_match("kitty.conf", "silent !kill -SIGUSR1 $(pgrep kitty) && notify-send 'kitty restarted'")
    fn_match("dunstrc", 'silent !killall dunst && notify-send "dunst restarted"')
    fn_match("sxhkd", 'silent !pkill -USR1 -x sxhkd && notify-send "sxhkd Restarted"')
  end,
  group = group,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  command = "source %",
  pattern = "*/nvim/lua*",
  group = group,
})

-- Prevent [No Name] buffer from being listed
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if get_buf_info("%").name == "" then
      vim.opt.buflisted = false
    end
  end,
  group = group,
})

vim.api.nvim_create_autocmd("Filetype", {
  pattern = { "Trouble", "neo-tree", "help" },
  command = "nnoremap <silent> <buffer> q :close<cr>",
  group = group,
})
