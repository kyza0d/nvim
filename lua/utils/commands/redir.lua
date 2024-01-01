local Input = require('nui.input')
local event = require('nui.utils.autocmd').event

--- Sets up a new buffer with the specified options.
local function setupBuffer()
  vim.cmd('enew')
  vim.bo.buftype = 'nofile'
  vim.bo.bufhidden = 'wipe'
  vim.bo.swapfile = false
end

--- Executes a command and redirects its output to a new buffer.
-- @param cmd The command to execute.
local function redir(cmd)
  local output
  if cmd:match('^!') then
    output = vim.fn.system(cmd:sub(2))
  else
    output = vim.fn.execute(cmd)
  end

  setupBuffer()

  local lines = vim.split(output, '\n')
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.api.nvim_buf_set_lines(0, -1, -1, false, { cmd })
end

--- Opens a NUI Input popup for user input.
local function open_input_popup()
  local popup_options = {
    relative = 'editor',
    position = { row = '93%', col = 0 },
    size = {
      width = 40,
      height = 1,
    },
    buf_options = {
      filetype = 'popup',
    },
    border = {
      style = 'single',
      text = {
        top = '   Redirect Command ',
        top_align = 'left',
      },
    },
  }

  local input = Input(popup_options, {
    prompt = ' ',
    default_value = '',
    on_submit = redir,
  })

  input:mount()

  input:map('n', '<Esc>', function() input:unmount() end, { noremap = true })

  input:on(event.BufLeave, function() input:unmount() end)
end

-- Create a Neovim command to open the input popup
return open_input_popup
