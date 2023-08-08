--------------------------------------------
-- Neovim API Shorthands
--------------------------------------------

_G.create_augroup = vim.api.nvim_create_augroup
_G.create_autocmd = vim.api.nvim_create_autocmd
_G.clear_autocmds = vim.api.nvim_clear_autocmds

_G.api = vim.api
_G.fn = vim.fn

--------------------------------------------
-- Lua Functions
--------------------------------------------

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

_G.fn_match = function(filename, command)
  if string.find(vim.fn.expand('%'), filename) then vim.cmd(command) end
end

_G.icons = require('options')

--------------------------------------------
-- Namespace Functions
--------------------------------------------

_G.ky = {}

ky.write_cache = function(key, value, group)
  local cache_dir = '/home/evan/.cache/nvim/ky/'
  local cache_file = cache_dir .. key

  -- Create cache directory if it doesn't exist
  os.execute('mkdir -p ' .. cache_dir)

  if group then
    cache_file = cache_dir .. group .. '/' .. key
    os.execute('mkdir -p ' .. cache_dir .. group)
  end

  -- Save the value into the cache file
  local file = io.open(cache_file, 'w')
  if file == nil then return end
  file:write(value)
  file:close()
end

ky.load_cache = function(key, default, fallback)
  local cache_dir = '/home/evan/.cache/nvim/ky/'

  if not vim.fn.isdirectory(cache_dir) then os.execute('mkdir -p ' .. cache_dir) end

  local cache_file = cache_dir .. key

  local file = io.open(cache_file, 'r')

  if file then
    local value = file:read('*a')
    file:close()
    return value
  else
    return fallback or default
  end
end

-- Grab from cache to toggle a value
ky.toggle_value = function(key, value, group)
  local current = ky.load_cache(key, 'false', 'false')

  if current == 'true' then
    ky.write_cache(key, 'false', group)
  else
    ky.write_cache(key, 'true', group)
  end

  return ky.load_cache(key, 'false', 'false') == value
end
