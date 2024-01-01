local M = {}

local icons = require('icons')
local statusline_group = vim.api.nvim_create_augroup('kyza/statusline', { clear = true })

-- Don't show the command that produced the quickfix list.
vim.g.qf_disable_statusline = 1

-- Show the mode in my custom component instead.
vim.opt.showmode = false

--- Keeps track of the highlight groups I've already created.
---@type table<string, boolean>
local statusline_hls = {}
---@param hl string
---@return string
function M.get_or_create_hl(hl, group)
  local hl_name = group .. hl

  if not statusline_hls[hl] then
    -- If not in the cache, create the highlight group using the icon's foreground color
    -- and the statusline's background color.
    local bg_hl = vim.api.nvim_get_hl(0, { name = group })
    local fg_hl = vim.api.nvim_get_hl(0, { name = hl })

    if bg_hl.bg and fg_hl.fg then
      vim.api.nvim_set_hl(0, hl_name, { bg = ('#%06x'):format(bg_hl.bg), fg = ('#%06x'):format(fg_hl.fg) })

      statusline_hls[hl] = true
    end
  end

  return hl_name
end

---Current mode.
---@return string
function M.mode_component()
  local mode_to_str = {
    ['n'] = 'NORMAL',
    ['no'] = 'OP-PENDING',
    ['nov'] = 'OP-PENDING',
    ['noV'] = 'OP-PENDING',
    ['no\22'] = 'OP-PENDING',
    ['niI'] = 'NORMAL',
    ['niR'] = 'NORMAL',
    ['niV'] = 'NORMAL',
    ['nt'] = 'NORMAL',
    ['ntT'] = 'NORMAL',
    ['v'] = 'VISUAL',
    ['vs'] = 'VISUAL',
    ['V'] = 'VISUAL',
    ['Vs'] = 'VISUAL',
    ['\22'] = 'VISUAL',
    ['\22s'] = 'VISUAL',
    ['s'] = 'SELECT',
    ['S'] = 'SELECT',
    ['\19'] = 'SELECT',
    ['i'] = 'INSERT',
    ['ic'] = 'INSERT',
    ['ix'] = 'INSERT',
    ['R'] = 'REPLACE',
    ['Rc'] = 'REPLACE',
    ['Rx'] = 'REPLACE',
    ['Rv'] = 'VIRT REPLACE',
    ['Rvc'] = 'VIRT REPLACE',
    ['Rvx'] = 'VIRT REPLACE',
    ['c'] = 'COMMAND',
    ['cv'] = 'VIM EX',
    ['ce'] = 'EX',
    ['r'] = 'PROMPT',
    ['rm'] = 'MORE',
    ['r?'] = 'CONFIRM',
    ['!'] = 'SHELL',
    ['t'] = 'TERMINAL',
  }

  -- Get the respective string to display.
  local mode = mode_to_str[vim.api.nvim_get_mode().mode] or 'UNKNOWN'

  -- Set the highlight group.
  local hl = 'Other'

  -- stylua: ignore
  if mode:find('NORMAL') then hl = 'Normal'
    elseif mode:find('PENDING') then hl = 'Pending'
    elseif mode:find('VISUAL') then hl = 'Visual'
    elseif mode:find('INSERT') or mode:find('SELECT') then hl = 'Insert'
    elseif mode:find('COMMAND') or mode:find('TERMINAL') or mode:find('EX') then hl = 'Command'
  end

  local current_buf = vim.api.nvim_get_current_buf()
  local filetype = vim.api.nvim_buf_get_option(current_buf, 'filetype')

  if filetype == 'neo-tree' then mode = 'FILES' end
  if filetype == 'TelescopePrompt' then mode = 'SEARCH' end

  local row, col = unpack(vim.api.nvim_win_get_cursor(0))

  -- Construct the bubble-like component.
  return string.format('%%#StatusLineMode%s#▍ %s%%#StatusLineCustom#', hl, mode)
  -- return string.format('%%#StatusLineMode%s# %s%%#StatusLineCustom#', hl, mode)
  -- return string.format('%%#StatusLineMode%s#██ %s %%#StatusLineCustom#', hl, mode)
end

function M.terminal() return ' %{&ft == "toggleterm" ? "[".b:toggle_number."]" : ""}' end

---Git status (if any).
---@return string
function M.git_component()
  local head = vim.b.gitsigns_head
  if not head then return '' end

  return string.format(' %s', head)
end

---@type table<string, string?>
local progress_status = {
  client = nil,
  kind = nil,
  title = nil,
}

vim.api.nvim_create_autocmd('LspProgress', {
  group = vim.api.nvim_create_augroup('kyza/statusline', { clear = true }),
  desc = 'Update LSP progress in statusline',
  pattern = { 'begin', 'end' },
  callback = function(args)
    -- This should in theory never happen, but I've seen weird errors.
    if not args.data then return end

    progress_status = {
      client = vim.lsp.get_client_by_id(args.data.client_id).name,
      kind = args.data.result.value.kind,
      title = args.data.result.value.title,
    }

    if progress_status.kind == 'end' then
      progress_status.title = nil
      -- Wait a bit before clearing the status.
      vim.defer_fn(function() vim.cmd.redrawstatus() end, 3000)
    else
      vim.cmd.redrawstatus()
    end
  end,
})
--- The latest LSP progress message.
---@return string
function M.lsp_progress_component()
  if not progress_status.client or not progress_status.title then return '' end

  return table.concat({
    -- '%#StatusLineSpinner#󱥸  %#StatusLineCustom#',
    '%#StatusLineSpinner#  LSP: %#StatusLineCustom#',
    string.format('%s ', progress_status.client),
    progress_status.title,
  })
end

---Current macro being recorded.
---@return string
function M.macro_recording_component()
  local macro_reg = vim.fn.reg_recording()
  if macro_reg ~= '' then return string.format('%%#StatusLineModeVisual#recording: @%s', macro_reg) end
  return ''
end

local last_diagnostic_component = ''
--- Diagnostic counts in the current buffer.
---@return string
function M.diagnostics_component()
  -- Use the last computed value if in insert mode.
  if vim.startswith(vim.api.nvim_get_mode().mode, 'i') then return last_diagnostic_component end

  local counts = vim.iter(vim.diagnostic.get(0)):fold({
    ERROR = 0,
    WARN = 0,
    HINT = 0,
    INFO = 0,
  }, function(acc, diagnostic)
    local severity = vim.diagnostic.severity[diagnostic.severity]
    acc[severity] = acc[severity] + 1
    return acc
  end)

  local parts = vim.iter.map(function(severity, count)
    if count == 0 then return nil end

    local hl = 'Diagnostic' .. severity:sub(1, 1) .. severity:sub(2):lower()
    return string.format(
      '%%#%s#%s  %d %%#StatusLine#',
      M.get_or_create_hl(hl, 'StatusLine'),
      icons.diagnostics[severity],
      count
    )
  end, counts)

  return table.concat(parts, ' ')
end

function M.filename_component()
  local devicons = require('nvim-web-devicons')
  -- Special icons for some filetypes.
  local special_icons = {
    ['neo-tree'] = { '󰙅  Neotree', 'StatusLine' },
    TelescopePrompt = { '  Telescope', 'StatusLine' },
  }

  local filetype = vim.bo.filetype
  if filetype == '' then filetype = '[No Name]' end

  local icon, icon_hl
  if special_icons[filetype] then
    icon, icon_hl = unpack(special_icons[filetype])
  else
    local buf_name = vim.api.nvim_buf_get_name(0)
    local name, ext = vim.fn.fnamemodify(buf_name, ':t'), vim.fn.fnamemodify(buf_name, ':e')

    -- Check if the buffer is a terminal and extract the shell type
    if vim.startswith(buf_name, 'term://') then
      return fmt('%s %s', icons.filetypes.zsh.icon, vim.opt.shell._info.default)
    end

    icon, icon_hl = devicons.get_icon(name, ext)
    if not icon then
      icon, icon_hl = devicons.get_icon_by_filetype(filetype, { default = true })
    end
  end

  icon_hl = M.get_or_create_hl(icon_hl, 'StatusLine')

  local icon_str = string.format('%%#%s#%s%%#StatusLine#', icon_hl, icon)

  local modified = vim.bo.modified and '%#StatusLineModeInsert# ●%#StatusLine#' or ''

  local parent = vim.fn.expand('%:p:h:t')
  local file = vim.fn.expand('%:p:t')

  if file ~= '' then
    return string.format('%s %s/%s%s', icon_str, parent, file, modified)
  else
    return ''
  end
end

function M.cursor_position_component()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  return string.format('%d:%d', row, col + 1) -- Adjust for 0-based indexing
end

---Renders the statusline.
---@return string
function M.render()
  ---@param components string[]
  ---@return string
  local function concat_components(components)
    local first_component = string.format('%s ', components[1])
    return vim.iter(components):skip(1):fold(
      first_component,
      function(acc, component) return #component > 0 and string.format('%s %s ', acc, component) or acc end
    )
  end

  return table.concat({
    concat_components({
      M.mode_component(),
      M.filename_component(),
      M.macro_recording_component(),
      M.diagnostics_component(),
      M.lsp_progress_component(),
      '%#StatusLineCustom#',

      '%=',
      M.cursor_position_component(), -- Add the position component here
      M.git_component(),
    }),
    ' ',
  })
end

create_autocmd('ColorScheme', {
  callback = function()
    vim.defer_fn(function() vim.cmd.redrawstatus() end, 3000)
    require('statusline').filename_component()
    vim.cmd.redrawstatus()
  end,
  group = statusline_group,
})

return M
