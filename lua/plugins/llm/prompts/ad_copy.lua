return {
  strategy = 'chat',
  description = 'Generate creative ad copy based on a client brief',
  opts = {
    index = 1,
    is_slash_cmd = true,
    auto_submit = false,
    short_name = 'adcopy',
  },
  references = {
    {
      type = 'file',
      path = { '~/copywriting/projects/*/Briefs/brief.md' },
    },
  },
  prompts = {
    {
      role = 'system',
      content = [[You are a senior copywriter specializing in persuasive ad copy. Craft engaging, accurate, and audience-targeted content based on the provided brief. Consider tone, audience, and campaign goals. Explain your approach briefly before delivering the copy in a markdown code block.]],
      opts = { visible = false },
    },
    {
      role = 'user',
      content = function(context)
        local brief_path = vim.fn.glob('~/copywriting/projects/*/briefs/brief.md')
        local brief = brief_path ~= '' and require('codecompanion.helpers.actions').get_code(1, -1, brief_path) or 'No brief found.'
        return string.format(
          [[Based on this brief, generate ad copy for a campaign:\n\n```markdown\n%s\n```\n\nExplain your approach, then provide the ad copy in a markdown code block.]],
          brief
        )
      end,
      opts = {
        contains_code = true,
        auto_submit = false,
      },
    },
  },
}
