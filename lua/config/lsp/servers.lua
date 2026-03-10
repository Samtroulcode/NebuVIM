local M = {}

local function project_python()
  local cwd = vim.fn.getcwd()
  local venv_python = cwd .. '/.venv/bin/python'
  if vim.fn.executable(venv_python) == 1 then
    return venv_python
  end
end

function M.definitions()
  return {
    basedpyright = {
      settings = {
        python = {
          analysis = {
            typeCheckingMode = 'standard',
            autoImportCompletions = true,
            useLibraryCodeForTypes = true,
          },
          pythonPath = project_python(),
        },
      },
    },
    yamlls = {
      settings = {
        yaml = {
          keyOrdering = false,
          format = { enable = false },
          schemas = require('schemastore').yaml.schemas(),
          validate = true,
        },
      },
    },
    ruff = {
      on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
      end,
      init_options = {
        settings = {
          args = {},
        },
      },
    },
    lua_ls = {
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
            path = vim.split(package.path, ';'),
          },
          completion = {
            callSnippet = 'Replace',
          },
          diagnostics = {
            disable = { 'missing-fields' },
            globals = { 'vim', 'love' },
          },
          telemetry = { enable = false },
          hint = { enable = true },
        },
      },
    },
    vtsls = {
      settings = {
        typescript = {
          tsserver = { maxTsServerMemory = 4096 },
          preferences = { includeCompletionsForModuleExports = true },
          format = { enable = false },
        },
        javascript = { format = { enable = false } },
      },
    },
    svelte = {
      on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
      end,
    },
    html = {
      init_options = { provideFormatter = false },
    },
    cssls = {
      settings = {
        css = { validate = true },
        scss = { validate = true },
        less = { validate = true },
      },
    },
    tailwindcss = {},
    eslint = {
      settings = {
        codeAction = { disableRuleComment = { enable = true }, showDocumentation = { enable = true } },
        workingDirectory = { mode = 'auto' },
      },
    },
    emmet_language_server = {
      filetypes = {
        'html',
        'css',
        'scss',
        'less',
        'sass',
        'javascriptreact',
        'typescriptreact',
        'javascript',
        'typescript',
        'svelte',
      },
      init_options = {
        showSuggestionsAsSnippets = true,
      },
    },
    jsonls = {
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
          validate = { enable = true },
        },
      },
    },
    hyprls = {},
  }
end

function M.setup_gdscript(capabilities)
  vim.lsp.config('gdscript', {
    capabilities = capabilities,
  })
  vim.lsp.enable 'gdscript'
end

return M
