local get_visual_selection = require('utils.commands.get_visual_selection')

local whichkey = require('which-key')
local pickers = require('config.telescope.pickers')

local row = function()
  local height = vim.api.nvim_win_get_height(0)
  local offset = 2
  return height - offset
end

whichkey.setup({
  preset = 'modern',
  icons = {
    breadcrumb = '»',
    separator = '',
    group = '',
  },
  win = {
    col = 0,
    row = tonumber(row),
    title = false,
    width = vim.o.columns * 0.6,
  },
  show_help = false,
  show_keys = false,
})

local function rg_search_cword()
  local cword = vim.fn.expand('<cword>')
  local rg_cmd = 'rg --vimgrep --glob "!node_modules" --glob "!project" --glob "!.cache" --glob "!.git" ' .. cword
  local result = vim.fn.systemlist(rg_cmd)
  if vim.v.shell_error ~= 0 then
    print('Ripgrep command failed: ' .. table.concat(result, '\n'))
    return
  end
  -- Hide default quickfix list
  vim.fn.setqflist({}, 'r', { title = 'Ripgrep Results', lines = result })
  vim.cmd('Trouble quickfix focus=true')
end

local function v_rg_search_cword(selection)
  local rg_cmd = 'rg --vimgrep --glob "!node_modules" --glob "!.cache" --glob "!.git" ' .. selection
  local result = vim.fn.systemlist(rg_cmd)

  if #result == 1 then
    vim.notify('No results found')
    return
  end

  if vim.v.shell_error ~= 0 then
    print('Ripgrep command failed: ' .. table.concat(result, '\n'))
    return
  end

  vim.cmd('Trouble quickfix focus=true')
end

whichkey.add({
  { icon = '', group = 'leader', '<leader>' },
  { icon = '', group = 'cr', '<cr>' },

  -- [ AI Completion ] -------------------
  { icon = '', group = '  AI', '<leader>a' },
  { icon = '󰆈', desc = ' Ask (avante.nvim)', '<leader>aa', '<cmd>AvanteAsk<cr>', mode = 'n' },
  { icon = '󰂽', desc = ' Open Window (avante.nvim)', '<leader>ao', '<cmd>AvanteAsk<cr>', mode = 'n' },
  { icon = '', desc = ' Toggle Inlay Hints (avante.nvim)', '<leader>ah', noremap = false, mode = 'n' },
  { icon = '', desc = ' Toggle Debug (avante.nvim)', '<leader>ad', noremap = false, mode = 'n' },
  { icon = '', desc = ' Refresh (avante.nvim)', '<leader>ar', noremap = false, mode = 'n' },
  { icon = '', desc = ' Toggle (avante.nvim)', '<leader>at', noremap = false, mode = 'n' },
  { icon = '', desc = ' Edit Code Block (avante.nvim)', '<leader>ae', noremap = false, mode = 'n' },

  -- [ Editor ]
  { icon = '', group = '  Editor', '<leader>e' },
  { icon = '', desc = 'zen mode', '<leader>ez', ':ZenMode<cr>', mode = 'n' },

  -- [ Yazi ]
  { icon = '', group = '  File Broswer', '<leader>.' },
  { icon = '', desc = 'Open file broswer at the current file', '<leader>..', '<cmd>Yazi<cr>', mode = 'n' },
  { icon = '', desc = "Open the file manager in nvim's working directory", '<leader>.o', '<cmd>Yazi cwd<cr>', mode = 'n' },
  { icon = '', desc = 'Resume the last session', '<leader>.r', '<cmd>Yazi toggle<cr>', mode = 'n' },

  -- [ Find files ] -------------------
  { icon = '', group = '  Find', '<leader>f' },
  { icon = '', desc = 'file', '<leader>ff', '<cmd>Telescope find_files<cr>', mode = 'n' },
  { icon = '', desc = 'grep', '<leader>fg', '<cmd>Telescope live_grep<cr>', mode = 'n' },
  { icon = '', desc = 'symbol', '<leader>fs', '<cmd>Telescope lsp_workspace_symbols<cr>', mode = 'n' },
  { icon = '', desc = 'word', '<leader>fw', rg_search_cword, mode = 'n' },
  { icon = '', desc = 'word', '<leader>fw', function() v_rg_search_cword(get_visual_selection()) end, mode = 'v' },
  { icon = '', desc = 'quickfix', '<leader>fq', '<cmd>Trouble quickfix focus=true<cr>', mode = 'n' },

  -- [ Buffers ] -------------------
  { icon = '', group = '  Buffers', '<leader>b' },
  { icon = '', desc = 'Pin', '<leader>bp', '<cmd>BufferLineTogglePin<cr>', mode = 'n' },
  { icon = '', desc = 'Yank', '<leader>by', ':silent %y+<cr>', mode = 'n' },

  -- [ Open files ] -------------------
  { icon = '', group = '󱇨  Open', '<leader>o' },
  { icon = '', desc = 'explorer', '<leader>oe', ':silent !nemo & %<cr>', mode = 'n' },
  { icon = '', desc = 'projects', '<leader>op', ':lua require("telescope").extensions.project.project()<cr>', mode = 'n' },

  -- [ Rewrite ] -------------------
  { icon = '', group = '  Rewrite', '<leader>r' },
  {
    icon = '',
    desc = 'word',
    '<leader>rw',
    function() require('live-rename').rename({ insert = true, text = vim.fn.expand('<cword>') }) end,
    mode = 'n',
    silent = false,
  },

  -- [ LSP ] -------------------
  { icon = '', group = '  LSP', '<leader>l' },
  {
    icon = '',
    desc = 'diagnostics',
    '<leader>ld',
    function()
      require('trouble').toggle({
        auto_preview = true,
        mode = 'diagnostics',
        filter = { buf = 0 },
        icons = {
          indent = { top = '', middle = '', last = '' },
        },
        focus = true,
      })
    end,
    mode = 'n',
  },

  -- [ Dotfiles ] -------------------
  { icon = '', group = 'dotfiles', '<leader>od' },
  { icon = '', desc = '.kitty', '<leader>odk', ':silent e ~/.config/kitty/kitty.conf<cr>', mode = 'n' },
  { icon = '', desc = '.nvim', '<leader>odn', function() pickers.open({ picker = 'find_files', options = { cwd = '~/.config/nvim' } }) end, mode = 'n' },
  { icon = '', desc = '.eww', '<leader>ode', ':Telescope find_files cwd=~/.config/eww<cr>', mode = 'n' },
  { icon = '', desc = '.rofi', '<leader>odr', ':Telescope find_files cwd=~/.config/rofi<cr>', mode = 'n' },
  { icon = '', desc = '.sxhkd', '<leader>ods', ':silent e ~/.config/sxhkd/sxhkdrc<cr>', mode = 'n' },
  { icon = '', desc = '.bspwm', '<leader>odb', ':Telescope find_files cwd=~/.config/bspwm<cr>', mode = 'n' },
  { icon = '', desc = '.yazi', '<leader>ody', ':Telescope find_files cwd=~/.config/yazi<cr>', mode = 'n' },
  { icon = '', desc = '.picom', '<leader>odc', ':silent e ~/.config/picom/picom.conf<cr>', mode = 'n' },
  { icon = '', desc = '.zshrc', '<leader>odz', ':silent e ~/.zshrc<cr>', mode = 'n' },

  -- [ Git, Source Control ] -------------------
  { icon = '', group = '  Git', '<leader>g' },
  { icon = '', desc = 'Lazy git', '<leader>gl', function() editor.terminals.lazygit_toggle() end, mode = 'n' },
  { icon = '', desc = 'Blame line', '<leader>gb', '<cmd>Gitsigns blame_line<cr>', mode = 'n' },
  { icon = '', desc = 'Stage hunk', '<leader>gs', '<cmd>Gitsigns stage_hunk<cr>', mode = 'n' },
  { icon = '', desc = 'Stage selected hunk', '<leader>gs', '<cmd>Gitsigns stage_hunk<cr>', mode = 'v' },
  { icon = '', desc = 'Undo stage hunk', '<leader>gu', '<cmd>Gitsigns undo_stage_hunk<cr>', mode = 'n' },
  { icon = '', desc = 'Reset hunk', '<leader>gr', '<cmd>Gitsigns reset_hunk<cr>', mode = 'n' },
  { icon = '', desc = 'Reset selected hunk', '<leader>gr', '<cmd>Gitsigns reset_hunk<cr>', mode = 'v' },
  { icon = '', desc = 'Next hunk', '<leader>gn', '<cmd>Gitsigns next_hunk<cr>', mode = 'n' },
  { icon = '', desc = 'Prev hunk', '<leader>gp', '<cmd>Gitsigns prev_hunk<cr>', mode = 'n' },
  { icon = '', desc = 'Preview hunk', '<leader>gh', '<cmd>Gitsigns preview_hunk<cr>', mode = 'n' },
  { icon = '', desc = 'Reset buffer', '<leader>gR', '<cmd>Gitsigns reset_buffer<cr>', mode = 'n' },
  { icon = '', desc = 'Stage buffer', '<leader>gS', '<cmd>Gitsigns stage_buffer<cr>', mode = 'n' },
  { icon = '', desc = 'Refresh', '<leader>g<leader>', '<cmd>Gitsigns refresh<cr>', mode = 'n' },

  -- [ Quick Acrions, Frequently used ] -------------------
  { icon = '', desc = 'open recent', '<cr>r', function() pickers.open({ hidden = true, picker = 'oldfiles' }) end, mode = 'n' },
  { icon = '', desc = 'diagnostics', '<cr>d', ':Trouble diagnostics focus=true<cr>', mode = 'n' },
  { icon = '', desc = 'toggle quickfix', '<cr>q', function() require('trouble').toggle({ mode = 'quickfix', focus = true }) end, mode = 'n' },
  -- { icon = '', desc = 'quickfix add', '<cr>a', function() end, mode = 'n' },
  { icon = '', desc = 'open help', '<cr>h', ':Telescope help_tags<cr>', mode = 'n' },
  { icon = '', desc = 'find word', '<cr>w', rg_search_cword, mode = 'n' },
})
