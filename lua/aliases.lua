function _G.abbreviate_or_noop(input, output)
  if vim.fn.getcmdtype() == ":" and vim.fn.getcmdline() == input then
    return output
  else
    return input
  end
end

local function alias_command(input, output)
  vim.api.nvim_command("cabbrev <expr> " .. input .. " " .. "v:lua.abbreviate_or_noop('" .. input .. "', '" .. output .. "')")
end

alias_command("w", "silent w")
-- alias_command("q", "silent Bdelete")
-- alias_command("q!", "silent Bdelete!")
