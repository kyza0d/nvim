return {
  fps = 60,
  -- minimum_width = 80,
  render = function(bufnr, notif, highlights)
    local base = require('notify.render.base')
    local namespace = base.namespace()
    local title = notif.title[1]

    local icon = notif.icon
    local icon_length = vim.str_utfindex(icon)

    local prefix = string.format('%s %s:', icon, title)
    local prefix_length = vim.str_utfindex(prefix)

    if type(title) == 'string' and #title > 0 then
      prefix = string.format('%s %s:', icon, title)
    else
      prefix = string.format('%s', icon)
    end

    notif.message[1] = string.format('%s %s ', prefix, notif.message[1])

    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, notif.message)

    vim.api.nvim_buf_set_extmark(bufnr, namespace, 0, 0, {
      hl_group = highlights.icon,
      end_col = icon_length + 1,
      priority = 50,
    })
    vim.api.nvim_buf_set_extmark(bufnr, namespace, 0, icon_length + 1, {
      hl_group = highlights.title,
      end_col = prefix_length + icon_length,
      priority = 50,
    })

    vim.api.nvim_buf_set_extmark(bufnr, namespace, 0, prefix_length + 1, {
      hl_group = highlights.body,
      end_line = #notif.message,
      priority = 50,
    })
  end,

  stages = 'fade',

  timeout = 2000,
  icons = {
    DEBUG = '  ',
    ERROR = '  ',
    INFO = '  ',
    TRACE = ' ✎ ',
    WARN = '  ',
  },
}
