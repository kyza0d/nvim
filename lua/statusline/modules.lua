local modules = {}

local colors, hl, decorations = require('statusline.palette'), ky.hl, ky.ui.decorations
local api, fn, fmt = vim.api, vim.fn, string.format
local sep, falsy = package.config:sub(1, 1), ky.falsy

modules.diagnostic_info = function(context)
  local diagnostics, severities, lsp_icons = vim.diagnostic.get(context.bufnum), vim.diagnostic.severity, ky.ui.icons.lsp
  local result = {
    error = { count = 0, icon = lsp_icons.error },
    warn = { count = 0, icon = lsp_icons.warn },
    info = { count = 0, icon = lsp_icons.info },
    hint = { count = 0, icon = lsp_icons.hint },
  }
  return vim.tbl_isempty(diagnostics) and result
    or ky.fold(function(accum, item)
      local severity = severities[item.severity]:lower()
      accum[severity].count = accum[severity].count + 1
      return accum
    end, diagnostics, result)
end

modules.search_count = function()
  local ok, result = pcall(fn.searchcount, { recompute = 0 })
  if not ok then return '' end
  if vim.tbl_isempty(result) then return '' end
  if result.incomplete == 1 then -- timed out
    return ' ?/?? '
  elseif result.incomplete == 2 then -- max count exceeded
    if result.total > result.maxcount and result.current > result.maxcount then
      return fmt(' >%d/>%d ', result.current, result.total)
    elseif result.total > result.maxcount then
      return fmt(' %d/>%d ', result.current, result.total)
    end
  end
  return fmt(' %d/%d ', result.current, result.total)
end

modules.search_item = function()
  local result = vim.fn.searchcount({ recompute = 1, maxcount = -1 })
  return vim.tbl_isempty(result) and '' or fmt('/%s', vim.fn.getreg('/'):sub(0, 20))
end

modules.mode_highlight = function(mode)
  local visual_regex = vim.regex([[\(s\|S\|\)]])
  local select_regex = vim.regex([[\(v\|V\|\)]])
  local command_regex = vim.regex([[\(c\|cv\|ce\)]])
  local replace_regex = vim.regex([[\(Rc\|R\|Rv\|Rx\)]])
  if mode == 'i' then
    return colors.hls.mode_insert
  elseif visual_regex and visual_regex:match_str(mode) then
    return colors.hls.mode_visual
  elseif select_regex and select_regex:match_str(mode) then
    return colors.hls.mode_select
  elseif replace_regex and replace_regex:match_str(mode) then
    return colors.hls.mode_replace
  elseif command_regex and command_regex:match_str(mode) then
    return colors.hls.mode_command
  else
    return colors.hls.mode_normal
  end
end

modules.stl_mode = function()
  local mode_map = ky.ui.modes
  local current_mode = api.nvim_get_mode().mode
  return (mode_map[current_mode] or 'UNKNOWN'), modules.mode_highlight(current_mode)
end

local state = { lsp_clients_visible = true }

---Return a sorted list of lsp client names and their priorities
---@param ctx StatuslineContext
---@return table[]
modules.stl_lsp_clients = function(ctx)
  local clients = vim.lsp.get_clients({ bufnr = ctx.bufnum })
  if not state.lsp_clients_visible then return { { name = fmt('%d attached', #clients), priority = 7 } } end
  if falsy(clients) then return { { name = 'No LSP clients available', priority = 7 } } end
  table.sort(clients, function(a, b) return a.name < b.name end)

  return vim.tbl_map(function(client) return { name = client.name, priority = 4 } end, clients)
end

modules.is_git_repo = function(win_id)
  win_id = win_id or api.nvim_get_current_win()
  return vim.loop.fs_stat(fmt('%s/.git', fn.getcwd(win_id)))
end

modules.update_git_status = function()
  if not modules.is_git_repo() then return end
  local result = {}
  fn.jobstart('git rev-list --count --left-right @{upstream}...HEAD', {
    stdout_buffered = true,
    on_stdout = function(_, data, _)
      for _, item in ipairs(data) do
        if item and item ~= '' then table.insert(result, item) end
      end
    end,
    on_exit = function(_, code, _)
      if code > 0 and not result or not result[1] then return end
      local parts = vim.split(result[1], '\t')
      if parts and #parts > 1 then vim.g.git_statusline_updates = { behind = parts[1], ahead = parts[2] } end
    end,
  })
end

modules.git_updates = function()
  local pending_job, timer = nil, vim.loop.new_timer()
  if not timer then return end
  timer:start(
    0,
    10000,
    vim.schedule_wrap(function()
      if pending_job then fn.jobstop(pending_job) end
      pending_job = modules.update_git_status()
    end)
  )
end

modules.is_plain = function(ctx)
  local decor = decorations.get({ ft = ctx.filetype, bt = ctx.buftype, setting = 'statusline' })
  local is_plain_ft, is_plain_bt = decor.ft == 'minimal', decor.bt == 'minimal'
  return is_plain_ft or is_plain_bt or ctx.preview or ctx.filetype == 'neo-tree'
end

local function with_sep(path) return (not falsy(path) and path:sub(-1) ~= sep) and path .. sep or path end

local function get_buffer_icon(buf, opts)
  local path = api.nvim_buf_get_name(buf)
  if fn.isdirectory(path) == 1 then
    -- For directories, you might want to use a specific icon
    return require('mini.icons').get('directory', path)
  end

  local ok, miniIcons = pcall(require, 'mini.icons')
  if not ok then return '', nil end

  local name = fn.fnamemodify(path, ':t')
  local ext = fn.fnamemodify(path, ':e')

  -- Try to get icon for the specific filename
  local icon, hl = miniIcons.get('file', name)

  -- If no specific icon, try to get icon for the file extension
  if icon == nil and ext ~= '' then
    icon, hl = miniIcons.get('extension', ext)
  end

  -- If still no icon, fallback to default file icon
  if icon == nil then
    icon, hl = miniIcons.get('default', 'file')
  end

  return icon .. ' ', hl
end

modules.unique_files = {
  ['qf'] = {
    name = function(_, buf)
      local qf = api.nvim_call_function('getqflist', {})
      return fmt('Quickfix(%d)', #qf)
    end,
    icon = '   ',
    hl = colors.hls.dir_parent,
    icon_hl = colors.hls.dir_parent,
  },
  ['trouble'] = {
    name = 'Trouble',
    hl = colors.hls.dir_parent,
    icon_hl = colors.hls.dir_parent,
  },
  ['norg'] = {
    name = function(_, buf)
      local mode = modules.stl_mode()
      local filetype = vim.bo[buf].filetype
      local file_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ':t')
      local line_count = vim.api.nvim_buf_line_count(buf)
      return string.format('%s %s Neorg (%d lines)', mode, file_name, line_count)
    end,
    icon = '   ',
    hl = colors.hls.statusline,
    icon_hl = colors.hls.indicator,
  },
  ['Avante'] = {
    name = function() return 'Avante' end,
    icon = '   ',
    hl = colors.hls.panel_st,
    icon_hl = colors.hls.panel_st_icon,
  },
  ['AvanteInput'] = {
    name = function() return 'AvanteInput' end,
    icon = '   ',
    hl = colors.hls.panel_st,
    icon_hl = colors.hls.panel_st_icon,
  },
  ['neo-tree'] = {
    name = function(fname, _)
      local parts = vim.split(fname, ' ')
      return fmt('Neo Tree(%s)', parts[2])
    end,
    icon = ' 󰙅  ',
    hl = colors.hls.neotree,
    icon_hl = colors.hls.neotree_icon,
  },
  ['help'] = {
    name = function(_, _) return 'Help' end,
    icon = '  ',
    hl = colors.hls.statusline,
    icon_hl = colors.hls.indicator,
  },
  ['toggleterm'] = {
    name = function(_, buf)
      local shell = fn.fnamemodify(vim.env.SHELL, ':t')
      return fmt('Terminal(%s)[%s]', shell, api.nvim_buf_get_var(buf, 'toggle_number'))
    end,
    icon = '   ',
    hl = colors.hls.terminal,
    icon_hl = colors.hls.terminal_icon,
  },
}

local paths = {
  [vim.env.HOME] = '~',
}

modules.filename = function(ctx)
  local buf, ft = ctx.bufnum, ctx.filetype
  local path = api.nvim_buf_get_name(buf)
  if falsy(path) then return { fname = 'No Name' } end
  -- Replace directory with alias if found in paths table
  for directory, alias in pairs(paths) do
    if path:find(directory) == 1 then
      path = path:gsub(directory, alias)
      break
    end
  end

  local parts = vim.split(path, sep)
  local fname = table.remove(parts)
  local parent = table.remove(parts)
  local dir = with_sep(table.concat(parts, sep))

  return {
    fname = fname,
    parent = with_sep(parent),
    dir = dir,
    ft = ft,
  }
end

local function get_ft_icon_hl_name(hl) return hl .. colors.hls.statusline end

local function filetype(ctx)
  local buf = ctx.bufnum
  local icon, hl_group = get_buffer_icon(buf, { default = true })
  if hl_group then
    local fg = hl.get(hl_group, 'fg')
    local bg = hl.get(colors.hls.statusline, 'bg')
    if fg and bg then
      local hl_name = get_ft_icon_hl_name(hl_group)
      hl.set(hl_name, { fg = fg, bg = bg })
      return icon, hl_name
    end
  end
  return icon, colors.hls.dimmed
end

---@param hl string
---@return fun(id: number): string
local function with_win_id(hl)
  return function(id) return hl .. id end
end

modules.stl_file = function(ctx, minimal)
  local ft_icon, ft_hl = filetype(ctx)
  local directory_hl = colors.hls.dir_path
  local parent_hl = colors.hls.dir_parent
  local filename_hl = colors.hls.dir_file

  local file_icon = { {}, before = '', after = ' ', priority = 0 }
  local dir_opts = { {}, before = '', after = '', priority = 1 }
  local parent_opts = { {}, before = '', after = '', priority = 2 }
  local file_opts = { {}, before = '', after = ' ', priority = 0 }

  local p = modules.filename(ctx)

  table.insert(file_icon[1], { ft_icon, ft_hl })
  table.insert(dir_opts[1], { p.dir or '', directory_hl })
  table.insert(parent_opts[1], { p.parent or '', parent_hl })
  table.insert(file_opts[1], { p.fname or '', filename_hl })

  return {
    icon = file_icon,
    dir = dir_opts,
    parent = parent_opts,
    file = file_opts,
  }
end

local set_filetype_icon_highlights, reset_filetype_icon_highlights = (function()
  local hl_cache = {}
  return function(buf, ft)
    if falsy(ft) then return end
    local _, color = get_buffer_icon(buf)

    if not color then return end
    local fg, bg = hl.get(color, 'fg'), hl.get(colors.hls.statusline, 'bg')

    if not bg and not fg then return end
    local name = get_ft_icon_hl_name(color)

    hl_cache[ft] = { name = name, hl = fg }
    hl.set(name, { fg = fg, bg = bg })
  end, function()
    for _, data in pairs(hl_cache) do
      hl.set(data.name, { fg = data.hl, bg = hl.get(colors.hls.statusline, 'bg') })
    end
  end
end)()

modules.setup = function()
  ky.augroup(
    'CustomStatusline',
    { event = 'FileType', command = function(args) set_filetype_icon_highlights(args.buf, args.match) end },
    { event = 'BufReadPre', once = true, command = modules.git_updates },
    {
      event = 'ColorScheme',
      command = function()
        colors.setup()
        reset_filetype_icon_highlights()
      end,
    },
    {
      event = 'LspAttach',
      command = function(args)
        local clients = vim.lsp.get_clients({ bufnr = args.buf })
        if vim.o.columns < 200 and #clients > 3 then state.lsp_clients_visible = false end
      end,
    }
  )
end

return modules
