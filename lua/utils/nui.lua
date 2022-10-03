local nui = {}

local Input = require("nui.input")
local event = require("nui.utils.autocmd").event

nui.open_first = function()
  local nui_width = 40
  local input = Input({
    position = {
      row = vim.api.nvim_win_get_height(0) - 4,
      col = vim.api.nvim_win_get_width(0) - nui_width - 3,
    },
    size = {
      width = nui_width,
    },
    border = {
      style = "single",
      text = {
        top = "─ Duckduckgo ",
        top_align = "left",
        winhighlight = "StatusLine",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:Normal",
    },
  }, {
    prompt = " ",
    default_value = "",
    on_close = function()
      print("Input Closed!")
    end,
    on_submit = function(value)
      vim.api.nvim_command(string.format("silent !xdg-open 'https://duckduckgo.com/?q=\\`%s&ia=definition'", value))
    end,
  })

  -- mount/open the component
  input:mount()

  -- mount/open the component input:mount() unmount component when cursor leaves buffer
  input:on(event.BufLeave, function()
    input:unmount()
  end)
end

return nui
