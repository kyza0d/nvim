-- Setup nvim-cmp.
local status_ok, autopairs = pcall(require, "nvim-autopairs")

if not status_ok then
  return
end

autopairs.setup({
  check_ts = true,
  map_cr = true,
  map_c_w = true,
  ts_config = {
    lua = { "string", "source" },
    javascript = { "string", "template_string" },
    java = false,
  },
  disable_filetype = { "TelescopePrompt", "spectre_panel" },
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
