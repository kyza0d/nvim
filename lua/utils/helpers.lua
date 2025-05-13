local M = {}

M.join = function(...)
  local args = { ... }
  return table.concat(args)
end

function M.augroup(name, ...)
  local commands = { ... }
  assert(name ~= 'User', 'The name of an augroup CANNOT be User')
  assert(#commands > 0, fmt('You must specify at least one autocommand for %s', name))
  local id = api.nvim_create_augroup(name, { clear = true })
  for _, autocmd in ipairs(commands) do
    api.nvim_create_autocmd(autocmd.event, {
      group = name,
      pattern = autocmd.pattern,
      desc = autocmd.desc,
      callback = type(autocmd.command) == 'function' and autocmd.command or nil,
      command = type(autocmd.command) ~= 'function' and autocmd.command or nil,
      once = autocmd.once,
      nested = autocmd.nested,
      buffer = autocmd.buffer,
    })
  end
  return id
end

M.visual_selection = function()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg('v')
  vim.fn.setreg('v', {})

  text = string.gsub(text, '\n', '')
  if #text > 0 then
    return text
  else
    return ''
  end
end

M.create_journal_entry = function(directory)
  local date = os.date('%Y-%m-%d')
  local title = vim.fn.input(fmt('%s', directory))
  local sanitized_title = string.gsub(title, '%s+', '-')
  local filepath = fmt('%s/Notes/Journal/%s%s-%s.md', os.getenv('HOME'), directory, date, sanitized_title)
  vim.api.nvim_command('edit ' .. filepath)
  if vim.fn.filereadable(vim.fn.expand(filepath)) == 0 then vim.api.nvim_command('ObsidianTemplate default') end
end

return M
