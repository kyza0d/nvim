-----------------------------------
-- Neovim API shorthands
-----------------------------------

_G.create_augroup = vim.api.nvim_create_augroup
_G.create_autocmd = vim.api.nvim_create_autocmd
_G.clear_autocmds = vim.api.nvim_clear_autocmds

_G.api = vim.api
_G.fn = vim.fn

_G.fmt = string.format

_G.keymap = function(modes, mapping, command, options)
  local default_opts = { noremap = true, silent = true, nowait = true }
  local keymap = type(command) == 'function' and vim.keymap.set or vim.api.nvim_set_keymap

  options = options or {}
  options = vim.tbl_deep_extend('keep', {}, options, default_opts or {})

  if type(modes) == 'table' then
    for _, mode in pairs(modes) do
      keymap(mode, mapping, command, options)
    end
  else
    keymap(modes, mapping, command, options)
  end
end
