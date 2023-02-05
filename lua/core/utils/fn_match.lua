return function(filename, command)
  if string.find(vim.fn.expand("%"), filename) then
    vim.cmd(command)
  end
end
