if vim.g.colors_name then
  ky.save_cache('colorscheme', vim.g.colors_name)
else
  -- Here, you can set a default colorscheme to save into the cache
  -- if no colorscheme is set at the time this script runs.
  -- Replace 'default_colorscheme' with the actual name of the default colorscheme.
  ky.save_cache('colorscheme', 'default')
end

local function set_colorscheme()
  local colorscheme = ky.load_cache('colorscheme', 'default')
  if colorscheme == nil then return end
  vim.cmd('colorscheme ' .. colorscheme)
end

return {
  set_colorscheme = set_colorscheme,
}
