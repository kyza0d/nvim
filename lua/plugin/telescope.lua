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

_preview = function()
  return require("telescope.themes").get_ivy({
    layout_config = {
      width = 0.5,
      height = 0.4,
    },

    borderchars = {
      -- prompt = { b.h, b.v, b.h, b.v, b.t_l, b.t_r, b.b_r, b.b_l },
      prompt = { b.h, b.h, b.h, b.v, b.t_l, b.t_r, b.b_r, b.b_l },
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
      -- prompt = { b.h, b.v, b.h, b.v, b.t_l, b.t_r, b.b_r, b.b_l },
      -- results = { b.h, b.v, b.h, b.v, b.v_r, b.v_l, b.b_r, b.b_l },
      -- preview = { b.h, b.v, b.h, b.v, b.t_l, b.t_r, b.b_r, b.b_l },
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
