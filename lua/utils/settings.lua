local M = {}

--- Configure filetype-specific settings
--- @param configs table Filetype configurations
function M.setup(configs)
  for filetypes, config in pairs(configs) do
    local ft_list = type(filetypes) == 'table' and filetypes or { filetypes }

    for _, ft in ipairs(ft_list) do
      local group = vim.api.nvim_create_augroup('settings_' .. ft, { clear = true })

      if config.options then
        vim.api.nvim_create_autocmd('FileType', {
          group = group,
          pattern = ft,
          callback = function()
            for key, value in pairs(config.options) do
              vim.opt_local[key] = value
            end
          end,
        })
      end
    end
  end
end

return M
