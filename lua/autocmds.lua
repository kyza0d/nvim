--------------------------------------------
-- Autocommands
--------------------------------------------

local group = create_augroup('kyza/general', {
  clear = true,
})

-- -- Enter commands under Statusline
-- create_autocmd({ 'CmdlineEnter', 'CmdlineLeave' }, {
--   callback = function()
--     editor.cmdheight = not editor.cmdheight
--     vim.opt.cmdheight = editor.cmdheight and 0 or 1
--   end,
--   group = group,
-- })

-- Source configuration files on save
-- create_autocmd('BufWritePost', {
--   command = 'source %',
--   pattern = '*/nvim/lua*',
--   group = group,
-- })

-- Yank highlighting settings
create_autocmd('TextYankPost', {
  command = "silent! lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 40})",
  group = group,
})

-- General buffer settings
create_autocmd('BufWinEnter', {
  command = 'set formatoptions-=cro',
  group = group,
})

create_autocmd('FileType', {
  pattern = { 'norg', 'help', 'markdown' },
  callback = function()
    vim.opt_local.foldcolumn = '0'
    vim.opt_local.foldenable = false
    vim.opt_local.number = false
    vim.opt_local.wrap = false
    vim.opt_local.statuscolumn = ''
  end,
  group = group,
})

-- Buffer behavior on enter
create_autocmd('BufEnter', {
  callback = function()
    fn_match('.fx', 'silent set filetype=hlsl')
    fn_match('.zshrc', 'silent set ft=bash')
    fn_match('.zsh-theme', 'silent set ft=bash')
    fn_match('.rasi', 'silent set ft=css')
    fn_match('polybar/config.ini', 'silent set ft=toml')
    fn_match('kitty.conf', 'silent set ft=conf')

    if vim.fn.getbufinfo('%')[1].name == '' then vim.opt.buflisted = false end
  end,
  group = group,
})

-- Close specific buffers with "q"
create_autocmd('FileType', {
  pattern = { 'Trouble', 'neo-tree', 'help', 'dashboard', 'nui-menu' },
  command = 'nnoremap <silent> <buffer> q :quit!<cr>',
  group = group,
})

-- Buffer behavior on ":w"
create_autocmd('BufWritePost', {
  callback = function()
    fn_match('polybar/config.ini', "silent !polybar-msg cmd restart && notify-send 'polybar restarted'")
    fn_match('kitty.conf', "silent !kill -SIGUSR1 $(pgrep kitty) && dunstify 'kitty restarted'")
    fn_match('dunstrc', 'silent !killall dunst && notify-send "dunst restarted"')
    fn_match('sxhkd', 'silent !pkill -USR1 -x sxhkd && notify-send "sxhkd Restarted"')
  end,
  group = group,
})

-- Colorscheme cache saving
create_autocmd('ColorScheme', {
  callback = function() ky.write_cache('colorscheme', vim.g.colors_name) end,
  group = group,
})
