keymap = function(modes, mapping, command, options)
  local default_opts = { noremap = true, silent = true, nowait = true }
  local keymap = type(command) == "function" and vim.keymap.set or vim.api.nvim_set_keymap

  options = options or {}
  options = vim.tbl_deep_extend("keep", {}, options, default_opts or {})

  if type(modes) == "table" then
    for _, mode in pairs(modes) do
      keymap(mode, mapping, command, options)
    end
  else
    keymap(modes, mapping, command, options)
  end
end
