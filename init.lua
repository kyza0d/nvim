vim.g.start_time = vim.fn.reltime()

require("core.configs")
require("core.keymaps")
require("core.plugins")
require("core.autocmds")

function _G.reload_nvim()
  for name, _ in pairs(package.loaded) do
    if name:match("^core") then
      -- Neovim tree will send a notification when setup is called twice
      if not name:match("nvim_tree") then
        package.loaded[name] = nil
      end
    end
  end

  dofile(vim.env.MYVIMRC)
end
