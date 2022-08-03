local create_autocmd = vim.api.nvim_create_autocmd

local fn_match = require("utils").fn_match

local get_buf_info = require("utils").get_buf_info

local group = vim.api.nvim_create_augroup("general", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  command = "silent! lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 60})",
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  command = "set formatoptions-=cro",
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  callback = function()
    fn_match(".zshrc", "silent set ft=bash")
    fn_match("polybar/config.ini", "silent set ft=toml")
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  callback = function()
    fn_match("polybar/config.ini", ":silent !polybar-msg cmd restart && notify-send 'polybar restarted'")
    fn_match("kitty.conf", "silent !kill -SIGUSR1 $(pgrep kitty) && notify-send 'kitty restarted'")
    fn_match("dunstrc", 'silent !killall dunst && notify-send "dunst restarted"')
    fn_match("sxhkd", 'silent !pkill -USR1 -x sxhkd && notify-send "sxhkd Restarted"')
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  command = "source %",
  pattern = "*/nvim/lua*",
})

-- Prevent [No Name] buffer from being listed
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if get_buf_info("%").name == "" then
      vim.opt.buflisted = false
    end
  end,
})

vim.api.nvim_create_autocmd("Filetype", {
  command = "setlocal laststatus=0",
  pattern = { "qf", "Trouble" },
})

vim.api.nvim_create_autocmd("Filetype", {
  command = "nnoremap <silent> <buffer> q :close<cr>",
  pattern = { "Trouble", "neo-tree", "help" },
})
