local status_ok, telescope = pcall(require, "telescope")

if not status_ok then
  return
end

local actions = require("telescope.actions")
local create_autocmd = vim.api.nvim_create_autocmd

local b = require("utils").getvar("borders").telescope

local keymaps = {
  i = {
    ["<C-l>"] = actions.select_vertical,
    ["<C-j>"] = actions.select_horizontal,
    ["<ESC>"] = actions.close,
  },
}

telescope.setup({
  defaults = {
    sorting_strategy = "ascending",
    selection_caret = " ",
    prompt_prefix = " ",
    entry_prefix = " ",
    path_display = { "smart" },
    mappings = keymaps,
    file_ignore_patterns = { "node_modules", "package-lock.json", "yarn.lock" },
  },
})

require("plugin.telescope_layouts").setup()

PREVIEW = function()
  return require("telescope.themes").get_ivy({
    layout_config = {
      width = 0.5,
      height = 0.4,
    },

    borderchars = {
      prompt = { b.h, b.v, b.h, b.v, b.t_l, b.t_r, b.b_r, b.b_l },
      preview = { b.h, b.v, b.h, b.v, b.h_b, b.t_r, b.b_r, b.b_l },
      results = { b.h, b.v, b.h, b.v, b.v_r, b.v_l, b.h_t, b.b_l },
    },

    layout_strategy = "bottom_borders",

    preview_title = "",
    prompt_title = "",
    results_title = "",
  })
end

DROPDOWN = function()
  return require("telescope.themes").get_ivy({
    layout_config = {
      width = 0.5,
      height = 0.4,
    },

    borderchars = {
      prompt = { b.h, b.v, b.h, b.v, b.t_l, b.t_r, b.b_r, b.b_l },
      results = { b.h, b.v, b.h, b.v, b.v_r, b.v_l, b.b_r, b.b_l },
      preview = { b.h, b.v, b.h, b.v, b.t_l, b.t_r, b.b_r, b.b_l },
    },

    preview = false,

    layout_strategy = "custom_dropdown",

    preview_title = "",
    -- prompt_title = "",
    prompt_title = "",
    results_title = "",
  })
end

CMD_LINE = function()
  return require("telescope.themes").get_ivy({
    layout_config = {
      width = 0.5,
      height = 0.2,
    },

    borderchars = {

      prompt = { b.h, b.v, b.h, b.v, b.h, b.t_r, b.b_r, b.b_l },
      results = { b.h, "", b.h, "", b.h, b.h, b.h, b.b_l },
      preview = { b.h, b.v, b.h, b.v, b.t_l, b.t_r, b.b_r, b.b_l },
    },

    sorting_strategy = "descending",

    preview = false,

    layout_strategy = "cmd_line",

    preview_title = "",
    -- prompt_title = "",
    prompt_title = "",
    results_title = "",
  })
end

IVY = function()
  vim.cmd([[resize -20]])
  -- vim.opt.shortmess = ""

  local shift = vim.api.nvim_create_augroup("Resize", {
    clear = true,
  })

  local input = true

  create_autocmd("BufEnter", {
    desc = "Telescope ivy",
    callback = function()
      input = not input
      if input then
        vim.cmd([[silent! resize +20]])
        vim.cmd([[silent! norm :]])
        vim.cmd([[silent! set cmdheight=0]])
        vim.api.nvim_del_augroup_by_name("Resize")
      end
    end,
    group = shift,
  })

  return require("telescope.themes").get_dropdown({
    layout_config = {
      width = 0.8,
      height = 0.5,
    },

    layout_strategy = "horizontal_split",

    borderchars = {
      prompt = { b.h, b.v, b.h, b.v, b.t_l, b.t_r, b.b_r, b.b_l },
      preview = { b.h, b.v, b.h, b.v, b.h_b, b.t_r, b.b_r, b.b_l },
      results = { b.h, b.v, b.h, b.v, b.v_r, b.v_l, b.h_t, b.b_l },
    },

    sorting_strategy = "ascending",

    preview = false,

    preview_title = "",
    prompt_title = "",
    results_title = "",
  })
end
