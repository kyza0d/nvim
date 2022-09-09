-- Setup nvim-cmp.
local status_ok, autopairs = pcall(require, "nvim-autopairs")

if not status_ok then
  return
end

autopairs.setup({
  check_ts = true,
  map_cr = true,
  ts_config = {
    lua = { "string", "source" },
    javascript = { "string", "template_string" },
    java = false,
  },
  disable_filetype = { "TelescopePrompt", "spectre_panel" },
})

local cmp_status_ok, cmp = pcall(require, "cmp")

if not cmp_status_ok then
  return
end

local cmp_autopairs = require("nvim-autopairs.completion.cmp")

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
