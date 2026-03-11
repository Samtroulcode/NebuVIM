return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'canary',
    dependencies = {
      'github/copilot.vim',
      'nvim-lua/plenary.nvim',
    },
    opts = {
      -- UI
      window = {
        layout = 'vertical', -- split vertical
        width = 0.35, -- 35% de l’écran
      },
      -- historique
      history_path = vim.fn.stdpath 'data' .. '/copilotchat_history.json',
      clear_chat_on_new_prompt = false, -- conserve l’historique
      -- contexte
      context = {
        buffer = true,
        selection = true,
      },
      -- personnalisations de prompts
      prompts = {
        Brainstorm = {
          prompt = 'Brainstorm des idées de design, d’architecture ou de solutions techniques.',
        },
      },
    },
    keys = require('options.keybinds').keys.copilot,
  },
  {
    'github/copilot.vim',
  },
}
