return {
  plugins = {
    spelling = {
      enabled = false,
      suggestions = 10,
    },
    presets = {
      operators = false,
      motions = false,
      text_objects = false,
      windows = false,
      nav = false,
      z = false,
      g = false,
    },
  },
  icons = { breadcrumb = '', separator = '', group = '' },
  window = {
    margin = { 1, 0, 1, 0 },
    padding = { 1, 1, 1, 1 },
  },
  layout = {
    height = { min = 4, max = 10 },
    width = { min = 20, max = 40 },
    spacing = 2,
  },
  ignore_missing = true,
  show_help = false,
  show_keys = true,
  triggers_blacklist = {
    i = { 'j', 'k' },
    v = { 'j', 'k' },
  },
  disable = {
    filetypes = { 'Telescope' },
  },
}
