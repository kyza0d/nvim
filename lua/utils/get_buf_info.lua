return function(bufnr)
  return vim.fn.getbufinfo(bufnr)[1]
end
