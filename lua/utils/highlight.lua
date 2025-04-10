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

local function err_warn(group, attribute)
  notify(fmt('Failed to get highlight %s for attribute %s\n%s', group, attribute, debug.traceback()), 'ERROR', {
    title = fmt('Highlight - get(%s)', group),
  })
end

function M.get(group, attribute, fallback)
  assert(group, 'Cannot get a highlight without specifying a group name')
  local data = get_hl_as_hex({ name = group })
  if not attribute then return data end
  assert(attrs[attribute], fmt('The attribute passed in is invalid: %s', attribute))
  local color = data[attribute] or fallback
  if not color then
    if vim.v.vim_did_enter == 0 then
      api.nvim_create_autocmd('User', {
        pattern = 'LazyDone',
        once = true,
        callback = function() err_warn(group, attribute) end,
      })
    else
      vim.schedule(function() err_warn(group, attribute) end)
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
  ky.augroup(fmt('%sHighlightOverrides', name:gsub('^%l', string.upper)), {
    event = 'ColorScheme',
    command = function()
      vim.defer_fn(function() M.all(opts) end, 1)
    end,
  })
end

M.vivid_blend_hsl = function(fg, bg, alpha, saturation_boost)
  saturation_boost = saturation_boost or 1.7 -- Default saturation boost
  alpha = math.min(math.max(alpha, 0), 1)

  -- Extract RGB components
  local fg_r, fg_g, fg_b = tonumber(string.sub(fg, 2, 3), 16), tonumber(string.sub(fg, 4, 5), 16), tonumber(string.sub(fg, 6, 7), 16)

  local bg_r, bg_g, bg_b = tonumber(string.sub(bg, 2, 3), 16), tonumber(string.sub(bg, 4, 5), 16), tonumber(string.sub(bg, 6, 7), 16)

  -- Convert foreground to HSL (simplified conversion for this example)
  local max = math.max(fg_r, fg_g, fg_b) / 255
  local min = math.min(fg_r, fg_g, fg_b) / 255
  local delta = max - min
  local l = (max + min) / 2
  local s = delta == 0 and 0 or delta / (1 - math.abs(2 * l - 1))
  local h = 0

  if delta ~= 0 then
    if max == fg_r / 255 then
      h = ((fg_g / 255 - fg_b / 255) / delta) % 6
    elseif max == fg_g / 255 then
      h = (fg_b / 255 - fg_r / 255) / delta + 2
    else
      h = (fg_r / 255 - fg_g / 255) / delta + 4
    end
    h = h * 60
    if h < 0 then h = h + 360 end
  end

  -- Increase saturation
  s = math.min(1, s * saturation_boost)

  -- Convert back to RGB (simplified conversion)
  local function hue_to_rgb(p, q, t)
    if t < 0 then t = t + 1 end
    if t > 1 then t = t - 1 end
    if t < 1 / 6 then return p + (q - p) * 6 * t end
    if t < 1 / 2 then return q end
    if t < 2 / 3 then return p + (q - p) * (2 / 3 - t) * 6 end
    return p
  end

  local q = l < 0.5 and l * (1 + s) or l + s - l * s
  local p = 2 * l - q
  local r = hue_to_rgb(p, q, (h / 360 + 1 / 3) % 1) * 255
  local g = hue_to_rgb(p, q, (h / 360) % 1) * 255
  local b = hue_to_rgb(p, q, (h / 360 - 1 / 3) % 1) * 255

  -- Blend with background
  local blended_r = math.floor(r * alpha + bg_r * (1 - alpha))
  local blended_g = math.floor(g * alpha + bg_g * (1 - alpha))
  local blended_b = math.floor(b * alpha + bg_b * (1 - alpha))

  return string.format('#%02x%02x%02x', blended_r, blended_g, blended_b)
end

return M
