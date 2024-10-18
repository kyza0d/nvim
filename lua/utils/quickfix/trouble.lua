local qf = {}

-- Trouble
local trouble = require('trouble')

function trouble.next_fold(opts)
  opts = opts or {}
  local current_linenr = vim.api.nvim_win_get_cursor(0)[1]
  local items = trouble.get_items()
  for linenr = current_linenr + 1, vim.api.nvim_buf_line_count(0), 1 do
    if items[linenr] and items[linenr].is_file then
      vim.api.nvim_win_set_cursor(0, { linenr, vim.api.nvim_win_get_cursor(0)[2] })

      if opts.jump then trouble.action('jump') end

      return
    end
  end
end

function trouble.previous_fold(opts)
  opts = opts or {}
  local current_linenr = vim.api.nvim_win_get_cursor(0)[1]
  local items = trouble.get_items()
  for linenr = current_linenr - 1, 0, -1 do
    if items[linenr] and items[linenr].is_file then
      vim.api.nvim_win_set_cursor(0, { linenr, vim.api.nvim_win_get_cursor(0)[2] })

      if opts.jump then trouble.action('jump') end

      return
    end
  end
end

return trouble
