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
    keys = {
      { '<leader>cc', '<cmd>CopilotChatToggle<cr>', desc = 'CopilotChat Toggle' },
      { '<leader>ce', '<cmd>CopilotChatExplain<cr>', desc = 'CopilotChat Explain' },
      { '<leader>cf', '<cmd>CopilotChatFix<cr>', desc = 'CopilotChat Fix' },
      { '<leader>cb', '<cmd>CopilotChat Brainstorm<cr>', desc = 'CopilotChat Brainstorm' },
    },
  },
  -- Copilot official plugin
  {
    'github/copilot.vim',
    cmd = 'Copilot',
    event = 'InsertEnter',
    init = function()
      vim.g.copilot_no_maps = true
    end,
    config = function()
      -- Block the normal Copilot suggestions
      vim.api.nvim_create_augroup('github_copilot', { clear = true })
      vim.api.nvim_create_autocmd({ 'FileType', 'BufUnload' }, {
        group = 'github_copilot',
        callback = function(args)
          vim.fn['copilot#On' .. args.event]()
        end,
      })
      vim.fn['copilot#OnFileType']()
    end,
  },
}
