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
  -- Look for exclusions in the catch-all pattern first
  local excluded_filetypes = {}
  local excluded_buftypes = {}

  -- Check for '*' with exclusions
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

  local commands = ky.map(function(settings, ft)
    local name = type(ft) == 'string' and ft or table.concat(ft, ',')
    return {
      pattern = ft,
      event = 'FileType',
      desc = ('ft settings for %s'):format(name),
      command = function(args)
        local bufnr = args.buf
        local winid = vim.api.nvim_get_current_win()

        -- Early exit for excluded filetypes and buftypes
        local current_ft = vim.bo[bufnr].filetype
        local current_bt = vim.bo[bufnr].buftype

        if excluded_filetypes[current_ft] or excluded_buftypes[current_bt] then return end

        -- Also check for floating windows
        if vim.api.nvim_win_get_config(winid).relative ~= '' then
          return -- This is a floating window, skip applying settings
        end

        -- The rest of the function remains the same...
        local exclude_defaults = settings.exclude or false
        local group_name = settings.group
        local group_settings = group_name and ky.ui.groups[group_name]
        local default_settings = ky.ui.groups['default']
        local default_namespace = nil
        local specific_namespace = nil

        local function apply_default_settings()
          if exclude_defaults or not default_settings then return end
          local current_win = vim.fn.bufwinid(bufnr)
          if current_win == -1 then return end

          -- Check again if this is a floating window before applying settings
          if vim.api.nvim_win_get_config(current_win).relative ~= '' then return end

          if default_settings.opts then
            for option, value in pairs(default_settings.opts) do
              vim.opt_local[option] = value
            end
          end

          if default_settings.highlights then
            if not default_namespace then
              default_namespace = vim.api.nvim_create_namespace('ft_default_' .. bufnr)
              ky.hl.all(default_settings.highlights, default_namespace)
            end
            vim.api.nvim_win_set_hl_ns(current_win, default_namespace)
          end

          if type(default_settings.on_enter) == 'function' then default_settings.on_enter() end
        end

        local function apply_group_settings()
          if not group_settings or group_name == 'default' then return end
          local current_win = vim.fn.bufwinid(bufnr)
          if current_win == -1 then return end

          -- Check again if this is a floating window before applying settings
          if vim.api.nvim_win_get_config(current_win).relative ~= '' then return end

          if group_settings.opts then
            for option, value in pairs(group_settings.opts) do
              vim.opt_local[option] = value
            end
          end

          if group_settings.highlights then
            if not specific_namespace then
              specific_namespace = vim.api.nvim_create_namespace('ft_' .. name .. '_' .. bufnr)
              ky.hl.all(group_settings.highlights, specific_namespace)
            end
            vim.api.nvim_win_set_hl_ns(current_win, specific_namespace)
          end

          if type(group_settings.on_enter) == 'function' then group_settings.on_enter() end
        end

        local function apply_all_settings()
          apply_default_settings()
          apply_group_settings()
        end

        vim.b[bufnr].apply_default_settings = apply_default_settings
        vim.b[bufnr].apply_group_settings = apply_group_settings
        vim.b[bufnr].apply_all_settings = apply_all_settings

        -- Apply settings only if not excluded
        apply_all_settings()

        local group_id = create_augroup('ft_' .. name .. '_' .. bufnr, { clear = true })

        create_autocmd('BufLeave', {
          buffer = bufnr,
          group = group_id,
          callback = function()
            if group_settings and type(group_settings.on_exit) == 'function' then group_settings.on_exit() end
            apply_default_settings()
          end,
        })

        create_autocmd('BufEnter', {
          buffer = bufnr,
          group = group_id,
          callback = function()
            -- Check if buffer should be excluded before applying
            local ft = vim.bo[bufnr].filetype
            local bt = vim.bo[bufnr].buftype
            if excluded_filetypes[ft] or excluded_buftypes[bt] then return end

            apply_all_settings()
          end,
        })

        create_autocmd('WinEnter', {
          buffer = bufnr,
          group = group_id,
          callback = function()
            local current_win = vim.fn.bufwinid(bufnr)
            if current_win == -1 then return end

            -- Skip floating windows
            if vim.api.nvim_win_get_config(current_win).relative ~= '' then return end

            -- Check if buffer should be excluded
            local ft = vim.bo[bufnr].filetype
            local bt = vim.bo[bufnr].buftype
            if excluded_filetypes[ft] or excluded_buftypes[bt] then return end

            if specific_namespace and group_settings and group_settings.highlights then
              vim.api.nvim_win_set_hl_ns(current_win, specific_namespace)
            elseif default_namespace and default_settings and default_settings.highlights then
              vim.api.nvim_win_set_hl_ns(current_win, default_namespace)
            end
          end,
        })

        ky.foreach(function(value, scope)
          if scope == 'opt' then scope = 'opt_local' end
          if scope == 'plugins' then return ky.ftplugin_conf(value) end
          if scope == 'options' then
            ky.foreach(function(setting, option) vim.opt_local[option] = setting end, value)
            return
          end
          if scope == 'group' or scope == 'exclude' or scope == 'commands' then
            return -- These are handled separately
          end
          if type(value) ~= 'table' and vim.is_callable(value) then return value(args) end
          ky.foreach(function(setting, option) vim[scope][option] = setting end, value)
        end, settings)

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
