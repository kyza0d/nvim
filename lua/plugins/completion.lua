--------------------------------------------
-- Completion
--------------------------------------------

return {
  -- Completion menu
  --- @url https://github.com/hrsh7th/nvim-cmp
  {
    'hrsh7th/nvim-cmp',
    -- event = { 'CmdlineEnter', 'InsertEnter' },
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-emoji',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'lukas-reineke/cmp-rg',
      'uga-rosa/cmp-dictionary',
    },
    config = function() require('config.nvim-cmp') end,
  },

  -- Snippet engine
  --- @url https://github.com/L3MON4D3/LuaSnip
  {
    'L3MON4D3/LuaSnip',
    dependencies = { 'rafamadriz/friendly-snippets', 'saadparwaiz1/cmp_luasnip' },
  },

  -- AI completion
  --- @url https://github.com/github/copilot.vim
  {
    'github/copilot.vim',
    -- event = 'InsertEnter',
    init = function()
      vim.g.copilot_filetypes = true
      vim.g.copilot_filetypes = {
        ['*'] = true,
        TelescopePrompt = false,
      }
    end,
  },

  -- ChatGPT integration
  --- @url https://github.com/jackMort/ChatGPT.nvim
  {
    'jackMort/ChatGPT.nvim',
    -- event = 'VeryLazy',
    config = function() require('chatgpt').setup() end,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
  },
}
