local pickers = {}

local telescope_utils = require('telescope.utils')
local make_entry = require('telescope.make_entry')
local mini_icons = require('mini.icons')
local entry_display = require('telescope.pickers.entry_display')

-- Use a default icon width (you may need to adjust this value)
local fileTypeIconWidth = 3

function pickers.getPathAndTail(fileName)
  local bufferNameTail = telescope_utils.path_tail(fileName)
  local pathWithoutTail = require('plenary.strings').truncate(fileName, #fileName - #bufferNameTail, '')

  local pathToDisplay = telescope_utils.transform_path({ path_display = { 'truncate' } }, pathWithoutTail)
  return bufferNameTail, pathToDisplay
end

local function getFileIcon(filename)
  -- Try to get icon for the specific filename
  local icon, hl = mini_icons.get('file', filename)

  -- If no specific icon, try to get icon for the file extension
  if icon == nil then
    local ext = filename:match('^.+%.(.+)$')
    if ext then
      icon, hl = mini_icons.get('extension', ext)
    end
  end

  -- If still no icon, fallback to default file icon
  if icon == nil then
    icon, hl = mini_icons.get('default', 'file')
  end

  return icon, hl
end

function pickers.open(pickerAndOptions)
  local options = pickerAndOptions.options or {}
  local picker = pickerAndOptions.picker
  local originalEntryMaker = make_entry.gen_from_file(options)

  -- Separate Telescope options from picker-specific options
  local telescopeOptions = vim.tbl_extend('force', {}, options)
  telescopeOptions.entry_maker = function(line)
    local originalEntryTable = originalEntryMaker(line)
    local displayer = entry_display.create({
      separator = '',
      items = {
        { width = fileTypeIconWidth },
        { width = nil },
        { remaining = true },
      },
    })

    originalEntryTable.display = function(entry)
      local tail, pathToDisplay = pickers.getPathAndTail(entry.value)
      local tailForDisplay = tail .. ' '
      local icon, hl = getFileIcon(tail)

      return displayer({
        { icon, hl },
        tailForDisplay,
        { pathToDisplay, 'TelescopeResultsComment' },
      })
    end

    return originalEntryTable
  end

  -- Ensure cwd is properly passed to the Telescope builtin
  if options.cwd then telescopeOptions.cwd = options.cwd end

  require('telescope.builtin')[picker](telescopeOptions)
end
function pickers.prettyGrepPicker(pickerAndOptions)
  local options = pickerAndOptions.options or {}
  local originalEntryMaker = make_entry.gen_from_vimgrep(options)

  options.entry_maker = function(line)
    local originalEntryTable = originalEntryMaker(line)
    local displayer = entry_display.create({
      separator = '',
      items = {
        { width = fileTypeIconWidth },
        { width = nil },
        { width = nil },
        { remaining = true },
      },
    })

    originalEntryTable.display = function(entry)
      local tail, pathToDisplay = pickers.getPathAndTail(entry.filename)
      local icon, hl = getFileIcon(tail)
      local tailForDisplay = tail .. ' '
      local text = options.file_encoding and vim.iconv(entry.text, options.file_encoding, 'utf8') or entry.text

      return displayer({
        { icon, hl },
        tailForDisplay,
        { pathToDisplay, 'TelescopeResultsComment' },
        text,
      })
    end

    return originalEntryTable
  end

  require('telescope.builtin')[pickerAndOptions.picker](options)
end

function pickers.symbols(localOptions)
  local options = localOptions or {}
  local originalEntryMaker = make_entry.gen_from_lsp_symbols(options)

  options.entry_maker = function(line)
    local originalEntryTable = originalEntryMaker(line)
    local displayer = entry_display.create({
      separator = '',
      items = {
        { width = fileTypeIconWidth },
        { width = 20 },
        { remaining = true },
      },
    })

    originalEntryTable.display = function(entry)
      local icon, hl = mini_icons.get('lsp', entry.symbol_type:lower())
      return displayer({
        { icon, hl },
        { entry.symbol_type:lower(), 'TelescopeResultsVariable' },
        { entry.symbol_name, 'TelescopeResultsConstant' },
      })
    end

    return originalEntryTable
  end

  require('telescope.builtin').lsp_document_symbols(options)
end

function pickers.prettyWorkspaceSymbols(localOptions)
  local options = localOptions or {}
  local originalEntryMaker = make_entry.gen_from_lsp_symbols(options)

  options.entry_maker = function(line)
    local originalEntryTable = originalEntryMaker(line)
    local displayer = entry_display.create({
      separator = '',
      items = {
        { width = fileTypeIconWidth },
        { width = 15 },
        { width = 30 },
        { width = nil },
        { remaining = true },
      },
    })

    originalEntryTable.display = function(entry)
      local tail, _ = pickers.getPathAndTail(entry.filename)
      local tailForDisplay = tail .. ' '
      local pathToDisplay = telescope_utils.transform_path({
        path_display = { shorten = { num = 2, exclude = { -2, -1 } }, 'truncate' },
      }, entry.value.filename)

      local icon, hl = mini_icons.get('lsp', entry.symbol_type:lower())

      return displayer({
        { icon, hl },
        { entry.symbol_type:lower(), 'TelescopeResultsVariable' },
        { entry.symbol_name, 'TelescopeResultsConstant' },
        tailForDisplay,
        { pathToDisplay, 'TelescopeResultsComment' },
      })
    end

    return originalEntryTable
  end

  require('telescope.builtin').lsp_dynamic_workspace_symbols(options)
end

return pickers
