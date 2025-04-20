ky.ui.icons = {
  mini = {
    default = {
      directory = { glyph = '󰉋', hl = 'Directory' },
      file = { glyph = '', hl = 'MiniIconsBlue' },
    },

    directory = {
      ui = { glyph = '󱞊', hl = 'MiniIconsPurple' },
      public = { glyph = '󱞊', hl = 'MiniIconsBlue' },
      config = { glyph = '󱁿', hl = 'MiniIconsYellow' },
      ['.avante_chat_history'] = { glyph = '', hl = 'MiniIconsGrey' },

      -- Notes
      ['Journal'] = { glyph = '󰗚', hl = 'MiniIconsYellow' },
      ['Trash'] = { glyph = '', hl = 'MiniIconsGrey' },
    },

    file = {
      ['.gitignore'] = { glyph = '', hl = 'MiniIconsGrey' },
      ['pnpm-lock.yaml'] = { glyph = '', hl = 'MiniIconsGreen' },
      ['README.md'] = { glyph = '', hl = 'MiniIconsBlue' },
      ['init.lua'] = { glyph = '', hl = 'MiniIconsGreen' },
      ['tailwind.config.ts'] = { glyph = '󱏿', hl = 'MiniIconsBlue' },
      ['kitty.conf'] = { glyph = '󰄛', hl = 'MiniIconsGreen' },
      ['.env'] = { glyph = '', hl = 'MiniIconsGrey' },
      ['.env.local'] = { glyph = '', hl = 'MiniIconsGrey' },

      -- Notes
      ['Dreams.md'] = { glyph = '', hl = 'MiniIconsBlue' },
      ['Ideas.md'] = { glyph = '', hl = 'MiniIconsBlue' },
      ['Thoughts.md'] = { glyph = '', hl = 'MiniIconsBlue' },
      ['Quotes.md'] = { glyph = '󰯃', hl = 'MiniIconsBlue' },
    },

    filetype = {
      bash = { glyph = '', hl = 'MiniIconsGreen' },
      markdown = { glyph = '󰈚', hl = 'MiniIconsBlue' },
      csv = { glyph = '', hl = 'MiniIconsGreen' },
      pdf = { glyph = '', hl = 'MiniIconsGreen' },
      sh = { glyph = '', hl = 'MiniIconsGreen' },
      xmodmap = { glyph = '', hl = 'MiniIconsCyan' },
      xinitrc = { glyph = '󰨇', hl = 'MiniIconsBlue' },
      python = { glyph = '', hl = 'MiniIconsYellow' },
      zsh = { glyph = '', hl = 'MiniIconsGreen' },
    },

    extension = {
      ['js'] = { glyph = '', hl = 'MiniIconsYellow' },
      ['ts'] = { glyph = '', hl = 'MiniIconsBlue' },
      ['tsx'] = { glyph = '󰜈', hl = 'MiniIconsBlue' },
      ['norg'] = { glyph = '󱇨', hl = 'MiniIconsPurple' },
      ['jpg'] = { glyph = '', hl = 'MiniIconsBlue' },
      ['png'] = { glyph = '', hl = 'MiniIconsGreen' },
      ['mp4'] = { glyph = '', hl = 'MiniIconsPurple' },
      ['ttf'] = { glyph = '', hl = 'MiniIconsPurple' },
      ['zip'] = { glyph = '', hl = 'MiniIconsYellow' },
    },
  },

  completion = {
    Text = ' 󰦨 ',
    Method = ' 󰆧 ',
    Function = ' 󰊕 ',
    Constructor = '  ',
    Field = ' 󰜢 ',
    Variable = ' 󰀫 ',
    Class = ' 󰠱 ',
    Interface = '  ',
    Module = '  ',
    Property = ' 󰜢 ',
    Unit = ' 󰑭 ',
    Value = '  ',
    Enum = '  ',
    Keyword = ' 󰌋 ',
    Snippet = ' 󰈮 ',
    Color = ' 󰏘 ',
    File = ' 󰈙 ',
    Reference = ' 󰈇 ',
    Folder = ' 󰉋 ',
    EnumMember = '  ',
    Constant = ' 󰏿 ',
    Struct = ' 󰙅 ',
    Event = '  ',
    Operator = ' 󰆕 ',
    TypeParameter = '  ',
    Copilot = '  ',
  },

  -- Diagnostics icons
  diagnostics = {
    ERROR = '',
    WARN = '',
    HINT = '',
    INFO = '',
  },

  -- Neotree specific icons
  neo_tree = {
    git = {
      add = '',
      modified = '',
      deleted = '',
      staged = '',
      rename = '',
    },
    folders = {
      closed = '',
      open = '',
      empty = '󰉖',
      empty_open = '󰷏',
    },
    indent_marker = '│',
    last_indent_marker = '└',
  },

  separators = {
    left_thin_block = '▏',
    right_thin_block = '▕',
  },

  lsp = {
    error = ' ',
    warn = ' ',
    info = ' ',
    hint = ' ',
  },

  git = {
    add = ' ', --    
    mod = ' ', --  
    remove = ' ', --    
  },

  documents = {
    file = '',
    files = '',
    folder = '',
    open_folder = '',
  },

  misc = {
    fzf = '   ',
    readonly = ' ',
    none = '',
    pointer = '➤',
    search = ' ',
    git = '',
    vertical_bar = '▍',
    plus = '',
    ellipsis = '…',
    up = '⇡',
    down = '⇣',
    -- line = '', -- 'ℓ'
    line = 'Ξ', -- 'ℓ'
    indent = 'Ξ',
    tab = '⇥',
    bug = '', --  '󰠭'
    question = '',
    clock = '',
    lock = '',
    shaded_lock = '',
    circle = '',
    project = '',
    dashboard = '',
    history = '󰄉',
    comment = '󰅺',
    robot = '󰚩',
    lightbulb = '󰌵',
    code = '',
    telescope = '',
    gear = '',
    package = '',
    list = '',
    sign_in = '',
    check = '󰄬',
    fire = '',
    note = '󰎞',
    bookmark = '',
    pencil = '', -- '󰏫',
    tools = '',
    arrow_right = '',
    caret_right = '',
    chevron_right = '',
    double_chevron_right = '»',
    table = '',
    calendar = '',
    block = '▌',
    separator = ' ',
  },
}
