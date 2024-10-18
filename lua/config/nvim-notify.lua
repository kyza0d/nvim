---@diagnostic disable: missing-fields

-- Notify with warning
-- vim.notify('This is a warning', 'warn')
-- vim.notify('This is a warning', 'warn', { title = 'Custom Source' })

local hl, ui = ky.hl, ky.ui
local icons = ui.icons
-- local vertical_bar = icons.misc.vertical_bar
local P = ui.palette

-- local notify_hls = {
hl.plugin('Notify', {
  theme = {
    ['*'] = {
      { NotifyBackground = { ky.ui.notify.bg } },

      { NotifyWARNIcon = { fg = P.light_yellow } },
      { NotifyERRORIcon = { fg = P.pale_red } },
      { NotifyINFOIcon = { fg = P.dark_blue } },
      { NotifyDEBUGIcon = { fg = P.dark_blue } },
      { NotifyTRACEIcon = { fg = P.dark_blue } },

      { NotifyWARNBorder = { ky.ui.notify.warn } },
      { NotifyERRORBorder = { ky.ui.notify.error } },
      { NotifyINFOBorder = { ky.ui.notify.info } },
      { NotifyDEBUGBorder = { ky.ui.notify.debug } },
      { NotifyTRACEBorder = { ky.ui.notify.trace } },

      { NotifyERRORBody = { ky.ui.notify.bg } },
      { NotifyWARNBody = { ky.ui.notify.bg } },
      { NotifyINFOBody = { ky.ui.notify.bg } },
      { NotifyDEBUGBody = { ky.ui.notify.bg } },
      { NotifyTRACEBody = { ky.ui.notify.bg } },

      { NotifyERRORTitle = { fg = P.magenta } },
      { NotifyWARNTitle = { fg = P.magenta } },
      { NotifyINFOTitle = { fg = P.magenta } },
      { NotifyDEBUGTitle = { fg = P.magenta } },
      { NotifyTRACETitle = { fg = P.magenta } },
    },
  },
})

---@param line string
---@param width number
---@return string[]
local function split_length(line, width)
  local text = {}
  local next_line
  while true do
    if #line == 0 then return text end
    next_line, line = line:sub(1, width), line:sub(width)
    text[#text + 1] = next_line
  end
end

---@param lines string[]
---@param max_width number
---@return string[]
local function custom_wrap(lines, max_width)
  local wrapped_lines = {}
  for _, line in pairs(lines) do
    local new_lines = split_length(line, max_width)
    for _, nl in ipairs(new_lines) do
      nl = nl:gsub('^%s*', ' '):gsub('%s*$', ' ') -- ensure padding
      table.insert(wrapped_lines, nl)
    end
  end
  return wrapped_lines
end

return function()
  local stages = require('notify.stages.slide')('top_down')
  local notify = require('notify')
  local base = require('notify.render.base')

  notify.setup({
    max_width = function() return math.floor(vim.o.columns * 0.7) end,
    max_height = function() return math.floor(vim.o.lines * 0.4) end,

    background_colour = 'NotifyBackground',

    fps = 120,

    -- render = 'wrapped-compact',
    render = function(bufnr, notif, highlights, config)
      local namespace = base.namespace()
      local icon = notif.icon
      local title = notif.title[1]

      local prefix

      local max_width = config.max_width()
      local message = custom_wrap(notif.message, max_width)

      if type(title) == 'string' and #title > 0 then
        prefix = string.format(' %s %s', icon, title)
        table.insert(message, 1, prefix)
      else
        prefix = string.format('%s', icon)
        message[1] = string.format(' %s %s', prefix, message[1])
      end

      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, message)

      local icon_length = vim.str_utfindex(icon)
      local prefix_length = vim.str_utfindex(prefix) + 1

      vim.api.nvim_buf_set_extmark(bufnr, namespace, 0, 0, {
        hl_group = highlights.icon,
        end_col = icon_length + 1,
        priority = 50,
      })
      vim.api.nvim_buf_set_extmark(bufnr, namespace, 0, icon_length + 1, {
        hl_group = highlights.title,
        end_col = prefix_length + 1,
        priority = 50,
      })
      vim.api.nvim_buf_set_extmark(bufnr, namespace, 0, prefix_length + 1, {
        hl_group = highlights.body,
        end_line = #message,
        priority = 50,
      })
    end,

    on_open = function(win)
      vim.api.nvim_set_option_value('wrap', true, { win = win })
      vim.api.nvim_set_option_value('breakindent', false, { win = win })
    end,

    stages = {
      function(...)
        local opts = stages[1](...)
        -- if opts then opts.border = 'none' end
        if opts then
          -- opts.border = { '', '', '', '', '', '', '', vertical_bar }
          -- opts.border = 'none'
          opts.row = opts.row - 1
        end
        return opts
      end,
      unpack(stages, 2),
    },

    timeout = 2000,

    icons = {
      DEBUG = ' ',
      ERROR = ' ',
      INFO = ' ',
      TRACE = ' ',
      WARN = ' ',
    },
  })
end
