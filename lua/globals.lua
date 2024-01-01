-------------------------------------------------
-- Neovim API Shorthands
-------------------------------------------------

_G.create_augroup = vim.api.nvim_create_augroup
_G.create_autocmd = vim.api.nvim_create_autocmd
_G.clear_autocmds = vim.api.nvim_clear_autocmds

_G.api = vim.api
_G.fn = vim.fn

-------------------------------------------------
-- Lua function shorthands / Utility functions
-------------------------------------------------

_G.str = function(...)
  local args = { ... } -- pack all arguments into a table
  return table.concat(args, ' ') -- concatenate the arguments with a space
end

---
-- Sets key mappings in Neovim for specified modes.
--
-- @function _G.keymap
-- @param modes (table or string) Modes for which the key mappings should be set.
-- @param mapping (string) The key mapping to be set.
-- @param command (function or string) The command to be executed when the key mapping is triggered.
-- @param options (table) (optional) Additional options for the key mapping.
--   @field noremap (boolean) If true, the mapping will not be remapped. Defaults to true.
--   @field silent (boolean) If true, the mapping will be executed silently, without echoing the command. Defaults to true.
--   @field nowait (boolean) If true, the mapping will not wait for other key sequences. Defaults to true.
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

_G.concat = function(...)
  local args = { ... }
  local result = ''

  for i = 1, #args do
    if type(args[i]) == 'table' then
      for j = 1, #args[i] do
        result = string.format('%s%s', result, args[i][j])
      end
    else
      result = string.format('%s%s', result, args[i])
    end
  end

  return result
end

local function _assign(old, new, k)
  local otype = type(old[k])
  local ntype = type(new[k])
  if (otype == 'thread' or otype == 'userdata') or (ntype == 'thread' or ntype == 'userdata') then
    vim.notify(string.format('warning: old or new attr %s type be thread or userdata', k))
  end
  old[k] = new[k]
end

local require_safe = function(mod)
  local status_ok, module = pcall(require, mod)
  if not status_ok then
    local trace = debug.getinfo(2, 'SL')
    local shorter_src = trace.short_src
    local lineinfo = shorter_src .. ':' .. (trace.currentline or trace.linedefined)
    local msg = string.format('%s : skipped loading [%s]', lineinfo, mod)
    print(msg)
  end
  return module
end

local function _replace(old, new, repeat_tbl)
  if repeat_tbl[old] then return end
  repeat_tbl[old] = true

  local dellist = {}
  for k, _ in pairs(old) do
    if not new[k] then table.insert(dellist, k) end
  end
  for _, v in ipairs(dellist) do
    old[v] = nil
  end

  for k, _ in pairs(new) do
    if not old[k] then
      old[k] = new[k]
    else
      if type(old[k]) ~= type(new[k]) then
        print(
          string.format('Reloader: mismatch between old [%s] and new [%s] type for [%s]', type(old[k]), type(new[k]), k)
        )
        _assign(old, new, k)
      else
        if type(old[k]) == 'table' then
          _replace(old[k], new[k], repeat_tbl)
        else
          _assign(old, new, k)
        end
      end
    end
  end
end

-- Source: https://github.com/LunarVim/LunarVim/blob/master/lua/lvim/utils/modules.lua
_G.reload = function(mod)
  if not package.loaded[mod] then return require_safe(mod) end

  local old = package.loaded[mod]
  package.loaded[mod] = nil
  local new = require_safe(mod)

  if type(old) == 'table' and type(new) == 'table' then
    local repeat_tbl = {}
    _replace(old, new, repeat_tbl)
  end

  package.loaded[mod] = old
  return old
end

-------------------------------------------------
-- Editor state
-------------------------------------------------

_G.editor = {
  zen_mode = false,
  status_line = false,
  cmdheight = 1,
  terminal = {
    active = false,
    toggle = function()
      local terminal = require('toggleterm.terminal').Terminal:new({ hidden = true })
      terminal:toggle()
    end,

    lazygit_toggle = function()
      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit = Terminal:new({ cmd = 'lazygit', hidden = true })

      lazygit:toggle()
    end,
  },
}

--------------------------------------------
-- Lua Functions
--------------------------------------------

_G.fmt = string.format

_G.fn_match = function(filename, command)
  if string.find(tostring(vim.fn.expand('%')), filename) then vim.cmd(command) end
end

--------------------------------------------
-- Namespace Functions
--------------------------------------------

_G.ky = {}

ky.icons = require('icons')

ky.highlights = function()
  if pcall(require, 'harmony') then return require('harmony') end
end

--- Call the given function and use `vim.notify` to notify of any errors
--- this function is a wrapper around `xpcall` which allows having a single
--- error handler for all errors
---@param msg string
---@param func function
---@param ... any
---@return boolean, any
---@overload fun(func: function, ...): boolean, any
function ky.pcall(msg, func, ...)
  local args = { ... }
  if type(msg) == 'function' then
    local arg = func --[[@as any]]
    args, func, msg = { arg, unpack(args) }, msg, nil
  end
  return xpcall(func, function(err)
    msg = debug.traceback(msg and fmt('%s:\n%s\n%s', msg, vim.inspect(args), err) or err)
    vim.schedule(function() vim.notify(msg, vim.log.levels.ERROR, { title = 'ERROR' }) end)
  end, unpack(args))
end

-- Custom menus
ky.custom_menus = {
  code_action = function() require('utils.commands.code_actions') end,
  redir = function() require('utils.commands.redir') end,
  references = function() require('utils.commands.lsp_references') end,
}
-- Caching

ky.write_cache = function(key, value, group)
  local cache_dir = '/home/kyza/.cache/nvim/ky/'
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

ky.read_cache = function(key, default, fallback)
  local cache_dir = '/home/kyza/.cache/nvim/ky/'

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
  local current = ky.read_cache(key, 'false', 'false')

  if current == 'true' then
    ky.write_cache(key, 'false', group)
  else
    ky.write_cache(key, 'true', group)
  end

  return ky.read_cache(key, 'false', 'false') == value
end
