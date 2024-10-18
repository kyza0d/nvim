--------------------------------------------
-- Autocommands
--------------------------------------------

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

create_autocmd('FileType', {
  pattern = { 'Trouble' },
  callback = function()
    vim.opt_local.foldcolumn = '0'
    vim.opt_local.foldenable = false
    vim.opt_local.winbar = nil
  end,
  group = group,
})

local smart_close_filetypes = ky.p_table({
  ['qf'] = true,
  ['log'] = true,
  ['help'] = true,
  ['lspinfo'] = true,
  ['git.*'] = true,
  ['Neogit.*'] = true,
  ['copilot.*'] = true,
})

local smart_close_buftypes = ky.p_table({
  ['nofile'] = true,
})

local function smart_close()
  if fn.winnr('$') ~= 1 then api.nvim_win_close(0, true) end
end

ky.augroup('SmartClose', {
  -- Auto open grep quickfix window
  event = { 'QuickFixCmdPost' },
  pattern = { '*grep*' },
  command = 'cwindow',
}, {
  -- Close certain filetypes by pressing q.
  event = { 'FileType' },
  pattern = { 'qf', 'log', 'help', 'lspinfo', 'git.*', 'Neogit.*', 'Avante*' },
  command = function(args)
    local is_unmapped = fn.hasmapto('q', 'n') == 0
    local buf = vim.bo[args.buf]
    local is_eligible = is_unmapped or vim.wo.previewwindow or smart_close_filetypes[buf.ft] or smart_close_buftypes[buf.bt]
    if is_eligible then keymap('n', 'q', smart_close, { buffer = args.buf, nowait = true }) end
  end,
}, {
  -- Close quick fix window if the file containing it was closed
  event = { 'BufEnter' },
  command = function()
    if fn.winnr('$') == 1 and vim.bo.buftype == 'quickfix' then api.nvim_buf_delete(0, { force = true }) end
  end,
}, {
  -- automatically close corresponding loclist when quitting a window
  event = { 'QuitPre' },
  nested = true,
  command = function()
    if vim.bo.filetype ~= 'qf' then vim.cmd.lclose({ mods = { silent = true } }) end
  end,
}, {
  -- Close the editor if the buffer being closed is the last buffer
  event = { 'BufDelete' },
  command = function(args)
    -- Get the number of listed buffers
    local listed_buffers = vim.tbl_filter(function(buf) return api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted end, api.nvim_list_bufs())

    -- Check if the buffer being deleted is the last listed buffer
    if #listed_buffers == 1 and vim.bo[args.buf].buflisted then vim.cmd('qa') end
  end,
})

local excluded_filetypes = {
  'trouble',
  'toggleterm',
}

ky.augroup('Resize Windows', {
  event = { 'WinEnter' },
  command = function()
    local win_config = vim.api.nvim_win_get_config(0)

    -- List of filetypes to ignore
    local ignore_filetypes = { 'neo-tree', 'trouble', 'toggleterm', 'quickfix' }

    -- Get the current buffer's filetype
    local filetype = vim.bo.filetype

    -- Check if the current window is floating or if the filetype is in the ignore list
    if win_config.relative == '' and not vim.tbl_contains(ignore_filetypes, filetype) then
      local win_count = vim.fn.winnr('$')
      if win_count > 1 then -- Check if there's more than one window
        -- Calculate 2/3 of the total lines available in the editor, accounting for cmdheight
        local target_height = math.floor((vim.o.lines - vim.o.cmdheight) * 0.60)
        if vim.fn.winheight(0) < target_height then
          vim.cmd('resize ' .. target_height) -- vim.cmd('normal! zz')
        end
      end
    end
  end,
})

-- Buffer behavior on enter
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

-- Close specific buffers with "q"
create_autocmd('FileType', {
  pattern = { 'Trouble', 'neo-tree', 'help', 'dashboard', 'nui-menu', 'aerial' },
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

create_autocmd('BufWritePost', {
  pattern = 'dunstrc',
  callback = function()
    vim.fn.system('silent !killall dunst')
    vim.notify('Restarted', 'info', { title = 'dunstrc' })
  end,
})

create_autocmd('BufWritePost', {
  pattern = 'sxhkdrc',
  callback = function()
    vim.fn.system('pkill -USR1 -x sxhkd')
    vim.notify('Restarted', 'info', { title = 'sxhkdrc' })
  end,
})
