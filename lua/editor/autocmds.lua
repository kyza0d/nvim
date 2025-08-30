local group = create_augroup('kyza/general', {
  clear = true,
})

-- Source configuration files on save
create_autocmd('BufWritePost', {
  command = 'source %',
  pattern = '*/nvim/lua*',
  group = group,
})

create_autocmd('BufWinEnter', {
  command = 'set formatoptions-=cro',
  group = group,
})

vim.opt.splitright = true

create_autocmd('FileType', {
  pattern = 'help',
  callback = function() vim.cmd('wincmd L') end,
  group = group,
})

local smart_close_filetypes = ky.p_table({
  ['qf'] = true,
  ['log'] = true,
  ['codecompanion'] = true,
  ['help'] = true,
  ['lspinfo'] = true,
  ['git.*'] = true,
  ['Neogit.*'] = true,
})

local smart_close_buftypes = ky.p_table({
  ['nofile'] = true,
})

local function smart_close()
  if fn.winnr('$') ~= 1 then api.nvim_win_close(0, true) end
end

augroup('SmartClose', {
  event = { 'QuickFixCmdPost' },
  pattern = { '*grep*' },
  command = 'cwindow',
}, {
  event = { 'FileType' },
  pattern = { 'codecompanion', 'qf', 'log', 'help', 'lspinfo', 'git.*', 'Neogit.*', 'Avante*' },
  command = function(args)
    local is_unmapped = fn.hasmapto('q', 'n') == 0
    local buf = vim.bo[args.buf]
    local is_eligible = is_unmapped or vim.wo.previewwindow or smart_close_filetypes[buf.ft] or smart_close_buftypes[buf.bt]
    if is_eligible then keymap('n', 'q', smart_close, { buffer = args.buf, nowait = true }) end
  end,
}, {
  event = { 'BufEnter' },
  command = function()
    if fn.winnr('$') == 1 and vim.bo.buftype == 'quickfix' then api.nvim_buf_delete(0, { force = true }) end
  end,
}, {
  event = { 'QuitPre' },
  nested = true,
  command = function()
    if vim.bo.filetype ~= 'qf' then vim.cmd.lclose({ mods = { silent = true } }) end
  end,
})

create_autocmd('BufEnter', {
  callback = function()
    fn_match('.fx', 'silent set filetype=hlsl')
    fn_match('.zshrc', 'silent set ft=bash')
    fn_match('.zsh-theme', 'silent set ft=bash')
    fn_match('polybar/config.ini', 'silent set ft=toml')

    if vim.fn.getbufinfo('%')[1].name == '' then vim.opt.buflisted = false end
  end,
  group = group,
})

create_autocmd('FileType', {
  pattern = { 'Trouble', 'neo-tree', 'help', 'dashboard', 'nui-menu', 'Avante' },
  command = 'nnoremap <silent> <buffer> q :quit!<cr>',
  group = group,
})

create_autocmd('BufWritePost', {
  pattern = 'kitty.conf',
  callback = function()
    vim.fn.system('kill -SIGUSR1 $(pgrep kitty)')
    vim.notify('Restarted', 'info', { title = 'kitty.conf' })
  end,
})
