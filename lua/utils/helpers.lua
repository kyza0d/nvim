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

M.redir_to_buffer = function(command, buffer_name)
  buffer_name = buffer_name or '[Output]'

  local output = vim.fn.execute(command)

  vim.cmd('new')
  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_name(buf, buffer_name)
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
  vim.api.nvim_buf_set_option(buf, 'swapfile', false)

  local lines = vim.split(output, '\n')
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)
end

return M
