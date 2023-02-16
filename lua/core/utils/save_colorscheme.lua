local cache_dir = vim.fn.stdpath("cache")
local colorscheme_file = cache_dir .. "/colorscheme"

return {
  save = function()
    local file = io.open(colorscheme_file, "w")

    if file == nil then
      return
    end

    file:seek("set")

    local colorscheme = vim.g.colors_name

    file:write(colorscheme)
    file:close()
  end,
  apply = function()
    local file = io.open(colorscheme_file, "r")
    if file then
      local colorscheme = file:read()

      vim.cmd("colorscheme " .. (colorscheme or "default"))
      file:close()
    end
  end,
}
