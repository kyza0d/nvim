local modules = {}

local hl, decorations = ky.hl, ky.ui.decorations
local api, fn, fmt = vim.api, vim.fn, string.format
local sep, falsy = package.config:sub(1, 1), ky.falsy

modules.diagnostic_info = function(context)
  local diagnostics, severities, lsp_icons = vim.diagnostic.get(context.bufnum), vim.diagnostic.severity, icons.lsp

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
    return palette.hls.mode_insert
  elseif visual_regex and visual_regex:match_str(mode) then
    return palette.hls.mode_visual
  elseif select_regex and select_regex:match_str(mode) then
    return palette.hls.mode_select
  elseif replace_regex and replace_regex:match_str(mode) then
    return palette.hls.mode_replace
  elseif command_regex and command_regex:match_str(mode) then
    return palette.hls.mode_command
  else
    return palette.hls.mode_normal
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

modules.win_move = function()
  local winmove = require('winmove')
  local mode = winmove.current_mode()
  if mode then return fmt('[%s]', mode) end
  return ''
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
    hl = palette.hls.dir_parent,
    icon_hl = palette.hls.dir_parent,
  },
  ['trouble'] = {
    name = 'Trouble',
    icon = ' 󰒡 ',
    hl = palette.hls.trouble,
    icon_hl = palette.hls.trouble_icon,
  },
  ['codecompanion'] = {
    name = function() return 'codecompanion' end,
    icon = '   ',
    hl = palette.hls.terminal,
    icon_hl = palette.hls.terminal_icon,
  },
  ['fzf'] = {
    name = function(fname, _) return fmt('fzf-lua', fname) end,
    icon = ' 󰩊 ',
    hl = palette.hls.fzf,
    icon_hl = palette.hls.fzf_icon,
  },
  ['neo-tree'] = {
    name = function(fname, _)
      local parts = vim.split(fname, ' ')
      return fmt('Neo Tree(%s)', parts[2])
    end,
    icon = ' 󰙅  ',
    hl = palette.hls.neotree,
    icon_hl = palette.hls.neotree_icon,
  },
  ['toggleterm'] = {
    name = function(_, buf)
      local shell = fn.fnamemodify(vim.env.SHELL, ':t')
      return fmt('Terminal(%s)[%s]', shell, api.nvim_buf_get_var(buf, 'toggle_number'))
    end,
    icon = '   ',
    hl = palette.hls.terminal,
    icon_hl = palette.hls.terminal_icon,
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

local function get_ft_icon_hl_name(hl) return hl .. palette.hls.statusline end

-- Enhanced filetype icon highlighting with context-aware backgrounds
local function filetype(ctx)
  local buf = ctx.bufnum
  local icon, hl_group = get_buffer_icon(buf, { default = true })
  if hl_group then
    local fg = hl.get(hl_group, 'fg')

    -- Get the appropriate background based on filetype/buftype
    local bg
    if ctx.filetype == 'neo-tree' then
      bg = require('xeno').colors.base_800
    elseif ctx.filetype == 'trouble' then
      bg = require('xeno').colors.base_800
    elseif ctx.filetype == 'toggleterm' or ctx.buftype == 'terminal' then
      bg = require('xeno').colors.base_800
    elseif ctx.filetype == 'fzf' then
      bg = require('xeno').colors.base_800
    else
      bg = hl.get(palette.hls.statusline, 'bg') or require('xeno').colors.base_700
    end

    if fg and bg then
      local hl_name = get_ft_icon_hl_name(hl_group)
      hl.set(hl_name, { fg = fg, bg = bg })
      return icon, hl_name
    end
  end
  return icon, palette.hls.dimmed
end

modules.stl_file = function(ctx, minimal)
  local ft_icon, ft_hl = filetype(ctx)
  local directory_hl = palette.hls.dir_path
  local parent_hl = palette.hls.dir_parent
  local filename_hl = palette.hls.dir_file

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
    local fg = hl.get(color, 'fg')

    -- Context-aware background selection
    local xeno = require('xeno').colors
    local bg
    if ft == 'neo-tree' or ft == 'trouble' or ft == 'toggleterm' or ft == 'fzf' then
      bg = xeno.base_800
    else
      bg = hl.get(palette.hls.statusline, 'bg') or xeno.base_700
    end

    if not bg or not fg then return end
    local name = get_ft_icon_hl_name(color)

    hl_cache[ft] = { name = name, hl = fg, bg = bg }
    hl.set(name, { fg = fg, bg = bg })
  end, function()
    for _, data in pairs(hl_cache) do
      -- Use cached background for consistency
      hl.set(data.name, { fg = data.hl, bg = data.bg })
    end
  end
end)()

modules.setup = function()
  augroup('CustomStatusline', {
    event = 'FileType',
    command = function(args) set_filetype_icon_highlights(args.buf, args.match) end,
  }, {
    event = 'BufReadPre',
    once = true,
    command = modules.git_updates,
  }, {
    event = 'ColorScheme',
    command = function()
      -- Defer the highlight setup to ensure the colorscheme is fully loaded
      vim.defer_fn(function()
        -- Re-setup the palette highlights
        palette.setup()

        -- Reset filetype icon highlights to use new colors
        reset_filetype_icon_highlights()

        -- Force statusline refresh
        vim.cmd('redrawstatus!')
      end, 10) -- Slightly longer delay to ensure colorscheme is applied
    end,
  }, {
    event = 'LspAttach',
    command = function(args)
      local clients = vim.lsp.get_clients({ bufnr = args.buf })
      if vim.o.columns < 200 and #clients > 3 then state.lsp_clients_visible = false end
    end,
  })
end

return modules
