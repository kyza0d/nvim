local strwidth, falsy = vim.api.nvim_strwidth, ky.falsy

local M = {}

local padding = ' '

local function separator() return { component = '%=', length = 0, priority = 0 } end

function M.spacer(size, opts)
  opts = opts or {}
  local filler = opts.filler or ' '
  local priority = opts.priority or 0
  if not size or size < 1 then return end
  local spacer = string.rep(filler, size)
  return { { { spacer } }, priority = priority, before = '', after = '' }
end

local function truncate_str(str, max_size)
  if not max_size or strwidth(str) < max_size then return str end
  local match, count = str:gsub('([\'"]).*%1', '%1…%1')
  return count > 0 and match or str:sub(1, max_size - 1) .. '…'
end

local function chunks_to_string(chunks)
  if not chunks or not vim.islist(chunks) then return '' end
  local strings = ky.fold(function(acc, item)
    local text, hl = unpack(item)
    if not falsy(text) then
      if type(text) ~= 'string' then text = tostring(text) end
      if item.max_size then text = truncate_str(text, item.max_size) end
      text = text:gsub('%%', '%%%1')
      table.insert(acc, not falsy(hl) and ('%%#%s#%s%%*'):format(hl, text) or text)
    end
    return acc
  end, chunks)
  return table.concat(strings)
end

local function component(opts)
  assert(opts, 'component options are required')
  if opts.cond ~= nil and falsy(opts.cond) then return end

  local item = opts[1]
  if not vim.islist(item) then error(fmt('component options are required but got %s instead', vim.inspect(item))) end

  if not opts.priority then opts.priority = 10 end
  local before, after = opts.before or '', opts.after or padding

  local item_str = chunks_to_string(item)
  if strwidth(item_str) == 0 then return end

  local component_str = table.concat({ before, item_str, after })
  return {
    component = component_str,
    length = vim.api.nvim_eval_statusline(component_str, { maxwidth = 0 }).width,
    priority = opts.priority,
  }
end

local function sum_lengths(list)
  return ky.fold(function(acc, item) return acc + (item.length or 0) end, list, 0)
end

local function is_lowest(item, lowest)
  if not item.priority or not item.length then return false end
  if not lowest then return true end
  if not lowest.priority or not lowest.length then return true end

  if item.priority == lowest.priority then return item.length > lowest.length end
  return item.priority > lowest.priority
end

local function prioritize(statusline, space, length)
  length = length or sum_lengths(statusline)
  if length <= space then return statusline end

  local lowest, index_to_remove
  for idx, c in ipairs(statusline) do
    if is_lowest(c, lowest) then
      lowest, index_to_remove = c, idx
    end
  end

  -- If no component can be removed, return an empty statusline or the current one
  if not lowest or not index_to_remove then
    return {} -- or return statusline to keep remaining components
  end

  table.remove(statusline, index_to_remove)
  return prioritize(statusline, space, length - lowest.length)
end

function M.display(sections, available_space)
  local components = ky.fold(function(acc, section, count)
    if #section == 0 then
      table.insert(acc, separator())
      return acc
    end
    ky.foreach(function(args, index)
      if not args then return end
      local ok, str = ky.pcall('Error creating component', component, args)
      if not ok then return end
      table.insert(acc, str)
      if #section == index and count ~= #sections then table.insert(acc, separator()) end
    end, section)
    return acc
  end, sections)

  local items = available_space and prioritize(components, available_space) or components
  local str = vim.tbl_map(function(item) return item.component end, items)
  str[1] = fmt('%s', str[1])
  return table.concat(str)
end

local section = {}
function section:new(...)
  local o = { ... }
  self.__index = self
  self.__add = function(l, r)
    local rt = { unpack(l) }
    for _, v in ipairs(r) do
      rt[#rt + 1] = v
    end
    return rt
  end
  return setmetatable(o, self)
end
M.section = section

function M.title(word)
  if word == nil or word == '' then return word end

  local function title_case_word(w) return w:sub(1, 1):upper() .. w:sub(2):lower() end
  local result = word:gsub('%S+', title_case_word)
  return result
end

return M
