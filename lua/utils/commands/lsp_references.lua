-- FIX: handle case where the reference is in a different file

--- Required modules
local Menu = require('nui.menu')
local event = require('nui.utils.autocmd').event

--- Generates a winhighlight string from a highlight table.
--- @param highlight table: A table containing highlight groups.
--- @return string: A concatenated string of winhighlight options.
local function make_winhighlight(highlight)
  return table.concat(
    vim.tbl_map(function(key) return string.format('%s:%s', key, highlight[key]) end, vim.tbl_keys(highlight)),
    ','
  )
end

local winhighlight = make_winhighlight({
  CursorLine = 'PmenuSel',
})

--- Updates the cursor position in the original buffer.
--- @param ref table: A table containing the file path, line, and column.
--- @param origin_bufnr number: The buffer number of the original buffer.
--- @param origin_winid number: The window ID of the original buffer.
local function update_cursor_in_origin_buffer(ref, origin_bufnr, origin_winid)
  if ref.file_path and ref.line and ref.col then
    -- Check buffer validity
    if not vim.api.nvim_buf_is_valid(origin_bufnr) then
      print('Invalid buffer ID:', origin_bufnr)
      return
    end

    local current_file_path = vim.api.nvim_buf_get_name(origin_bufnr)
    if vim.fn.fnamemodify(current_file_path, ':p') ~= vim.fn.fnamemodify(ref.file_path, ':p') then
      -- The file is different, open it in the original window
      vim.api.nvim_set_current_win(origin_winid)
      vim.cmd('edit ' .. ref.file_path)
    end

    -- Update the cursor position
    local line_count = vim.api.nvim_buf_line_count(origin_bufnr)
    if ref.line - 1 <= line_count then
      local line = vim.api.nvim_buf_get_lines(origin_bufnr, ref.line - 1, ref.line, false)[1] or ''
      local line_length = string.len(line)
      local adjusted_col = (line_length > 0 and math.min(ref.col - 1, line_length - 1)) or 0
      vim.api.nvim_win_set_cursor(origin_winid, { ref.line - 1, adjusted_col })
    else
      print('Reference is outside the buffer.')
    end
  end
end

-- Global variable to store the last highlighted word's namespace ID
local last_highlight_ns_id = nil

--- Highlights the word at the specified position in a buffer.
--- @param bufnr number: The buffer number.
--- @param line number: The line number (0-indexed).
--- @param col number: The column number (0-indexed).
local function highlight_word_at_position(bufnr, line, col)
  -- Clear the previous highlight
  if last_highlight_ns_id then vim.api.nvim_buf_clear_namespace(bufnr, last_highlight_ns_id, 0, -1) end

  -- Create a new namespace for the highlight
  last_highlight_ns_id = vim.api.nvim_create_namespace('')

  -- Get the line text
  local line_text = vim.api.nvim_buf_get_lines(bufnr, line, line + 1, true)[1]
  if not line_text then return end

  -- Find the start and end of the word under the cursor
  local word_start, word_end = line_text:find('%w+', col + 1)
  if not word_start then return end

  -- Adjust for 0-indexing
  word_start = word_start - 1
  word_end = word_end -- Keep the word_end as it is, Lua string.find returns the end index inclusively

  -- Add highlight to the word
  vim.api.nvim_buf_add_highlight(bufnr, last_highlight_ns_id, 'IncSearch', line, word_start, word_end)
end

--- Clears the highlights in the specified buffer.
--- @param bufnr number: The buffer number.
local function clear_highlights(bufnr)
  if last_highlight_ns_id then
    vim.api.nvim_buf_clear_namespace(bufnr, last_highlight_ns_id, 0, -1)
    last_highlight_ns_id = nil
  end
end

--- Prepares menu items from LSP references response and creates a mapping.
--- @param response table: A response containing LSP references.
--- @return table: A list of menu items.
local function prepare_menu_items(response)
  local items = {}
  display_text_to_file_path = {} -- Reset the mapping
  for i, ref in ipairs(response) do
    local filename = ref.uri:match('([^/]+)$')
    local display_text = string.format(' %d. %s:%d:%d ', i, filename, ref.range.start.line, ref.range.start.character)
    table.insert(items, Menu.item(display_text))
    display_text_to_file_path[display_text] = vim.uri_to_fname(ref.uri) -- Map display text to full file path
  end
  return items
end

--- Parses file path, line, and column from the menu item string.
--- @param item_str string: The menu item string.
--- @return table: A table containing the file path, line, and column.
local function parse_reference_from_item(item_str)
  local pattern = '(%d+). %S+:(%d+):(%d+)'
  local _, line, col = string.match(item_str, pattern)
  local file_path = display_text_to_file_path[item_str]
  return { file_path = file_path, line = tonumber(line), col = tonumber(col) }
end

--- Parses file path, line, and column from the menu item string.
--- [parse_reference_from_item function remains the same]

--- Navigates to the given reference location.
--- @param ref table: A table containing the file path, line, and column.
--- @param origin_bufnr number: The buffer number from which the menu was invoked.
local function navigate_to_reference(ref, origin_bufnr)
  if ref.file_path and ref.line and ref.col then
    -- Switch to the original buffer
    vim.api.nvim_set_current_buf(origin_bufnr)
    -- Open the file
    vim.cmd('edit ' .. ref.file_path)
    -- Move cursor to the specified location
    vim.api.nvim_win_set_cursor(0, { ref.line + 1, ref.col })
  end
end

--- Displays the menu with the given items.
--- @param menu_items table: A list of items to display in the menu.
local function display_menu(menu_items)
  local origin_bufnr = vim.api.nvim_get_current_buf()
  local origin_winid = vim.api.nvim_get_current_win()
  local menu = Menu({
    relative = 'editor',
    position = { row = '90%', col = '90%' },
    size = {
      width = 40,
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
        top = '   LSP References ',
        top_align = 'left',
      },
    },
  }, {
    lines = menu_items,
    on_submit = function(item) navigate_to_reference(parse_reference_from_item(item.text), origin_bufnr) end,
  })

  -- Mount the component
  menu:mount()

  -- Unmount the component when cursor leaves the buffer
  menu:on(event.BufLeave, function()
    clear_highlights(origin_bufnr)
    menu:unmount()
  end)

  menu:on(event.CursorMoved, function()
    local line_num = vim.api.nvim_win_get_cursor(menu.winid)[1]
    local item_str = menu_items[line_num].text
    local ref = parse_reference_from_item(item_str)
    update_cursor_in_origin_buffer(ref, origin_bufnr, origin_winid)

    -- Highlight the word at the cursor position in the original buffer
    highlight_word_at_position(origin_bufnr, ref.line, ref.col)
  end)
end

--- Fetches LSP references for the current symbol and shows them.
local function show_lsp_references()
  local params = vim.lsp.util.make_position_params()
  params.context = { includeDeclaration = true }

  vim.lsp.buf_request(0, 'textDocument/references', params, function(err, response)
    if err then
      vim.notify('Error when fetching LSP references: ' .. err.message, vim.log.levels.ERROR)
      return
    end
    if response == nil or vim.tbl_isempty(response) then
      print('No LSP references available')
      return
    end

    local menu_items = prepare_menu_items(response)

    display_menu(menu_items)
  end)
end

return show_lsp_references
