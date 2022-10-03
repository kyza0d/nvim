local status_ok, telescope = pcall(require, "telescope")

if not status_ok then
  return
end

require("utils.layout").dropdown()

dropdown = function()
  return require("telescope.themes").get_ivy({
    layout_config = {
      width = 0.5,
      height = 0.4,
    },

    borderchars = {
      prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
      preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    },

    layout_strategy = "dropdown",
    preview = false,
  })
end

require("utils.layout").bottom_borders()

bottom_borders = function()
  return require("telescope.themes").get_ivy({
    layout_config = {
      width = 0.3,
      height = 0.4,
    },

    borderchars = {
      prompt = { "─", "│", "─", "│", "┌", "┬", "┘", "└" },
      results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
      preview = { "─", "│", "─", "│", "┤", "┐", "┘", "└" },
    },

    layout_strategy = "bottom_borders",
    preview = false,
  })
end

require("utils.layout").pager()

pager = function()
  return require("telescope.themes").get_ivy({
    borderchars = {
      prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
      preview = { "─", "│", "─", "│", "┤", "┤", "┘", "└" },
    },

    layout_strategy = "pager",
    preview = false,
  })
end

sublime = function()
  return require("telescope.themes").get_ivy({
    layout_config = {
      width = 0.5,
      height = 0.4,
    },

    borderchars = {
      prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
      preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    },

    layout_strategy = "sublime",
    preview = false,
  })
end

telescope.setup({
  defaults = {
    sorting_strategy = "ascending",
    selection_caret = " ",
    prompt_prefix = " ",
    entry_prefix = " ",
    -- path_display = { "smart" },

    layout_config = {
      width = 0.99,
      height = 0.4,
    },

    -- layout_strategy = "pager",
    layout_strategy = "bottom_borders",

    borderchars = {
      prompt = { "─", "│", "─", "│", "┌", "┬", "┘", "└" },
      results = { "─", "│", "─", "│", "├", "┤", "┴", "└" },
      preview = { "─", "│", "─", "│", "┤", "┐", "┘", "└" },
    },

    preview_title = "",
    prompt_title = "",
    results_title = "",

    file_ignore_patterns = { "node_modules", "package-lock.json", "yarn.lock", "dist" },
  },
})

keymap("n", "<C-p>", ':lua require("telescope.builtin").find_files(pager())<cr>')
keymap("n", "?", ":Telescope live_grep<cr>")
