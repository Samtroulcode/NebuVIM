return {
  -- {
  --   'CopilotC-Nvim/CopilotChat.nvim',
  --   branch = 'canary',
  --   dependencies = {
  --     'github/copilot.vim',
  --     'nvim-lua/plenary.nvim',
  --   },
  --   opts = {
  --     -- UI
  --     window = {
  --       layout = 'vertical', -- split vertical
  --       width = 0.35, -- 35% de l’écran
  --     },
  --     -- historique
  --     history_path = vim.fn.stdpath 'data' .. '/copilotchat_history.json',
  --     clear_chat_on_new_prompt = false, -- conserve l’historique
  --     -- contexte
  --     context = {
  --       buffer = true,
  --       selection = true,
  --     },
  --     -- personnalisations de prompts
  --     prompts = {
  --       Brainstorm = {
  --         prompt = 'Brainstorm des idées de design, d’architecture ou de solutions techniques.',
  --       },
  --     },
  --   },
  --   keys = {
  --     { '<leader>cc', '<cmd>CopilotChatToggle<cr>', desc = 'CopilotChat Toggle' },
  --     { '<leader>ce', '<cmd>CopilotChatExplain<cr>', desc = 'CopilotChat Explain' },
  --     { '<leader>cf', '<cmd>CopilotChatFix<cr>', desc = 'CopilotChat Fix' },
  --     { '<leader>cb', '<cmd>CopilotChat Brainstorm<cr>', desc = 'CopilotChat Brainstorm' },
  --   },
  -- },
  -- Copilot official plugin (désactivé pour tester Supermaven)
  -- {
  --   'github/copilot.vim',
  -- },

  -- Supermaven - alternative open-source à Copilot
  {
    'supermaven-inc/supermaven-nvim',
    config = function()
      require('supermaven-nvim').setup {
        keymaps = {
          accept_suggestion = '<Tab>', -- identique à Copilot
          clear_suggestion = '<C-]>',
          accept_word = '<C-j>',
        },
        ignore_filetypes = {
          -- ajoutez les filetypes à ignorer si besoin
        },
        color = {
          suggestion_color = '#808080',
          cterm = 244,
        },
        log_level = 'info',
        disable_inline_completion = false,
        disable_keymaps = false,
      }
    end,
  },
}
