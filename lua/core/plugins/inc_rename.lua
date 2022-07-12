local status_ok, inc_rename = pcall(require, "inc_rename")

if not status_ok then
  return
end

local keymap = require("core.utils").keymap

keymap("n", "gR", function()
  return ":IncRename "
end, { expr = true })

inc_rename.setup()
