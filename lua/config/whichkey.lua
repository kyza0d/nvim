local fzf_lua = reqcall('fzf-lua')
local file_picker = function(cwd) fzf_lua.files({ cwd = cwd }) end

require('which-key').add({
  { icon = ' ', group = 'Find', '<leader>f' },
  { icon = ' ', group = 'Dotfiles', '<leader>fd' },
  { icon = ' ', group = 'Git', '<leader>fg' },
  { icon = ' ', group = 'Buffers', '<leader>b' },
  { icon = ' ', group = 'Workspace', '<leader>w' },
  { icon = '󰐻 ', group = 'LSP', '<leader>l' },
  { icon = ' ', group = 'Git', '<leader>g' },
  { icon = ' ', group = 'Edit', '<leader>e' },
  { icon = ' ', group = 'Snippets', '<leader>es' },
  { icon = ' ', group = 'Notes', '<cr>n' },
  { icon = ' ', group = 'Log', '<cr>l' },
})

reqcall('which-key').add({
  { icon = '', desc = 'Files', '<C-f>', function() fzf_lua.files() end },
  { icon = '', desc = 'Live Grep', '<C-Space>', function() fzf_lua.live_grep() end },
  { icon = '󰌵', desc = 'Code Actions', '<C-.>', fzf_lua.lsp_code_actions },

  { icon = '', desc = 'Highlights', '<leader>fh', function() fzf_lua.highlights() end },
  { icon = '', desc = 'Fzf Menu', '<leader>fa', '<cmd>FzfLua<cr>' },
  { icon = '', desc = 'Buffer Grep', '<leader>fb', function() fzf_lua.grep_curbuf() end },
  { icon = '', desc = 'Notes', '<leader>fn', function() file_picker('/home/kyza/Notes') end },
  { icon = '', desc = 'Help Tags', '<leader>f?', function() fzf_lua.help_tags() end },
  { icon = '', desc = 'Old Files', '<cr>r', function() fzf_lua.oldfiles() end },

  { icon = '', desc = 'Hypr Config', '<leader>fdh', function() file_picker('/home/kyza/.config/hypr') end },
  { icon = '󱙝', desc = 'Ghostty Config', '<leader>fdg', ':e /home/kyza/.config/ghostty/config<cr>' },
  { icon = '', desc = 'Nvim Config', '<leader>fdn', function() file_picker('/home/kyza/.config/nvim') end },
  { icon = '', desc = 'Kitty Config', '<leader>fdk', ':e /home/kyza/.config/kitty/kitty.conf<cr>' },
  { icon = '', desc = 'Zsh Config', '<leader>fdz', ':e /home/kyza/.zshrc<cr>' },

  { icon = '', desc = 'Git Commits', '<leader>fgc', fzf_lua.git_commits },
  { icon = '', desc = 'Git Branches', '<leader>fgb', fzf_lua.git_branches },

  { icon = '', desc = 'Workspace Symbols', '<leader>ws', fzf_lua.lsp_workspace_symbols },
})

reqcall('which-key').add({
  { icon = ' ', '<leader>ff', '<cmd>Telescope find_files<cr>' },
})

reqcall('which-key').add({
  { icon = ' ', desc = 'Buffer Diagnostics', '<cr>d', '<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>' },
  { icon = '󰥩 ', desc = 'Workspace Diagnostics', '<cr>d', '<cmd>Trouble diagnostics toggle focus=true<cr>' },
  { icon = ' ', desc = 'Workspace Symbols ', '<cr>s', '<cmd>Trouble symbols toggle focus=true<cr>' },
  { icon = '󰙅 ', desc = 'Symbols Outline', '<leader>lo', '<cmd>Trouble symbols toggle focus=true<cr>' },
  { icon = ' ', desc = 'References', '<leader>lr', '<cmd>Trouble lsp_references toggle focus=true<cr>' },
})

reqcall('which-key').add({
  {
    icon = ' ',
    '<leader>cx',
    function() require('utils.helpers').redir_to_buffer('highlight', 'Highlight Groups') end,
  },
})

reqcall('which-key').add({
  { icon = '󰐃', desc = 'Pin/Unpin Buffer', '<leader>bp', '<cmd>BufferLineTogglePin<cr>', mode = 'n' },
  { icon = '󱉬', desc = 'Yank Buffer Content', '<leader>by', ':silent %y+<cr>', mode = 'n' },
  {
    icon = '󰜢',
    desc = 'Yank Relative Path',
    '<leader>br',
    ':let @+ = system("git rev-parse --show-toplevel") . "/" . expand("%")<cr>',
    mode = 'n',
  },
  { icon = '󰳻', desc = 'Write Buffer', '<leader>bw', '<cmd>noautocmd silent! w<cr>', mode = 'n' },
})

reqcall('which-key').add({
  {
    icon = '',
    '<leader>esa',
    '<cmd>lua require("scissors").addNewSnippet()<CR>',
    desc = 'Add new snippet',
    nowait = false,
    remap = false,
  },
  {
    icon = '󰲶',
    '<leader>ese',
    '<cmd>lua require("scissors").editSnippet()<CR>',
    desc = 'Edit snippet',
    nowait = false,
    remap = false,
  },
})

reqcall('which-key').add({
  { icon = ' ', desc = 'Focus.md', '<cr><cr>', '<cmd>e ~/Notes/Focus.md<cr>' },
  { icon = ' ', desc = 'Open Daily', '<cr>nd', '<cmd>Obsidian today<cr>' },
  { icon = ' ', desc = 'Search', '<cr>ng', '<Cmd>Obsidian search<CR>' },
  { icon = ' ', desc = 'Find', '<cr>nf', '<Cmd>Obsidian quickswitch<CR>' },
  { icon = '󱞳 ', desc = 'Open Daily (Yesterday)', '<cr>n,', '<cmd>Obsidian yesterday<cr>' },
  { icon = '󱞫 ', desc = 'Open Daily (Tomorrow)', '<cr>n.', '<cmd>Obsidian tomorrow<cr>' },
  { icon = ' ', desc = 'Entry', '<cr>le', function() helpers.create_journal_entry('Entries/') end },
  { icon = ' ', desc = 'Reflection', '<cr>lr', function() helpers.create_journal_entry('Reflections/') end },

  { icon = ' ', desc = 'Idea', '<cr>li', '<cmd>e ~/Notes/2025/Logs/Ideas.md<cr>' },
  { icon = ' ', desc = 'Dream', '<cr>ld', '<cmd>e ~/Notes/2025/Logs/Dreams.md<cr>' },
  { icon = '󰟶 ', desc = 'Thought', '<cr>lt', '<cmd>e ~/Notes/2025/Logs/Thoughts.md<cr>' },
  { icon = '󰯃 ', desc = 'Quote', '<cr>lq', '<cmd>e ~/Notes/2025/Logs/Quotes.md<cr>' },
})

reqcall('which-key').add({
  { icon = '󰊢 ', desc = 'Neogit', '<leader><leader>', '<cmd>Neogit<cr>' },
  { icon = ' ', desc = 'Commit', '<leader>gc', '<cmd>Neogit commit<cr>' },
  { icon = '󰏕 ', desc = 'Push', '<leader>gp', '<cmd>Neogit push<cr>' },
  { icon = '󰏔 ', desc = 'Pull', '<leader>gl', '<cmd>Neogit pull<cr>' },
  { icon = '󰋚 ', desc = 'Log', '<leader>gL', '<cmd>Neogit log<cr>' },
})

reqcall('which-key').add({
  { icon = ' ', desc = 'Git', '<cr>g' },
  { icon = '󰊢 ', desc = 'Stage ', '<cr>gs', '<cmd>Gitsigns stage_hunk<cr>' },
  { icon = '󰕌 ', desc = 'Undo', '<cr>gu', '<cmd>Gitsigns undo_stage_hunk<cr>' },
  { icon = '󰕍 ', desc = 'Reset', '<cr>gr', '<cmd>Gitsigns reset_hunk<cr>' },
  { icon = ' ', desc = 'Reset', '<cr>gR', '<cmd>Gitsigns reset_buffer<cr>' },
  { icon = ' ', desc = 'Prview', '<cr>gp', '<cmd>Gitsigns preview_hunk<cr>' },
})

reqcall('which-key').add({
  { icon = ' ', desc = 'Replace', '<leader>wr', '<cmd>GrugFar<cr>' },
})
