local M = {}

M.close_and_next_quickfix = function()
  local current_buf = vim.api.nvim_get_current_buf()
  local qf_list = vim.fn.getqflist()
  local qf_size = #qf_list
  local current_qf_idx = vim.fn.getqflist({ idx = 0 }).idx
  vim.cmd(fmt('silent %s', current_qf_idx < qf_size and 'cnext' or 'cfirst'))
  local new_buf = vim.api.nvim_get_current_buf()
  if current_buf ~= new_buf then vim.cmd('bdelete ' .. current_buf) end
end

M.close_and_previous_quickfix = function()
  local current_buf = vim.api.nvim_get_current_buf()
  local qf_list = vim.fn.getqflist()
  local qf_size = #qf_list
  local current_qf_idx = vim.fn.getqflist({ idx = 0 }).idx
  if current_qf_idx > 1 then
    vim.cmd('silent cprev')
  else
    vim.cmd('silent clast') -- Loop to the last item if at the beginning
  end
  local new_buf = vim.api.nvim_get_current_buf()
  if current_buf ~= new_buf then vim.cmd('bdelete ' .. current_buf) end
end

return M
