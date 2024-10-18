local namespace = {
  ui = {},
}

_G.ky = ky or namespace

_G.create_augroup = vim.api.nvim_create_augroup
_G.create_autocmd = vim.api.nvim_create_autocmd
_G.clear_autocmds = vim.api.nvim_clear_autocmds

_G.opt = vim.opt
_G.api = vim.api
_G.fn = vim.fn
_G.fmt = string.format

_G.is_light = function() return vim.o.background == 'light' end

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

_G.editor = {
  minimal = false,
  zen_mode = true,
  statusline = {},
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

ky.list = { qf = {}, loc = {} }

function ky.augroup(name, ...)
  local commands = { ... }
  assert(name ~= 'User', 'The name of an augroup CANNOT be User')
  assert(#commands > 0, fmt('You must specify at least one autocommand for %s', name))
  local id = api.nvim_create_augroup(name, { clear = true })
  for _, autocmd in ipairs(commands) do
    api.nvim_create_autocmd(autocmd.event, {
      group = name,
      pattern = autocmd.pattern,
      desc = autocmd.desc,
      callback = type(autocmd.command) == 'function' and autocmd.command or nil,
      command = type(autocmd.command) ~= 'function' and autocmd.command or nil,
      once = autocmd.once,
      nested = autocmd.nested,
      buffer = autocmd.buffer,
    })
  end
  return id
end

ky.custom_menus = {
  code_action = function() require('utils.commands.code_actions')() end,
  redir = function() require('utils.commands.redir')() end,
  references = function() require('utils.commands.lsp_references') end,
}

function ky.filetype_settings(map)
  local commands = ky.map(function(settings, ft)
    local name = type(ft) == 'string' and ft or table.concat(ft, ',')
    return {
      pattern = ft,
      event = 'FileType',
      desc = ('ft settings for %s'):format(name),
      command = function(args)
        ky.foreach(function(value, scope)
          if scope == 'opt' then scope = 'opt_local' end
          if scope == 'mappings' then return apply_ft_mappings(value, args.buf) end
          if scope == 'plugins' then return ky.ftplugin_conf(value) end
          if type(value) ~= 'table' and vim.is_callable(value) then return value(args) end
          ky.foreach(function(setting, option) vim[scope][option] = setting end, value)
        end, settings)
      end,
    }
  end, map)
  ky.augroup('filetype-settings', unpack(commands))
end
