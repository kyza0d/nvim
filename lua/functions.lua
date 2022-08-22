local M = {}

local Input = require("nui.input")
local event = require("nui.utils.autocmd").event

local keymap = require("utils").keymap

M.send_command = function(top, command, icon)
  local input = Input({
    position = "50%",
    size = {
      width = 40,
    },
    border = {
      style = "single",
      text = {
        top = top,
        top_align = "center",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:Normal",
    },
  }, {
    prompt = icon,
    default_value = "",
    on_submit = command,
  })

  local map_options = { noremap = true, nowait = true }

  input:map("i", { "q", "<esc>" }, function()
    input:unmount()
  end, map_options)

  -- unmount component when cursor leaves buffer
  input:on(event.BufLeave, function()
    input:unmount()
  end)

  -- keymap(modes, keys, function()
  input:mount()
  -- end)
end

-- M.send_command("n", "<C-g>", function(value)
--   vim.cmd("silent :!xdg-open 'https://duckduckgo.com/?q=" .. value .. "&ia=definition'")
-- end)

return M
