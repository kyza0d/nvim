return {
  strategy = 'inline',
  description = 'Refine existing copy for clarity, tone, or SEO',
  opts = {
    index = 2,
    is_slash_cmd = true,
    auto_submit = false,
    short_name = 'refine',
    placement = 'replace',
  },
  prompts = {
    {
      role = 'system',
      content = [[You are an expert copywriting editor. Refine the provided copy for clarity, professional tone, and SEO optimization (if applicable). Suggest improvements and return the refined copy in a markdown code block. Provide a brief explanation of changes.]],
      opts = { visible = false },
    },
    {
      role = 'user',
      content = function(context)
        local text = require('codecompanion.helpers.actions').get_code(context.start_line, context.end_line)
        return string.format(
          [[Refine this copy for clarity, professional tone, and SEO optimization:\n\n```%s\n%s\n```\n\nExplain changes briefly, then provide the refined copy in a markdown code block.]],
          context.filetype,
          text
        )
      end,
      opts = { contains_code = true },
    },
  },
}
