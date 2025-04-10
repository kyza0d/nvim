local diagnostic = vim.diagnostic
local S = vim.diagnostic.severity
local icons = ky.ui.icons

local ns = vim.api.nvim_create_namespace('diagnostic')

--- Restricts nvim's diagnostic signs to only the single most severe one per line
--- see `:help vim.diagnostic`
---@param callback fun(namespace: integer, bufnr: integer, diagnostics: table, opts: table)
---@return fun(namespace: integer, bufnr: integer, diagnostics: table, opts: table)
local function max_diagnostic(callback)
  return function(_, bufnr, diagnostics, opts)
    local max_severity_per_line = vim.iter(diagnostics):fold({}, function(diag_map, d)
      local m = diag_map[d.lnum]
      if not m or d.severity < m.severity then diag_map[d.lnum] = d end
      return diag_map
    end)
    callback(ns, bufnr, vim.tbl_values(max_severity_per_line), opts)
  end
end

local signs_handler = diagnostic.handlers.signs
diagnostic.handlers.signs = vim.tbl_extend('force', signs_handler, {
  show = max_diagnostic(signs_handler.show),
  hide = function(_, bufnr) signs_handler.hide(ns, bufnr) end,
})

local max_width = math.min(math.floor(vim.o.columns * 0.7), 100)
local max_height = math.min(math.floor(vim.o.lines * 0.3), 30)

diagnostic.config({
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  signs = {
    severity = { min = S.WARN },
    text = {
      [S.WARN] = icons.warn,
      [S.INFO] = icons.info,
      [S.HINT] = icons.hint,
      [S.ERROR] = icons.error,
    },
    linehl = {
      [S.WARN] = 'DiagnosticSignWarnLine',
      [S.INFO] = 'DiagnosticSignInfoLine',
      [S.HINT] = 'DiagnosticSignHintLine',
      [S.ERROR] = 'DiagnosticSignErrorLine',
    },
  },
  virtual_text = false and {
    severity = { min = S.WARN },
    spacing = 1,
    prefix = function(d)
      local level = diagnostic.severity[d.severity]
      return icons[level:lower()]
    end,
  },
  float = {
    max_width = max_width,
    max_height = max_height,
    title = { { '  ', 'DiagnosticFloatTitleIcon' }, { 'Problems  ', 'DiagnosticFloatTitle' } },
    focusable = true,
    scope = 'cursor',
    source = 'if_many',
    prefix = function(diag)
      local level = diagnostic.severity[diag.severity]
      local prefix = fmt('%s ', icons[level:lower()])
      return prefix, 'Diagnostic' .. level:gsub('^%l', string.upper)
    end,
  },
})
