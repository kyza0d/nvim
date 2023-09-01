local group = create_augroup('General', {
  clear = true,
})

-- Source configuration files on save
create_autocmd('BufWritePost', {
  command = 'source %',
  pattern = '*/nvim/lua*',
  group = group,
})

-- create_autocmd('CmdLineEnter', {
--   command = 'set cmdheight=1',
--   group = group,
-- })

-- create_autocmd('CmdLineLeave', {
--   command = 'set cmdheight=1',
--   group = group,
-- })

-- Yank highlighting settings
create_autocmd('InsertEnter', {
  callback = function() vim.api.nvim_cmd({ cmd = 'highlight', args = { 'Cursor', 'guifg=' .. vim.g.color4 } }, {}) end,
  group = group,
})

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

-- Buffer behavior on enter
create_autocmd('BufEnter', {
  callback = function()
    fn_match('.fx', 'silent set filetype=hlsl')
    fn_match('.zshrc', 'silent set ft=bash')
    fn_match('.rasi', 'silent set ft=css')
    fn_match('polybar/config.ini', 'silent set ft=toml')
    fn_match('kitty.conf', 'silent set ft=conf')

    if vim.fn.getbufinfo('%')[1].name == '' then vim.opt.buflisted = false end
  end,
  group = group,
})

-- Buffer behavior on ":w"
create_autocmd('BufWritePost', {
  callback = function()
    fn_match('polybar/config.ini', ":silent !polybar-msg cmd restart && notify-send 'polybar restarted'")
    fn_match('kitty.conf', "silent !kill -SIGUSR1 $(pgrep kitty) && notify-send 'kitty restarted'")
    fn_match('dunstrc', 'silent !killall dunst && notify-send "dunst restarted"')
    fn_match('sxhkd', 'silent !pkill -USR1 -x sxhkd && notify-send "sxhkd Restarted"')
  end,
  group = group,
})

-- Settings for specific filetypes
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

-- Close specific buffers with "q"
create_autocmd('FileType', {
  pattern = { 'Trouble', 'neo-tree', 'help', 'dashboard' },
  command = 'nnoremap <silent> <buffer> q :quit!<cr>',
  group = group,
})

-- Colorscheme cache saving
create_autocmd('ColorScheme', {
  callback = function()
    ky.write_cache('colorscheme', vim.g.colors_name)

    local hl_names = {
      { 'Cursor', { 'guibg=' .. vim.g.color5, 'guifg=' .. vim.g.color0 } },
      { 'CursorIM', { 'guibg=' .. vim.g.color6, 'guifg=' .. vim.g.color0 } },
      { 'lCursor', { 'guibg=' .. vim.g.color3, 'guifg=' .. vim.g.color0 } },
      { 'rCursor', { 'guibg=' .. vim.g.color1, 'guifg=' .. vim.g.color0 } },
    }

    -- Function to apply highlights
    local function apply_highlights(hl_names)
      for _, hl in pairs(hl_names) do
        vim.cmd(string.format('hi %s %s %s', hl[1], hl[2][1], hl[2][2]))
      end
    end

    -- Now we apply the highlights
    apply_highlights(hl_names)

    vim.cmd([[
      set guicursor=n-c:block-Cursor
            \,v:block-CursorIM
            \,i-ci-ve:block-lCursor
            \,r-cr:block-rCursor
            \,o:hor50
            \,sm:block-blinkwait175-blinkoff150-blinkon175
  ]])
  end,
  group = group,
})

-- create_autocmd('VimEnter', {
--   callback = function()
--     if vim.g.neovide then
--       vim.bo.filetype = 'neovide'
--       local Terminal = require('toggleterm.terminal').Terminal
--
--       local _vim_enter = Terminal:new({
--         cmd = 'zsh',
--         direction = 'tab',
--
--         float_opts = {
--           border = 'none',
--         },
--
--         on_open = function(term) vim.api.nvim_command('startinsert') end,
--
--         on_close = function(term) vim.api.nvim_command('stopinsert') end,
--       })
--
--       _vim_enter:toggle()
--     end
--   end,
-- })
--
-- create_autocmd('FileType', {
--   pattern = { 'neovide' },
--   callback = function()
--     local options = {
--       number = false,
--     }
--
--     for k, v in pairs(options) do
--       vim.opt_local[k] = v
--     end
--   end,
-- })
