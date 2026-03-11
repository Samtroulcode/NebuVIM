local M = {}

local web_filetypes = {
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
}

local function project_python(root_dir)
  local venv_python = root_dir .. '/.venv/bin/python'
  if vim.fn.executable(venv_python) == 1 then
    return venv_python
  end
end

local function disable_formatting(client)
  client.server_capabilities.documentFormattingProvider = false
end

function M.definitions()
  return {
    basedpyright = {
      before_init = function(_, config)
        local python_path = project_python(config.root_dir or vim.fn.getcwd())
        if not python_path then
          return
        end

        config.settings = config.settings or {}
        config.settings.python = config.settings.python or {}
        config.settings.python.pythonPath = python_path
      end,
      settings = {
        python = {
          analysis = {
            typeCheckingMode = 'standard',
            autoImportCompletions = true,
            useLibraryCodeForTypes = true,
          },
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
      on_attach = disable_formatting,
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
      on_attach = disable_formatting,
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
      filetypes = web_filetypes,
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
  -- Godot exposes its server directly, so it does not go through Mason.
  vim.lsp.config('gdscript', {
    capabilities = capabilities,
  })
  vim.lsp.enable 'gdscript'
end

return M
