local strwidth, falsy = vim.api.nvim_strwidth, ky.falsy

---@alias StringComponent {component: string, length: integer, priority: integer}

local M = {}

local padding = ' '

---@return StringComponent
local function separator() return { component = '%=', length = 0, priority = 0 } end

--- Creates a spacer statusline component i.e. for padding
--- or to represent an empty component
--- @param size integer?
--- @param opts table<string, any>?
--- @return ComponentOpts?
function M.spacer(size, opts)
  opts = opts or {}
  local filler = opts.filler or ' '
  local priority = opts.priority or 0
  if not size or size < 1 then return end
  local spacer = string.rep(filler, size)
  return { { { spacer } }, priority = priority, before = '', after = '' }
end

--- truncate with an ellipsis or if surrounded by quotes, replace contents of quotes with ellipsis
--- @param str string
--- @param max_size integer
--- @return string
local function truncate_str(str, max_size)
  if not max_size or strwidth(str) < max_size then return str end
  local match, count = str:gsub('([\'"]).*%1', '%1…%1')
  return count > 0 and match or str:sub(1, max_size - 1) .. '…'
end

---@alias Chunks {[1]: string | number, [2]: string, max_size: integer?}[]

---@param chunks Chunks
---@return string
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

--- @class ComponentOpts
--- @field [1] Chunks
--- @field priority number
--- @field click string
--- @field before string
--- @field after string
--- @field id number
--- @field max_size integer
--- @field cond boolean | number | table | string,

--- @param opts ComponentOpts
--- @return StringComponent?
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
  -- if there hasn't been a lowest selected so far, then the item is the lowest
  if not lowest then return true end
  if not lowest.length then return true end

  -- if the item doesn't have a priority or a length, it is likely a special character so should never be the lowest
  if not item.priority or not item.length then return false end

  -- if the item has the same priority as the lowest, then if the item has a greater length it should become the lowest
  if item.priority == lowest.priority then return item.length > lowest.length end
  return item.priority > lowest.priority
end

--- Take the lowest priority items out of the statusline if we don't have
--- space for them.
--- @param statusline table
--- @param space number
--- @param length number
local function prioritize(statusline, space, length)
  length = length or sum_lengths(statusline)
  if length <= space then return statusline end
  local lowest, index_to_remove
  for idx, c in ipairs(statusline) do
    if is_lowest(c, lowest) then
      lowest, index_to_remove = c, idx
    end
  end
  table.remove(statusline, index_to_remove)
  return prioritize(statusline, space, length - lowest.length)
end

--- @param sections ComponentOpts[][]
--- @param available_space number?
--- @return string
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
  -- if editor.zen_mode then str[1] = fmt('%s', str[1]) end
  str[1] = fmt('%s', str[1])
  return table.concat(str)
end

--- A helper class that allow collecting `...StringComponent`
--- into sections that can then be added to each other
--- i.e.
--- ```lua
--- section1:new(1, 2, 3) + section2:new(4, 5, 6) + section3(7, 8, 9)
--- {1, 2, 3, 4, 5, 6, 7, 8, 9} -- <--
--- ```
---@class Section
---@field __add fun(l:Section, r:Section): StringComponent[]
---@field __index Section
---@field new fun(...:StringComponent[]): Section
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

-- Title casings
-- Title casings
function M.title(word)
  -- Check if the word is not nil or empty
  if word == nil or word == '' then return word end

  -- Convert the first character to uppercase and the rest to lowercase
  -- Pattern "%a" matches letters; "%l" matches lowercase letters
  local function title_case_word(w) return w:sub(1, 1):upper() .. w:sub(2):lower() end

  -- Apply title casing to each word in the input
  -- Pattern "%S+" matches one or more non-space characters, which we treat as a word
  local result = word:gsub('%S+', title_case_word)

  return result
end

return M
