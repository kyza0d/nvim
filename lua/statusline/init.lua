local M = {}

local str = require('utils.strings')
local section, display = str.section, str.display

local ui = ky.ui
local icons = ui.icons

local api, fmt, strwidth = vim.api, string.format, vim.api.nvim_strwidth
local falsy = ky.falsy

local colors = require('statusline.palette')
local modules = require('statusline.modules')

function M.render()
  local curwin = api.nvim_get_current_win()
  local curbuf = api.nvim_win_get_buf(curwin)
  local is_active = curwin == vim.g.actual_curwin

  local available_space = vim.api.nvim_win_get_width(0)

  local ctx = {
    bufnum = curbuf,
    win = curwin,
    bufname = api.nvim_buf_get_name(curbuf),
    preview = vim.wo[curwin].previewwindow,
    readonly = vim.bo[curbuf].readonly,
    filetype = vim.bo[curbuf].ft,
    buftype = vim.bo[curbuf].bt,
    modified = vim.bo[curbuf].modified,
    fileformat = vim.bo[curbuf].fileformat,
    shiftwidth = vim.bo[curbuf].shiftwidth,
    winhl = vim.wo[curwin].winhl:match(colors.hls.statusline) ~= nil,
  }

  local hls = is_active and colors.hls
    or {
      title = colors.hls.title,
      dimmed = colors.hls.dimmed,
      statusline = colors.hls.statusline_nc,
      statusline_icon = colors.hls.statusline_icon,
      git_rm = colors.hls.git_rm,
      git_add = colors.hls.git_add,
      lsp_info = colors.hls.lsp_info,
      lsp_warn = colors.hls.lsp_warn,
      lsp_err = colors.hls.lsp_err,
      modified = colors.hls.modified,
      recording = colors.hls.recording,
    }

  local file_modified = ctx.modified and (icons.misc.circle or '')

  local lnum, col = unpack(api.nvim_win_get_cursor(curwin))
  col = col + 1 -- account for 0-indexing
  local line_count = api.nvim_buf_line_count(ctx.bufnum)

  local diagnostics = modules.diagnostic_info(ctx)
  local all_clients = modules.stl_lsp_clients(ctx) -- Get all LSP clients

  -- Initialize the table to hold formatted client info
  local lsp_clients = {
    priority = 7,
  }

  for index, client in ipairs(all_clients) do
    -- Determine if this is the last client in the list
    local is_last_client = index == #all_clients
    local client_info = {
      { client.name },
    }

    -- Only add the separator if it's not the last client
    if not is_last_client then table.insert(client_info, { ',', colors.hls.dimmed }) end

    -- Add this client's info, along with its priority, to lsp_clients
    table.insert(lsp_clients, {
      client_info,
      priority = client.priority,
    })
  end

  if #lsp_clients > 0 then table.insert(lsp_clients[1][1], 1, { ' LSP(s): ', hls.metadata }) end

  local path = modules.stl_file(ctx)

  local _, mode_hl = modules.stl_mode()
  local status = vim.b[curbuf].gitsigns_status_dict or {}

  local space = ' '

  local is_unique_file = modules.unique_files[ctx.filetype] ~= nil

  local l1, r1

  if is_unique_file then
    l1 = section:new({
      {
        { modules.unique_files[ctx.filetype].icon, modules.unique_files[ctx.filetype].icon_hl },
        {
          type(modules.unique_files[ctx.filetype].name) == 'function' and modules.unique_files[ctx.filetype].name(ctx.bufname, ctx.bufnum)
            or modules.unique_files[ctx.filetype].name,
          modules.unique_files[ctx.filetype].hl,
        },
      },
      before = '',
      after = '',
      priority = 0,
    })

    r1 = section:new({
      { { space }, { icons.git.branch, hls.lsp_info }, { space }, { status.head, hls.title } },
      priority = 1,
      cond = not falsy(status.head),
    })
  elseif ctx.buftype == 'terminal' then
    -- New section for terminal buffers
    local term_type = vim.fn.fnamemodify(vim.env.SHELL or '', ':t')
    local term_num = vim.b[ctx.bufnum].terminal_job_id or ''
    l1 = section:new({
      { { icons.misc.terminal, hls.title }, { ' Terminal: ', hls.dimmed }, { term_type, hls.title }, { ' #', hls.dimmed }, { term_num, hls.title } },
      priority = 0,
    })
    r1 = section:new()
  else
    l1 = section:new(
      -- { { { icons.misc.vertical_bar, mode_hl } }, priority = 0 },
      {
        {
          { fmt('  %+' .. strwidth(tostring(line_count)) .. 's', lnum), hls.title },
          { ':', hls.dimmed },
          { line_count, hls.dimmed },
        },
        priority = 3,
      },
      {
        {
          { space },
          { modules.search_item(), hls.count },
          { modules.search_count(), hls.dimmed },
        },
        cond = vim.v.hlsearch > 0,
        priority = 3,
      },
      {
        { { fmt('recording: @%s', vim.fn.reg_recording()), hls.recording } },
        cond = vim.fn.reg_recording() ~= '',
        priority = 1,
      },

      path.icon,
      path.parent,
      path.file,
      { { { file_modified, hls.modified } }, cond = ctx.modified, priority = 1 },
      {
        { { diagnostics.warn.icon, hls.lsp_warn }, { space }, { diagnostics.warn.count, hls.lsp_warn } },
        cond = diagnostics.warn.count,
        priority = 3,
      },
      {
        { { diagnostics.error.icon, hls.lsp_err }, { space }, { diagnostics.error.count, hls.lsp_err } },
        cond = diagnostics.error.count,
        priority = 1,
      },
      {
        { { diagnostics.info.icon, hls.lsp_info }, { space }, { diagnostics.info.count, hls.lsp_info } },
        cond = diagnostics.info.count,
        priority = 4,
      },
      {
        { { icons.misc.shaded_lock, hls.dimmed } },
        cond = vim.b[ctx.bufnum].formatting_disabled == true or vim.g.formatting_disabled == true,
        priority = 5,
      }
    )

    r1 = section:new({
      {
        { space },
        { icons.git.branch, hls.lsp_info },
        { space },
        { status.head, hls.title },
      },
      priority = 1,
      cond = not falsy(status.head),
    }, {
      {
        { space },
        { icons.git.remove, hls.git_rm },
        { status.removed, hls.title },
      },
      priority = 1,
      cond = not falsy(status.removed),
    }, {
      {
        { icons.git.add, hls.git_add },
        { status.added, hls.title },
        { space },
      },
      priority = 1,
      cond = not falsy(status.added),
    }, unpack(lsp_clients))
  end

  -- removes 5 columns to add some padding
  return display({ l1, r1 }, available_space - 5)
end

function M.init()
  colors.setup()

  -- :h qf.vim, disable qf statusline
  vim.g.qf_disable_statusline = 1

  -- set the statusline
  vim.o.statusline = "%{%v:lua.require'statusline'.render()%}"

  modules.setup()
end

return M
