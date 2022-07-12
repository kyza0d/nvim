-- TODO: Clean this file up
--

local tc_utils = {}

local resolve = require("telescope.config.resolve")
local p_window = require("telescope.pickers.window")
local if_nil = vim.F.if_nil

local calc_tabline = function(max_lines)
  local tbln = (vim.o.showtabline == 2) or (vim.o.showtabline == 1 and #vim.api.nvim_list_tabpages() > 1)
  if tbln then
    max_lines = max_lines
  end
  return max_lines, tbln
end

local get_border_size = function(opts)
  if opts.window.border == false then
    return 0
  end

  return 1
end

local calc_size_and_spacing = function(cur_size, max_size, bs, w_num, b_num, s_num)
  local spacing = s_num * (1 - bs) + b_num * bs
  cur_size = math.min(cur_size, max_size)
  cur_size = math.max(cur_size, w_num + spacing)
  return cur_size, spacing
end

function tc_utils.bottom_borders()
  require("telescope.pickers.layout_strategies").bottom_borders = function(self, max_columns, max_lines, layout_config)
    local initial_options = p_window.get_initial_window_options(self)
    local results = initial_options.results
    local prompt = initial_options.prompt
    local preview = initial_options.preview

    layout_config = {
      anchor = "S",
      width = 0.99,
      height = 0.4,
      preview_cutoff = 20,
      prompt_position = "top",
    }

    local tbln
    max_lines, tbln = calc_tabline(max_lines)

    local width_opt = layout_config.width
    local width = resolve.resolve_width(width_opt)(self, max_columns, max_lines)

    local height_opt = layout_config.height
    local height = resolve.resolve_height(height_opt)(self, max_columns, max_lines)

    prompt.border = results.border

    local bs = get_border_size(self)

    -- Cap over/undersized height
    height, _ = calc_size_and_spacing(height, max_lines, bs, 2, 3, 0)

    -- Height
    prompt.height = 1
    results.height = height - prompt.height
    preview.height = results.height + prompt.height - 1

    -- Width
    local w_space

    if self.previewer and max_columns >= layout_config.preview_cutoff then
      -- Cap over/undersized width (with preview)
      width, w_space = calc_size_and_spacing(max_columns, max_columns, bs, 2, 4, 0)

      preview.width = resolve.resolve_width(if_nil(layout_config.preview_width, 0.6))(self, width, max_lines)
      results.width = width - preview.width - w_space
      prompt.width = results.width + 1
      results.width = results.width + 1
    else
      width, w_space = calc_size_and_spacing(width, max_columns, bs, 1, 2, 0)
      preview.width = 0
      results.width = width
      prompt.width = results.width
    end

    -- Line
    prompt.line = max_lines - results.height - (1 + bs) + 1
    results.line = prompt.line
    preview.line = prompt.line + 1
    if results.border == true then
      results.border = { 1, 1, 1, 1 }
    end
    local width_padding = math.floor((max_columns - width) / 2)

    -- Col
    prompt.col = 0 -- centered
    if layout_config.mirror and preview.width > 0 then
      results.col = preview.width + (3 * bs)
      preview.col = bs + 1
      prompt.col = results.col
    else
      preview.col = prompt.width + width_padding + bs + 1
      results.col = bs + 1
      prompt.col = preview.col + preview.width + bs
    end

    if tbln then
      -- prompt.line = prompt.line + 1
      results.line = results.line + 1
      preview.line = preview.line
      prompt.line = prompt.line
    else
      results.line = results.line + 1
    end
    prompt.line = prompt.line + 1
    results.line = results.line + 2

    preview.col = preview.col + 1
    prompt.col = 2
    results.col = 2

    results.height = results.height - 2

    return {
      preview = self.previewer and preview.width > 0 and preview,
      prompt = prompt,
      results = results,
    }
  end
end

return tc_utils
