local M = {}

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

M.get_tmux_session = function()
  if vim.env.TMUX then
    local session = vim.fn.system('tmux display-message -p "#{session_name}" 2>/dev/null')
    if vim.v.shell_error ~= 0 then return '' end
    return session:gsub('\n', '')
  end
  return ''
end

M.on_load = function(name, fn)
  local Config = require('lazy.core.config')
  if Config.plugins[name] and Config.plugins[name]._.loaded then
    fn(name)
  else
    vim.api.nvim_create_autocmd('User', {
      pattern = 'LazyLoad',
      callback = function(event)
        if event.data == name then
          fn(name)
          return true
        end
      end,
    })
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
