local opt, hl = vim.opt_local, ky.hl

opt.wrap = true
opt.conceallevel = 2
opt.concealcursor = 'nc'
opt.formatoptions:append('t')
opt.formatoptions:append('c')
opt.formatoptions:append('q')
opt.linebreak = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.expandtab = true
opt.spelllang = 'en_us'

keymap('i', '<C-t>', '<c-o>:norm <C-t>$<cr>', { noremap = false, buffer = true })
keymap('i', '<C-c>', '<C-g>u<Esc>[s1z=`]a<C-g>u', { buffer = true })
keymap('i', '<C-l>', '<cmd>ObsidianSearch<cr>', { noremap = false, buffer = true })

keymap('n', '<C-a>', 'zg', { buffer = true })

hl.all({
  -- Headers
  { RenderMarkdownH1 = { fg = { from = 'Keyword' }, bold = true } },
  { RenderMarkdownH2 = { fg = { from = 'Function' }, bold = true } },
  { RenderMarkdownH3 = { fg = { from = 'Type' }, bold = true } },
  { RenderMarkdownH4 = { fg = { from = 'Constant' }, bold = true } },
  { RenderMarkdownH5 = { fg = { from = 'Special' }, bold = true } },
  { RenderMarkdownH6 = { fg = { from = 'String' }, bold = true } },

  -- Header backgrounds
  { RenderMarkdownH1Bg = { bg = 'NONE', reverse = false } },
  { RenderMarkdownH2Bg = { bg = 'NONE', reverse = false } },
  { RenderMarkdownH3Bg = { bg = 'NONE', reverse = false } },
  { RenderMarkdownH4Bg = { bg = 'NONE', reverse = false } },
  { RenderMarkdownH5Bg = { bg = 'NONE', reverse = false } },
  { RenderMarkdownH6Bg = { bg = 'NONE', reverse = false } },

  -- Code blocks
  { RenderMarkdownCode = { bg = { from = 'Normal' } } },
  { RenderMarkdownCodeBorder = { fg = { from = 'Comment' } } },
  { RenderMarkdownCodeFallback = { fg = { from = 'Comment' } } },
  { RenderMarkdownCodeInline = { bg = { from = 'Normal', alter = -0.08 }, fg = { from = 'String' } } },
  { RenderMarkdownInlineHighlight = { fg = { from = 'Macro' } } },

  -- List and formatting elements
  { RenderMarkdownBullet = { fg = { from = 'Statement' } } },
  { RenderMarkdownQuote = { fg = { from = 'Comment', alter = 0.2 }, italic = true } },
  { RenderMarkdownDash = { fg = { from = 'Comment' } } },
  { RenderMarkdownSign = { fg = { from = 'Comment' } } },
  { RenderMarkdownMath = { fg = { from = 'Number' } } },
  { RenderMarkdownIndent = { fg = { from = 'Comment', alter = -0.2 } } },
  { RenderMarkdownHtmlComment = { fg = { from = 'Comment' }, italic = true } },

  -- Links
  { RenderMarkdownLink = { fg = { from = 'Identifier' }, underline = true } },
  { RenderMarkdownWikiLink = { fg = { from = 'Identifier' }, bold = true } },

  -- Checkboxes
  { RenderMarkdownUnchecked = { fg = { from = 'Comment' } } },
  { RenderMarkdownChecked = { fg = { from = 'String' } } },
  { RenderMarkdownTodo = { fg = { from = 'Todo' } } },

  -- Tables
  { RenderMarkdownTableHead = { fg = { from = 'Function' }, bold = true } },
  { RenderMarkdownTableRow = { fg = { from = 'Normal' } } },
  { RenderMarkdownTableFill = { fg = { from = 'Comment', alter = -0.4 } } },

  -- Callouts
  { RenderMarkdownSuccess = { fg = { from = 'DiagnosticOk' } } },
  { RenderMarkdownInfo = { fg = { from = 'DiagnosticInfo' } } },
  { RenderMarkdownHint = { fg = { from = 'DiagnosticHint' } } },
  { RenderMarkdownWarn = { fg = { from = 'DiagnosticWarn' } } },
  { RenderMarkdownError = { fg = { from = 'DiagnosticError' } } },
})
