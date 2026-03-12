return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'mason-org/mason.nvim',
    build = ':MasonUpdate',
    cmd = { 'Mason', 'MasonLog', 'MasonUpdate' },
    opts = {
      ui = {
        border = 'rounded',
        icons = { package_installed = '✓', package_pending = '➜', package_uninstalled = '✗' },
      },
    },
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = { 'mason-org/mason.nvim' },
    event = 'VeryLazy',
    opts = function()
      local servers = require 'config.lsp.servers'
      local tools = require 'config.lsp.tools'
      local lsp_servers = servers.definitions()

      return {
        ensure_installed = tools.ensure_installed(lsp_servers),
        run_on_start = true,
        start_delay = 200,
        debounce_hours = 24,
      }
    end,
  },
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    keys = require('options.keybinds').keys.code,
    dependencies = {
      'mason-org/mason.nvim',
      'mason-org/mason-lspconfig.nvim',
      { 'b0o/schemastore.nvim', ft = { 'json', 'jsonc', 'yaml', 'yml', 'yaml.ansible' } },
    },
    config = function()
      local lsp = require 'config.lsp'
      local attach = require 'config.lsp.attach'
      local diagnostics = require 'config.lsp.diagnostics'
      local mason = require 'config.lsp.mason'
      local servers = require 'config.lsp.servers'
      local capabilities = lsp.get_capabilities()
      local lsp_servers = servers.definitions()

      diagnostics.setup()
      attach.setup()
      servers.setup_gdscript(capabilities)
      mason.setup(capabilities, lsp_servers)
    end,
  },
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = require('options.keybinds').keys.conform,
    opts = function()
      return require('config.lsp.format').opts()
    end,
  },
  {
    'saghen/blink.cmp',
    event = 'InsertEnter',
    version = '1.*',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        event = 'InsertEnter',
        version = '2.*',
        build = function()
          return require('config.lsp.completion').luasnip_build()
        end,
        dependencies = {
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
        opts = {},
      },
      'folke/lazydev.nvim',
    },
    opts = function()
      return require('config.lsp.completion').blink_opts()
    end,
  },
}
