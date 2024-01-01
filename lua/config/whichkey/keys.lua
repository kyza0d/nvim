local M = {}

local pickers = require('config.telescope.pickers')

local find = {
  name = '  Find',
  f = { '<cmd>Telescope find_files<cr>', '  Files' },
  r = { '<cmd>Telescope oldfiles<cr>', '  Recent Files' },
  g = { '<cmd>Telescope live_grep<cr>', '  Grep' },
  b = { '<cmd>Telescope buffers<cr>', '  Buffers' },
  h = { '<cmd>Telescope highlights<cr>', '󰸌  Highlights' },
  w = { '<cmd>Telescope live_grep<cr>', '  Word' },
}

local open_files = {
  name = '  Open Files',
  s = { '<cmd>lua require("scratch").open_buffer()<cr>', 'Scratch File' },
  r = { '<cmd>lua require("telescope.builtin").find_files()<cr>', 'Recent File' },
  t = { '<cmd>ToggleTerm<cr>', '  Previous Terminal' },
  ['1'] = { '<cmd>ToggleTerm<cr>', '  Previous Terminal' },
  d = {
    name = '  Dotfiles',
    -- n = { ':Telescope find_files cwd=~/.config/nvim/<cr>', '  .nvim' },
    n = {
      function() pickers.prettyFilesPicker({ picker = 'find_files', options = { cwd = '~/.config/nvim/' } }) end,
      '  .nvim',
    },
    p = { ':silent e ~/.config/polybar/config.ini<cr>', '  .polybar' },
    c = { ':silent e ~/.config/picom/picom.conf<cr>', '  .picom' },
    q = { ':silent e ~/.config/qutebrowser/config.py<cr>', '  .qutebrowser' },
    b = { ':silent e ~/.config/bspwm/bspwmrc<cr>', '󰟀  .bspwmrc' },
    d = { ':silent e ~/.config/dunst/dunstrc<cr>', '  .dunst' },
    x = { ':silent e ~/.xprofile<cr>', '  .xprofile' },
    z = { ':silent e ~/.zshrc<cr>', '  .zsh' },
    s = { ':silent e ~/.config/sxhkd/sxhkdrc<cr>', '  .sxhkd' },
    r = { ':silent e ~/.config/rofi/config.rasi<cr>', '  .rofi' },
    k = { ':silent e ~/.config/kitty/kitty.conf<cr>', '  .kitty' },
    l = { ':silent e ~/.config/lsd/config.yaml<cr>', '  .lsd' },
  },
}
local custom_commands = {
  name = '  Commands',
  ['n'] = {
    function() ky.custom_menus.redir() end,
    'Read command into buffer',
  },
}

local git_actions = {
  name = '󰊢  Git',
  ['i'] = { function() editor.terminal.lazygit_toggle() end, '  Info' },
  r = {
    name = '  Reset',
    ['h'] = { ':Gitsigns reset_hunk<cr>', '  Hunk' },
    ['b'] = { ':Gitsigns reset_buffer<cr>', '  Buffer' },
  },
  a = {
    name = '  Add',
    ['h'] = { ':Gitsigns stage_hunk<cr>', '  Hunk' },
    ['b'] = { ':Gitsigns stage_buffer<cr>', '  Buffer' },
  },
  -- s = {
  --   name
  -- }
  b = {
    name = '  Branch',
    ['s'] = { '<cmd>Telescope git_branches<cr>', '  Switch' },
    ['p'] = { ':GitPush<cr>', '  Push to GitHub' },
    ['l'] = { ':GitPull<cr>', '  Pull from GitHub' },
  },
  c = {
    name = '  Commit',
    c = { "<cmd>lua require('neogit').open({ 'commit' })<cr>", '󱓏  Commit' },
  },
}

local lsp_server_actions = {
  name = '  Server Actions',
  -- TODO: Finish this
}

local code_management = {
  name = '  Code',
  s = { '<cmd>', '  Snippets' },
  a = { ky.custom_menus.code_action, '  Actions' },
  r = { '<cmd>', '  Refactor' },
  l = { '<cmd>', '󰃢  Lint' },
  d = { '<cmd>', '  Debug' },
}

local integrations = {
  name = '  Tools',
  d = { '<cmd>', '  Docker' },
  b = { '<cmd>', '  DB' },
  a = { '<cmd>', '  API' },
}

local rewrite = {
  name = '  Rewrite',
  n = {
    function() return ':IncRename ' .. vim.fn.expand('<cword>') end,
    '  Name',
    silent = false,
    expr = true,
  },
}

local diagnostics_active = true

local editor = {
  name = '  Editor',
  q = { '<cmd>qa<cr>', '󰅚  Quit Editor' },
  c = { '<cmd>nohlsearch<cr>', '  Colorscheme' },
  v = { '<cmd>vsplit<cr>', '  Vertical Split' },
  x = { '<cmd>split<cr>', '  Horizontal Split' },
  z = {
    function()
      editor.zen_mode = not editor.zen_mode
      require('barbecue.ui').toggle()

      -- Settings for Zen mode
      if editor.zen_mode then
        vim.opt.showtabline = 0
        vim.opt.foldcolumn = '0'
        vim.opt.foldenable = false
        vim.opt.laststatus = 0
        vim.opt.number = false
        vim.opt.statuscolumn = '  '
        vim.opt.signcolumn = 'no'
        vim.opt.cmdheight = 0
      else
        local original_options = require('options')
        for option, value in pairs(original_options) do
          vim.opt[option] = value
        end
      end
    end,
    '  Zen Mode ',
  },
  p = {
    name = '  Preferences',

    -- TODO: grab from editor options to have these desplayed with correct values.
    w = { function() require('barbecue.ui').toggle() end, '  Winbar' },
    i = { '<cmd>IndentBlanklineToggle<cr>', '  Toggle Indent Lines' }, -- Requires indent-blankline plugin
    d = {
      function()
        diagnostics_active = not diagnostics_active
        if diagnostics_active then
          vim.diagnostic.show()
        else
          vim.diagnostic.hide()
        end
      end,
      '  Toggle Diagnostics',
    },
    s = {
      function()
        editor.status_line = not editor.status_line
        -- Write code here
      end,
      '  Toggle Statusline',
    },
  }, -- Requires Telescope and Project plugin
  u = { '<cmd>UndotreeToggle<cr>', '  Undo Tree' }, -- Requires undotree plugin
  j = { '<cmd>Telescope file_browser<cr>', '  File Browser' }, -- Requires Telescope file browser extension
  k = { '<cmd>Telescope keymaps<cr>', '  Keymaps' }, -- Requires Telescope plugin
  m = { '<cmd>Telescope marks<cr>', '  Marks' }, -- Requires Telescope plugin
  t = { '<cmd>tabnew<cr>', '  New Tab' },
}

local buffers = {
  name = '  Buffers',
  n = { '<cmd>enew<cr>', '  New Buffer' },
  l = { '<cmd>Telescope buffers<cr>', '  List Buffers' },
  d = { '<cmd>bdelete<cr>', '  Delete Buffer' },
  w = { '<cmd>bwipeout<cr>', '  Wipeout Buffer' },
  y = { '<cmd>silent %y+<cr>', '  Yank Contents' },
  p = { '<cmd>BufferLineTogglePin<cr>', '  Pin Buffer' },
}

M.leader = {
  [':'] = custom_commands,
  ['?'] = lsp_server_actions,
  s = find,
  b = buffers,
  o = open_files,
  g = git_actions,
  c = code_management,
  e = editor,
  i = integrations,
  r = rewrite,
}

M.cr = {
  s = {
    function() require('telescope.builtin').lsp_dynamic_workspace_symbols({}) end,
    'Workspace Symbols',
  },
  h = { '<cmd>Telescope help_tags<cr>', 'Search' },
  b = { '<cmd>Telescope buffers<cr>', 'Buffers' },
  d = { '<cmd>Trouble document_diagnostics<cr>', 'Diagnostics' },
  w = { ':w!<cr>', 'Write buffer' },
  -- r = { '<cmd>Telescope oldfiles<cr>', 'recent' },
  r = { function() pickers.prettyFilesPicker({ picker = 'oldfiles' }) end, 'recent' },
  g = { '<cmd>Telescope live_grep<cr>', 'ripgrep' },
}

M.cr_vi = {
  -- preform :g command on visual selection
}

return M
