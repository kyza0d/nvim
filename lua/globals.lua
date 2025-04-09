local namespace = {
  ui = {
    statuscolumn = {
      enable = true,
    },
  },
}

_G.ky = ky or namespace

_G.create_augroup = vim.api.nvim_create_augroup
_G.create_autocmd = vim.api.nvim_create_autocmd
_G.clear_autocmds = vim.api.nvim_clear_autocmds

_G.opt = vim.opt
_G.api = vim.api
_G.fn = vim.fn
_G.fmt = string.format

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

function ky.reqcall(require_path)
  return setmetatable({}, {
    __index = function(_, k)
      return function(...) return require(require_path)[k](...) end
    end,
  })
end

function ky.command(name, rhs, opts)
  opts = opts or {}
  api.nvim_create_user_command(name, rhs, opts)
end

function ky.settings(map)
  local excluded_filetypes = {}
  local excluded_buftypes = {}

  if map[{ '*' }] and map[{ '*' }].exclude then
    local exclude_config = map[{ '*' }].exclude
    if exclude_config.filetypes then
      for _, ft in ipairs(exclude_config.filetypes) do
        excluded_filetypes[ft] = true
      end
    end
    if exclude_config.buftypes then
      for _, bt in ipairs(exclude_config.buftypes) do
        excluded_buftypes[bt] = true
      end
    end
  end

  -- Global cache for original highlight values
  ky.ui.original_highlights = ky.ui.original_highlights or {}

  local commands = ky.map(function(settings, ft)
    local name = type({ ft }) == 'string' and ft or table.concat(ft, ',')
    return {
      pattern = ft,
      event = 'FileType',
      desc = ('ft settings for %s'):format(name),
      command = function(args)
        local bufnr = args.buf
        local winid = vim.api.nvim_get_current_win()

        local current_ft = vim.bo[bufnr].filetype
        local current_bt = vim.bo[bufnr].buftype

        if excluded_filetypes[current_ft] or excluded_buftypes[current_bt] then return end
        if vim.api.nvim_win_get_config(winid).relative ~= '' then return end

        local exclude_defaults = settings.exclude or false
        local group_name = settings.group
        local group_settings = group_name and ky.ui.groups[group_name]
        local default_settings = ky.ui.groups['default']

        -- Apply buffer-local settings
        local function apply_buffer_settings()
          if default_settings and not exclude_defaults and default_settings.opts then
            for option, value in pairs(default_settings.opts) do
              vim.opt_local[option] = value
            end
          end
          if group_settings and group_settings.opts then
            for option, value in pairs(group_settings.opts) do
              vim.opt_local[option] = value
            end
          end
        end

        -- Apply initial settings
        apply_buffer_settings()

        local group_id = create_augroup('ft_' .. name .. '_' .. bufnr, { clear = true })

        -- BufWinEnter: Apply window settings when buffer is displayed in a window
        create_autocmd('BufWinEnter', {
          buffer = bufnr,
          group = group_id,
          callback = function()
            if excluded_filetypes[vim.bo[bufnr].filetype] or excluded_buftypes[vim.bo[bufnr].buftype] then return end
          end,
        })

        create_autocmd('BufWinLeave', {
          buffer = bufnr,
          group = group_id,
          callback = function()
            local win = vim.api.nvim_get_current_win()
            vim.wo[win].winhighlight = ''
          end,
        })

        -- BufEnter: Handle on_enter
        create_autocmd('BufEnter', {
          buffer = bufnr,
          group = group_id,
          callback = function()
            if excluded_filetypes[vim.bo[bufnr].filetype] or excluded_buftypes[vim.bo[bufnr].buftype] then return end
            if group_settings and type(group_settings.on_enter) == 'function' then group_settings.on_enter() end
          end,
        })

        -- BufLeave: Handle on_exit
        create_autocmd('BufLeave', {
          buffer = bufnr,
          group = group_id,
          callback = function()
            if group_settings and type(group_settings.on_exit) == 'function' then group_settings.on_exit() end
          end,
        })

        -- Handle additional settings
        if settings.commands then
          local cmd_group = create_augroup('ft_cmd_' .. name .. '_' .. bufnr, { clear = true })
          for _, cmd in ipairs(settings.commands) do
            local autocmd_opts = {
              callback = cmd.callback,
              group = cmd_group,
            }
            if cmd.pattern then
              autocmd_opts.pattern = cmd.pattern
            else
              autocmd_opts.buffer = cmd.buffer or bufnr
            end
            create_autocmd(cmd.event, autocmd_opts)
          end
        end
      end,
    }
  end, map)

  ky.augroup('filetype-settings', unpack(commands))
end
