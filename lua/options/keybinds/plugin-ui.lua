-- UI and interaction keymaps exposed to plugin specs.
-- These bindings keep visual toggles and message tools out of code-specific modules.

return {
  scratch = {
    { '<leader>bs', function() Snacks.scratch() end, desc = 'Buffer Scratch Toggle' },
    { '<leader>bS', function() Snacks.scratch.select() end, desc = 'Buffer Scratch Select' },
  },
  bufferline = {
    { '<leader>bP', '<cmd>BufferLinePick<CR>', desc = 'Buffer Pick' },
    { '<leader>bh', '<cmd>BufferLineCloseLeft<CR>', desc = 'Buffer Close Left' },
    { '<leader>bl', '<cmd>BufferLineCloseRight<CR>', desc = 'Buffer Close Right' },
    { '<leader>bH', '<cmd>BufferLineMovePrev<CR>', desc = 'Buffer Move Left' },
    { '<leader>bL', '<cmd>BufferLineMoveNext<CR>', desc = 'Buffer Move Right' },
  },
  copilot = {
    { '<leader>cc', '<cmd>CopilotChatToggle<CR>', desc = 'Code Toggle Chat' },
    { '<leader>ce', '<cmd>CopilotChatExplain<CR>', desc = 'Code Explain' },
    { '<leader>cf', '<cmd>CopilotChatFix<CR>', desc = 'Code Fix With AI' },
    { '<leader>cb', '<cmd>CopilotChat Brainstorm<CR>', desc = 'Code Brainstorm' },
  },
  noice = {
    { '<leader>mh', function() require('noice').cmd 'history' end, desc = 'Messages History' },
    { '<leader>ml', function() require('noice').cmd 'last' end, desc = 'Messages Last' },
    { '<leader>md', function() require('noice').cmd 'dismiss' end, desc = 'Messages Dismiss' },
  },
  zen = {
    { '<leader>tz', function() Snacks.zen() end, desc = 'Toggle Zen Mode' },
  },
  render_markdown = {
    { '<leader>tm', '<cmd>RenderMarkdown toggle<CR>', desc = 'Toggle Markdown Render' },
  },
}
