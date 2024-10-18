--- Required modules
local Menu = require('nui.menu')
local event = require('nui.utils.autocmd').event

--- Generates a winhighlight string from a highlight table.
--- @param highlight table: A table containing highlight groups.
--- @return string: A concatenated string of winhighlight options.
local function make_winhighlight(highlight)
  return table.concat(vim.tbl_map(function(key) return string.format('%s:%s', key, highlight[key]) end, vim.tbl_keys(highlight)), ',')
end

local winhighlight = make_winhighlight({
  CursorLine = 'PmenuSel',
})

--- Processes the selected menu item's action.
--- @param item table: The selected menu item.
local function process_menu_action(item)
  if item.action.command then
    vim.lsp.buf.execute_command(item.action.command)
  elseif item.action.edit or item.action.command == nil then
    vim.lsp.util.apply_workspace_edit(item.action.edit, 'utf-8')
  end
end

--- Prepares menu items from a response.
--- @param response table: A response containing code actions.
--- @return table: A list of menu items.
local function prepare_menu_items(response)
  local items = {}
  for i, action in ipairs(response) do
    if action.title then table.insert(items, Menu.item(string.format(' %s. %s ', i, action.title), { action = action })) end
  end
  return items
end

--- Displays the menu with the given items.
--- @param menu_items table: A list of items to display in the menu.
local function display_menu(menu_items)
  local menu = Menu({
    relative = 'cursor',
    position = {
      row = 2,
      col = 1,
    },
    size = {
      height = #menu_items,
    },
    buf_options = {
      filetype = 'nui-menu',
    },
    win_options = {
      winhighlight = winhighlight,
    },
    border = {
      style = 'single',
      text = {
        top = '   Code Actions ',
        top_align = 'left',
      },
    },
  }, {
    lines = menu_items,
    on_submit = function(item) process_menu_action(item) end,
  })

  -- Mount the component
  menu:mount()

  -- Unmount the component when cursor leaves the buffer
  menu:on(event.BufLeave, function() menu:unmount() end)
end

--- Fetches diagnostics for the current line and shows code actions.
local function show_code_actions()
  local params = vim.lsp.util.make_range_params()
  params.context = { diagnostics = vim.lsp.diagnostic.get_line_diagnostics() }

  vim.lsp.buf_request(0, 'textDocument/codeAction', params, function(err, response)
    if err then
      print('Error when fetching code actions: ' .. err.message)
      return
    end
    if response == nil or vim.tbl_isempty(response) then
      print('No code actions available')
      return
    end

    local menu_items = prepare_menu_items(response)

    display_menu(menu_items)
  end)
end

return show_code_actions
