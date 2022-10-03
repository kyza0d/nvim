local status_ok, dap = pcall(require, "dap")

if not status_ok then
  return
end

require("dap").set_log_level("DEBUG")

local datapath = vim.fn.stdpath("data")

dap.adapters = {
  nlua = function(callback, config)
    -- callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8080 })
    callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8080 })
  end,
  firefox = {
    type = "executable",
    command = "node",
    args = { datapath .. "/mason/packages/firefox-debug-adapter/dist/adapter.bundle.js" },
  },
  python = {
    type = "executable",
    command = "python",
    args = { "-m", "debugpy.adapter" },
  },
}

dap.configurations = {
  lua = {
    {
      type = "nlua",
      request = "attach",
      name = "Attach to running Neovim instance",
      host = function()
        local value = vim.fn.input("Host [127.0.0.1]: ")
        if value ~= "" then
          return value
        end
        return "127.0.0.1"
      end,
      port = function()
        local val = tonumber(vim.fn.input("Port: "))
        assert(val, "Please provide a port number")
        return val
      end,
    },
  },
  typescriptreact = {
    {
      name = "Debug with Firefox",
      type = "firefox",
      request = "launch",
      reAttach = true,
      url = "http://localhost:3000",
      webRoot = "${workspaceFolder}",
      firefoxExecutable = "/usr/bin/firefox",
    },
  },
  python = {
    {
      type = "python",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      pythonPath = function()
        return "python"
      end,
    },
  },
}

keymap("n", "<F1>", [[:lua require"dap.ui.widgets".hover()<CR>]], { noremap = true })
-- keymap("n", "<C-]>", [[:lua require'dap'.step_over()<CR>]], { noremap = true })
-- keymap("n", "<C-[>", [[:lua require'dap'.step_back()<CR>]], { noremap = true })

require("dapui").setup({
  icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
  -- layouts = {
  --   {
  --     elements = {
  --       "scopes",
  --     },
  --     size = 10,
  --     position = "bottom",
  --   },
  -- },
  controls = {
    enabled = false,
  },
})
