if not ky then return end

local function general_overrides()
  local xeno = require('xeno').colors

  hl.all({
    { StatusLineTerm = { bg = { from = '@base.700' } } },
    { MiniIconsGrey = { fg = { from = '@base.500' } } },
  })
end

augroup('kyza/highlights', {
  event = 'ColorScheme',
  command = function() general_overrides() end,
})
