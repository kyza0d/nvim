-- TODO: Clean this file up

local tc_utils = {}

local resolve = require("telescope.config.resolve")
local p_window = require("telescope.pickers.window")
local if_nil = vim.F.if_nil

local calc_tabline = function(max_lines)
  local tbln = (vim.o.showtabline == 2) or (vim.o.showtabline == 1 and #vim.api.nvim_list_tabpages() > 1)
  if tbln then
    max_lines = max_lines - 1
  end
  return max_lines, tbln
end

local get_border_size = function(opts)
  if opts.window.border == false then
    return 0
  end

  return 1
end

local adjust_pos = function(pos, ...)
  for _, opts in ipairs({ ... }) do
    opts.col = opts.col and opts.col + pos[1]
    opts.line = opts.line and opts.line + pos[2]
  end
end

local calc_size_and_spacing = function(cur_size, max_size, bs, w_num, b_num, s_num)
  local spacing = s_num * (1 - bs) + b_num * bs
  cur_size = math.min(cur_size, max_size)
  cur_size = math.max(cur_size, w_num + spacing)
  return cur_size, spacing
end

function tc_utils.custom_dropdown()
  require("telescope.pickers.layout_strategies").custom_dropdown = function(self, max_columns, max_lines, layout_config)
    local initial_options = p_window.get_initial_window_options(self)
    local preview = initial_options.preview
    local results = initial_options.results
    local prompt = initial_options.prompt

    layout_config = {
      anchor = "S",
      width = 0.5,
      height = 0.5,
      preview_cutoff = 20,
      prompt_position = "top",
    }

    local tbln
    max_lines, tbln = calc_tabline(max_lines)

    -- This sets the width for the whole layout
    local width_opt = layout_config.width
    local width = resolve.resolve_width(width_opt)(self, max_columns, max_lines)

    -- This sets the height for the whole layout
    local height_opt = layout_config.height
    local height = resolve.resolve_height(height_opt)(self, max_columns, max_lines)

    local bs = get_border_size(self)

    local w_space
    -- Cap over/undersized width
    width, w_space = calc_size_and_spacing(width, max_columns, bs, 1, 2, 0)

    prompt.width = width - w_space
    results.width = width - w_space
    preview.width = width - w_space

    local h_space
    -- Cap over/undersized height
    height, h_space = calc_size_and_spacing(height, max_lines, bs, 2, 3, 0)

    prompt.height = 1
    results.height = height - prompt.height - h_space

    -- local topline = math.floor((max_lines / 2) - ((results.height + (2 * bs)) / 2) + 1)
    local topline = math.floor((max_lines / 18) - ((results.height + (2 * bs)) / 2) + 1)
    -- Align the prompt and results so halfway up the screen is
    -- in the middle of this combined block
    if layout_config.prompt_position == "top" then
      prompt.line = topline
      results.line = prompt.line + 1 + bs
    elseif layout_config.prompt_position == "bottom" then
      results.line = topline
      prompt.line = results.line + results.height + bs
      if type(prompt.title) == "string" then
        prompt.title = { { pos = "S", text = prompt.title } }
      end
    else
      error(string.format("Unknown prompt_position: %s\n%s", self.window.prompt_position, vim.inspect(layout_config)))
    end

    local width_padding = math.floor((max_columns - width) / 2) + bs + 1
    results.col, preview.col, prompt.col = width_padding, width_padding, width_padding

    local anchor = layout_config.anchor or ""
    local anchor_pos = resolve.resolve_anchor_pos(anchor, width, height, max_columns, max_lines)
    adjust_pos(anchor_pos, prompt, results, preview)

    -- Vertical anchoring (S or N variations) ignores layout_config.mirror
    anchor = anchor:upper()
    local mirror
    if anchor:find("S") then
      mirror = false
    elseif anchor:find("N") then
      mirror = true
    else
      mirror = layout_config.mirror
    end

    -- Set preview position
    local block_line = math.min(results.line, prompt.line)
    if not mirror then -- Preview at top
      preview.line = 1 + bs
      preview.height = block_line - (2 + 2 * bs)
    else -- Preview at bottom
      preview.line = block_line + results.height + 2 + 2 * bs
      preview.height = max_lines - preview.line - bs + 1
    end

    if not (self.previewer and max_lines >= layout_config.preview_cutoff) then
      preview.height = 0
    end

    if tbln then
      prompt.line = prompt.line + 1
      results.line = results.line + 1
      preview.line = preview.line + 1
    end

    return {
      preview = self.previewer and preview.height > 0 and preview,
      results = results,
      prompt = prompt,
    }
  end
end

return tc_utils

