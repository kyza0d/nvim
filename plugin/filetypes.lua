if not ky then return end
local settings, highlight = ky.filetype_settings, ky.hl
local cmd = vim.cmd

vim.treesitter.language.register('bash', 'sh')
vim.treesitter.language.register('gitcommit', 'NeogitCommitMessage')
vim.treesitter.language.register('png', 'jpeg')

settings({
  checkhealth = { opt = { spell = false } },
  [{ 'kitty' }] = {
    opt = {
      commentstring = '# %s',
    },
  },
  [{ 'norg' }] = {
    opt = {
      signcolumn = 'no',
      number = false,
      cursorline = false,
      statuscolumn = ' ',
    },
  },
  [{ 'norg' }] = {
    bo = {
      commentstring = '#%s',
      shiftwidth = 2,
    },
  },
  [{ 'gitcommit', 'gitrebase' }] = {
    bo = { bufhidden = 'delete' },
    opt = {
      list = false,
      spell = true,
      spelllang = 'en_gb',
    },
  },
  [{ 'Avante', 'AvanteInput' }] = {
    opt = {
      breakindent = false,
      wrap = true,
    },
  },
  ['Neogit*'] = {
    wo = { winbar = '' },
  },
  -- Minimal layout
  [{ 'png', 'jpeg' }] = {
    opt = {
      spell = true,
      number = true,
    },
  },
  NeogitCommitMessage = {
    opt = {
      spell = true,
      spelllang = 'en_gb',
      list = false,
    },
    plugins = {
      cmp = function(cmp)
        cmp.setup.filetype('NeogitCommitMessage', {
          sources = {
            { name = 'git', group_index = 1 },
            { name = 'luasnip', group_index = 1 },
            { name = 'dictionary', group_index = 1 },
            { name = 'spell', group_index = 1 },
            { name = 'buffer', group_index = 2 },
          },
        })
      end,
    },
    function()
      vim.schedule(function()
        -- Schedule this call as highlights are not set correctly if there is not a delay
        highlight.set_winhl('gitcommit', 0, { { VirtColumn = { fg = { from = 'Variable' } } } })
      end)
    end,
  },
  [{ 'javascript', 'javascriptreact' }] = {
    bo = { textwidth = 100 },
  },
  startuptime = {
    function() cmd.wincmd('H') end, -- open startup time to the left
  },
})
