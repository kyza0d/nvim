local M = {}

M.get_buf_info = function(bufnr)
  return vim.fn.getbufinfo(bufnr)[1]
end

M.keymap = function(modes, key, cmd, opts)
  local default_opts = { noremap = true, silent = true, nowait = true }

  opts = opts or {}

  opts = vim.tbl_deep_extend("keep", {}, opts, default_opts or {})

  local keymap
  if type(cmd) == "function" then
    keymap = vim.keymap.set
  else
    keymap = vim.api.nvim_set_keymap
  end

  if type(cmd) == "string" and string.sub(cmd, 1, 1) == ":" then
    cmd = cmd .. "<cr>"
  end

  if type(modes) == "table" then
    for _, mode in pairs(modes) do
      keymap(mode, key, cmd, opts)
    end
  else
    keymap(modes, key, cmd, opts)
  end
end

M.switch = function(var, options)
  if options[var] then
    return options[var]
  else
    return options.default
  end
end

-- stylua: ignore
M.getvar = function(var)
  local config = require("configs")

  if var == "borders" then
    local function read_chars(context)
      local chars = M.switch(config.borders[context], {
        ["none"] = { "", "", "", "", "", "", "", "", "", "" },
        ["padded"] = { " ", " ", " ", " ", " ", " ", " ", " ", " ", " " },
        ["single"] = { "┌", "┐", "└", "┘", "─", "│", "├", "┤", "┴", "┬" },
        ["rounded"] = { "╭", "╮", "╰", "╯", "─", "│", "├", "┤", "┴", "┬" },
      })

      return {
        t_l = chars[1], -- t_l: top left
        t_r = chars[2], -- t_r: top right

        b_l = chars[3], -- b_l: bottom left
        b_r = chars[4], -- b_r: bottom right

        v   = chars[6], -- v: vertical
        v_r = chars[7], -- v_r: vertical right
        v_l = chars[8], -- v_l: vertical left

        h   = chars[5], -- h: horizontal
        h_t = chars[9], -- h_t: horizontal top
        h_b = chars[10], -- h_b: horizontal bottom
      }
    end

    return {
      float = read_chars("telescope"),
      telescope = read_chars("telescope"),
      completion = read_chars("completion"),
    }

  elseif var == "icons" then
    local icon_table = {}

    for _, icon in ipairs(config.icons) do
      icon_table[ icon[2] ] = config.show_icons and icon[1] or " "
    end
    return icon_table
  end
end

M.fn_match = function(filename, command)
  if string.find(vim.fn.expand("%"), filename) then
    vim.cmd(command)
  end
end

M.workspace_root = function()
  local root = vim.fn.getcwd()
  local workspace = root:sub(root:find("[^/]*$"))
  if workspace == "evan" then
    workspace = "~"
  end
  return workspace
end

return M
