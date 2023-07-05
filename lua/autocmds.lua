local fn_match = function(filename, command)
  if string.find(vim.fn.expand('%'), filename) then vim.cmd(command) end
end

local group = create_augroup('General', {
  clear = false,
})

create_autocmd('TextYankPost', {
  command = "silent! lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 40})",
  group = group,
})

create_autocmd('BufWinEnter', {
  command = 'set formatoptions-=cro',
  group = group,
})

create_autocmd('BufEnter', {
  callback = function() fn_match('.fx', 'silent set filetype=hlsl') end,
  group = group,
})

create_autocmd('FileType', {
  pattern = { 'help' },
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.opt_local.breakindent = false
    vim.opt_local.linebreak = true
  end,
  group = group,
})

create_autocmd('BufWinEnter', {
  callback = function()
    fn_match('.zshrc', 'silent set ft=bash')
    fn_match('polybar/config.ini', 'silent set ft=toml')
    fn_match('kitty.conf', 'silent set ft=conf')
  end,
  group = group,
})

create_autocmd('BufWritePost', {
  callback = function()
    fn_match('polybar/config.ini', ":silent !polybar-msg cmd restart && notify-send 'polybar restarted'")
    fn_match('kitty.conf', "silent !kill -SIGUSR1 $(pgrep kitty) && notify-send 'kitty restarted'")
    fn_match('dunstrc', 'silent !killall dunst && notify-send "dunst restarted"')
    fn_match('sxhkd', 'silent !pkill -USR1 -x sxhkd && notify-send "sxhkd Restarted"')
  end,
  group = group,
})

create_autocmd('BufWritePost', {
  command = 'source %',
  pattern = '*/nvim/lua*',
  group = group,
})

create_autocmd('BufEnter', {
  callback = function()
    if vim.fn.getbufinfo('%')[1].name == '' then vim.opt.buflisted = false end
  end,
  group = group,
})

create_autocmd('Filetype', {
  pattern = { 'Trouble', 'neo-tree', 'help', 'dashboard' },
  command = 'nnoremap <silent> <buffer> q :quit!<cr>',
  group = group,
})

-- -- Remember colorscheme on change
create_autocmd('ColorScheme', {
  callback = function() require('utils.colorscheme').save() end,
  group = group,
})
