_G.opt = vim.opt
_G.api = vim.api
_G.fn = vim.fn
_G.lsp = vim.lsp
_G.fmt = string.format
_G.notify = vim.notify

_G.create_augroup = api.nvim_create_augroup
_G.create_autocmd = api.nvim_create_autocmd
_G.clear_autocmds = api.nvim_clear_autocmds

_G.ky = {
  ui = {
    statuscolumn = {
      enable = true,
    },
  },
  ai = {
    models = {
      chat = 'deepseek-chat',
      -- gemini-2.5-flash-preview-05-20
    },
  },
}

_G.ui = ky.ui
_G.ai = ky.ai

_G.hl = require('utils.highlight')
_G.helpers = require('utils.helpers')
_G.palette = require('editor.ui.palette')

_G.augroup = helpers.augroup

_G.icons = require('editor.ui.icons')
_G.colors = require('editor.ui.colors')
_G.palette = require('editor.ui.palette')

_G.join = helpers.join

function _G.reqcall(require_path)
  return setmetatable({}, {
    __index = function(_, k)
      return function(...) return require(require_path)[k](...) end
    end,
  })
end

_G.editor = {
  terminals = {
    toggle = function()
      local terminal = require('toggleterm.terminal').Terminal:new({ hidden = true })
      terminal:toggle()
    end,
    lazygit_toggle = function()
      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit = Terminal:new({ cmd = 'lazygit', hidden = true })
      lazygit:toggle()
    end,
    yazi_toggle = function()
      local Terminal = require('toggleterm.terminal').Terminal
      local yazi = Terminal:new({ cmd = 'yazi', hidden = true })
      yazi:toggle()
    end,
    btm_toggle = function()
      local Terminal = require('toggleterm.terminal').Terminal
      local btm = Terminal:new({ cmd = 'btm -b', hidden = true })
      btm:toggle()
    end,
  },
}

_G.concat = function(...)
  local args = { ... }
  local result = {}
  for _, arg in ipairs(args) do
    if type(arg) == 'table' then
      for _, item in ipairs(arg) do
        table.insert(result, item)
      end
    else
      table.insert(result, arg)
    end
  end
  return result
end

function ky.falsy(item)
  if not item then return true end
  local item_type = type(item)
  if item_type == 'boolean' then return not item end
  if item_type == 'string' then return item == '' end
  if item_type == 'number' then return item <= 0 end
  if item_type == 'table' then return vim.tbl_isempty(item) end
  return item ~= nil
end

function ky.p_table(map)
  return setmetatable(map, {
    __index = function(tbl, key)
      if not key then return end
      for k, v in pairs(tbl) do
        if key:match(k) then return v end
      end
    end,
  })
end

_G.safe_require = function(module_name)
  local package_exists, module = pcall(require, module_name)
  if not package_exists then
    vim.defer_fn(function()
      vim.schedule(function() vim.notify(' Could not load module: ' .. module_name, 'error', { title = 'Module Not Found' }) end)
    end, 1000)
    return nil
  else
    return module
  end
end

_G.keymap = function(modes, mapping, command, options)
  local default_opts = { noremap = true, silent = true, nowait = true }
  options = options or {}
  options = vim.tbl_deep_extend('keep', options, default_opts)

  -- Extract callback if provided
  local callback = options.callback
  options.callback = nil -- Remove from options to avoid conflicts

  -- Handle function commands and callbacks appropriately
  local is_func = type(command) == 'function'
  local set_func = is_func and vim.keymap.set or api.nvim_set_keymap

  -- Convert command to string if using nvim_set_keymap (can't handle functions)
  if not is_func and set_func == api.nvim_set_keymap then command = tostring(command) end

  -- Wrap command with callback if provided
  local final_command = command
  if callback then
    final_command = function()
      if is_func then
        command()
      else
        vim.cmd(command)
      end
      callback()
    end
    set_func = vim.keymap.set -- Must use vim.keymap.set for function commands
  end

  -- Handle buffer-specific keymaps
  if not is_func and options.buffer then
    local bufnr = options.buffer == true and 0 or options.buffer
    options.buffer = nil -- Remove buffer from options

    if type(modes) == 'table' then
      for _, mode in pairs(modes) do
        api.nvim_buf_set_keymap(bufnr, mode, mapping, command, options)
      end
    else
      api.nvim_buf_set_keymap(bufnr, modes, mapping, command, options)
    end
    return
  end

  -- Regular
  if type(modes) == 'table' then
    for _, mode in pairs(modes) do
      set_func(mode, mapping, final_command, options)
    end
  else
    set_func(modes, mapping, final_command, options)
  end
end

_G.fn_match = function(filename, command)
  if string.find(tostring(vim.fn.expand('%')), filename) then vim.cmd(command) end
end

ky.hl = require('utils.highlight')

function ky.foreach(callback, list)
  for k, v in pairs(list) do
    callback(v, k)
  end
end

function ky.fold(callback, list, accum)
  accum = accum or {}
  for k, v in pairs(list) do
    accum = callback(accum, v, k)
    assert(accum ~= nil, 'The accumulator must be returned on each iteration')
  end
  return accum
end

function ky.map(callback, list)
  return ky.fold(function(accum, v, k)
    accum[#accum + 1] = callback(v, k, accum)
    return accum
  end, list, {})
end

function ky.pcall(msg, func, ...)
  local args = { ... }
  if type(msg) == 'function' then
    local arg = func
    args, func, msg = { arg, unpack(args) }, msg, nil
  end
  return xpcall(func, function(err)
    msg = debug.traceback(msg and fmt('%s:\n%s\n%s', msg, vim.inspect(args), err) or err)
    vim.schedule(function() vim.notify(msg, vim.log.levels.ERROR, { title = 'ERROR' }) end)
  end, unpack(args))
end

function ky.reqidx(require_path)
  return setmetatable({}, {
    __index = function(_, key) return require(require_path)[key] end,
    __newindex = function(_, key, value) require(require_path)[key] = value end,
  })
end

function ky.command(name, rhs, opts)
  opts = opts or {}
  api.nvim_create_user_command(name, rhs, opts)
end

_G.settings = function(config)
  for key, entry in pairs(config) do
    if type(key) == 'table' and entry.opts then
      for _, ft in ipairs(key) do
        vim.api.nvim_create_autocmd('FileType', {
          pattern = ft,
          callback = function()
            vim.schedule(function()
              for option, value in pairs(entry.opts) do
                -- Use vim.opt_local which handles both buffer and window options correctly
                vim.opt_local[option] = value
              end
            end)
          end,
        })
      end
    end
  end
end
