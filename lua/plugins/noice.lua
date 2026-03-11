return {
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    keys = {
      {
        '<leader>mh',
        function()
          require('noice').cmd 'history'
        end,
        desc = 'Messages History',
      },
      {
        '<leader>ml',
        function()
          require('noice').cmd 'last'
        end,
        desc = 'Messages Last',
      },
      {
        '<leader>md',
        function()
          require('noice').cmd 'dismiss'
        end,
        desc = 'Messages Dismiss',
      },
    },
    opts = {
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },
  },
}
