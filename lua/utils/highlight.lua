local api = vim.api
local notify = vim.notify
local fmt = string.format

local M = {}

local attrs = {
  fg = true,
  bg = true,
  sp = true,
  blend = true,
  bold = true,
  italic = true,
  standout = true,
  underline = true,
  undercurl = true,
  underdouble = true,
  underdotted = true,
  underdashed = true,
  strikethrough = true,
  reverse = true,
  nocombine = true,
  link = true,
  default = true,
  force = true,
}

local function get_hl_as_hex(opts, ns)
  ns, opts = ns or 0, opts or {}
  opts.link = opts.link ~= nil and opts.link or false
  local hl = api.nvim_get_hl(ns, opts)
  hl.fg = hl.fg and ('#%06x'):format(hl.fg)
  hl.bg = hl.bg and ('#%06x'):format(hl.bg)
  return hl
end

function M.tint(color, percent)
  assert(color and percent, 'Cannot alter a color without specifying a color and percentage')
  local r, g, b = tonumber(color:sub(2, 3), 16), tonumber(color:sub(4, 5), 16), tonumber(color:sub(6), 16)
  if not r or not g or not b then return 'NONE' end
  local blend = function(component) return math.min(math.max(math.floor(component * (1 + percent)), 0), 255) end
  return fmt('#%02x%02x%02x', blend(r), blend(g), blend(b))
end

function M.blend(colors, percent)
  assert(colors and #colors > 0 and percent, 'Must specify colors and percentage')
  local totalR, totalG, totalB = 0, 0, 0
  for _, color in ipairs(colors) do
    local r, g, b = tonumber(color:sub(2, 3), 16), tonumber(color:sub(4, 5), 16), tonumber(color:sub(6, 7), 16)
    if not r or not g or not b then return 'NONE' end
    totalR, totalG, totalB = totalR + r, totalG + g, totalB + b
  end
  local avgR, avgG, avgB = totalR / #colors, totalG / #colors, totalB / #colors
  return M.tint(fmt('#%02x%02x%02x', avgR, avgG, avgB), percent)
end

-- In lua/utils/highlight.lua, modify the get function around line 64
-- In lua/utils/highlight.lua, replace the get function with this safer version
local warned_highlights = {} -- Cache to prevent repeated warnings

function M.get(group, attribute, fallback)
  assert(group, 'Cannot get a highlight without specifying a group name')
  local data = get_hl_as_hex({ name = group })
  if not attribute then return data end
  assert(attrs[attribute], fmt('The attribute passed in is invalid: %s', attribute))
  local color = data[attribute] or fallback
  if not color then
    -- Create a unique key for this warning to prevent spam
    local warn_key = group .. ':' .. attribute
    if not warned_highlights[warn_key] then
      warned_highlights[warn_key] = true
      -- Only warn once per highlight/attribute combination
      -- vim.schedule(function() vim.notify(fmt('Color not found for highlight %s with attribute %s', group, attribute), vim.log.levels.WARN) end)
    end
    return 'NONE'
  end
  return color
end

local function resolve_from_attribute(hl, attr)
  if type(hl) ~= 'table' or not hl.from then return hl end
  local colour = M.get(hl.from, hl.attr or attr)
  return hl.alter and M.tint(colour, hl.alter) or colour
end

function M.set(ns, name, opts)
  if type(ns) == 'string' and type(name) == 'table' then
    opts, name, ns = name, ns, 0
  end
  vim.validate({ opts = { opts, 'table' }, name = { name, 'string' }, ns = { ns, 'number' } })
  local hl = opts.clear and {} or get_hl_as_hex({ name = opts.inherit or name })
  
  -- Automatically add force = true if not specified
  if opts.force == nil then
    opts.force = true
  end
  
  for attribute, hl_data in pairs(opts) do
    if attrs[attribute] then hl[attribute] = resolve_from_attribute(hl_data, attribute) end
  end
  ky.pcall(fmt('Setting highlight "%s"', name), api.nvim_set_hl, ns, name, hl)
end

function M.all(hls, namespace)
  ky.foreach(function(hl) M.set(namespace or 0, next(hl)) end, hls)
end

function M.set_winhl(name, win_id, hls)
  local namespace = api.nvim_create_namespace(name)
  M.all(hls, namespace)
  api.nvim_win_set_hl_ns(win_id, namespace)
end

local function add_theme_overrides(theme)
  local res, seen = {}, {}
  local list = vim.list_extend(theme[vim.g.colors_name] or {}, theme['*'] or {})
  for _, hl in ipairs(list) do
    local n = next(hl)
    if not seen[n] then res[#res + 1] = hl end
    seen[n] = true
  end
  return res
end

function M.plugin(name, opts)
  if opts.theme then
    opts = add_theme_overrides(opts.theme)
    if not next(opts) then return end
  end
  M.all(opts)
  augroup(fmt('%sHighlightOverrides', name:gsub('^%l', string.upper)), {
    event = 'ColorScheme',
    command = function()
      vim.defer_fn(function() M.all(opts) end, 1)
    end,
  })
end

return M

-- References:
-- https://github.com/akinsho/dotfiles/blob/6f071329ab6e7846f44f105cdb1e67679fdd58c1/.config/nvim/lua/as/highlights.lua
