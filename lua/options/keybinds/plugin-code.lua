-- Code and editor keymaps exposed to plugin specs.
-- These bindings stay grouped so LSP and formatting remain easy to discover.

local helpers = require 'options.keybinds.helpers'
local plugin_helpers = require 'options.keybinds.plugin-helpers'

local M = {}

M.code = {
  -- Canonical code hierarchy.
  { '<leader>ca', plugin_helpers.with_lsp('code actions', vim.lsp.buf.code_action), mode = { 'n', 'x' }, desc = 'Code Action' },
  { '<leader>cd', plugin_helpers.with_lsp('definitions', function() Snacks.picker.lsp_definitions() end), desc = 'Code Definitions' },
  { '<leader>cD', plugin_helpers.with_lsp('declaration', vim.lsp.buf.declaration), desc = 'Code Declaration' },
  { '<leader>ch', plugin_helpers.with_lsp('hover', vim.lsp.buf.hover), desc = 'Code Hover' },
  { '<leader>ci', plugin_helpers.with_lsp('implementations', function() Snacks.picker.lsp_implementations() end), desc = 'Code Implementations' },
  { '<leader>cr', plugin_helpers.with_lsp('references', function() Snacks.picker.lsp_references() end), desc = 'Code References' },
  { '<leader>cR', plugin_helpers.with_lsp('rename', vim.lsp.buf.rename), desc = 'Code Rename' },
  { '<leader>cs', plugin_helpers.with_lsp('document symbols', function() Snacks.picker.lsp_symbols() end), desc = 'Code Symbols' },
  { '<leader>cS', plugin_helpers.with_lsp('workspace symbols', function() Snacks.picker.lsp_workspace_symbols() end), desc = 'Code Workspace Symbols' },
  { '<leader>ct', plugin_helpers.with_lsp('type definitions', function() Snacks.picker.lsp_type_definitions() end), desc = 'Code Type Definitions' },
  { '<leader>cH', plugin_helpers.toggle_inlay_hints, desc = 'Code Toggle Inlay Hints' },
  { '<leader>cL', '<cmd>LspInfo<CR>', desc = 'Code LSP Info' },
  { '<leader>cM', '<cmd>Mason<CR>', desc = 'Code Mason' },

  -- Legacy language aliases kept during the migration.
  { '<leader>lla', plugin_helpers.with_lsp('code actions', vim.lsp.buf.code_action), mode = { 'n', 'x' }, desc = 'Code Action [alias]' },
  { '<leader>lld', plugin_helpers.with_lsp('definitions', function() Snacks.picker.lsp_definitions() end), desc = 'Code Definitions [alias]' },
  { '<leader>llD', plugin_helpers.with_lsp('declaration', vim.lsp.buf.declaration), desc = 'Code Declaration [alias]' },
  { '<leader>llh', plugin_helpers.with_lsp('hover', vim.lsp.buf.hover), desc = 'Code Hover [alias]' },
  { '<leader>lli', plugin_helpers.with_lsp('implementations', function() Snacks.picker.lsp_implementations() end), desc = 'Code Implementations [alias]' },
  { '<leader>llr', plugin_helpers.with_lsp('references', function() Snacks.picker.lsp_references() end), desc = 'Code References [alias]' },
  { '<leader>llR', plugin_helpers.with_lsp('rename', vim.lsp.buf.rename), desc = 'Code Rename [alias]' },
  { '<leader>lls', plugin_helpers.with_lsp('document symbols', function() Snacks.picker.lsp_symbols() end), desc = 'Code Symbols [alias]' },
  { '<leader>llS', plugin_helpers.with_lsp('workspace symbols', function() Snacks.picker.lsp_workspace_symbols() end), desc = 'Code Workspace Symbols [alias]' },
  { '<leader>llt', plugin_helpers.with_lsp('type definitions', function() Snacks.picker.lsp_type_definitions() end), desc = 'Code Type Definitions [alias]' },
  { '<leader>lth', plugin_helpers.toggle_inlay_hints, desc = 'Code Toggle Inlay Hints [alias]' },
  { '<leader>lti', '<cmd>LspInfo<CR>', desc = 'Code LSP Info [alias]' },
  { '<leader>ltm', '<cmd>Mason<CR>', desc = 'Code Mason [alias]' },
}

M.language = M.code

M.conform = {
  { '<leader>cF', plugin_helpers.format_buffer, desc = 'Code Format Buffer' },
  { '<leader>cI', '<cmd>ConformInfo<CR>', desc = 'Code Format Info' },
  { '<leader>lff', plugin_helpers.format_buffer, desc = 'Code Format Buffer [alias]' },
  { '<leader>lfi', '<cmd>ConformInfo<CR>', desc = 'Code Format Info [alias]' },
}

M.flash = {
  -- Short single-key motions are reserved for navigation speed.
  { 's', function() require('flash').jump() end, mode = { 'n', 'x', 'o' }, desc = 'Flash Jump' },
  { 'S', function() require('flash').treesitter() end, mode = { 'n', 'x', 'o' }, desc = 'Flash Treesitter' },
  { 'r', function() require('flash').remote() end, mode = 'o', desc = 'Remote Flash' },
  { 'R', function() require('flash').treesitter_search() end, mode = { 'o', 'x' }, desc = 'Flash Treesitter Search' },
  { '<leader>tf', function() require('flash').toggle() end, desc = 'Toggle Flash Search' },
}

M.surround = {
  -- Keep surround discoverable in which-key even though the runtime motions use `gs*`.
  { '<leader>aa', 'gsa', mode = { 'n', 'x' }, remap = true, desc = 'Surround Add [alias]' },
  { '<leader>ad', 'gsd', remap = true, desc = 'Surround Delete [alias]' },
  { '<leader>ar', 'gsr', remap = true, desc = 'Surround Replace [alias]' },
  { '<leader>af', 'gsf', remap = true, desc = 'Surround Find Right [alias]' },
  { '<leader>aF', 'gsF', remap = true, desc = 'Surround Find Left [alias]' },
  { '<leader>ah', 'gsh', remap = true, desc = 'Surround Highlight [alias]' },
  { '<leader>an', 'gsn', remap = true, desc = 'Surround Update N Lines [alias]' },
}

M.text_case = {
  { '<leader>rs', function() require('textcase').current_word 'to_snake_case' end, desc = 'Refactor Snake Case' },
  { '<leader>rc', function() require('textcase').current_word 'to_camel_case' end, desc = 'Refactor Camel Case' },
  { '<leader>rp', function() require('textcase').current_word 'to_pascal_case' end, desc = 'Refactor Pascal Case' },
  { '<leader>ru', function() require('textcase').current_word 'to_upper_case' end, desc = 'Refactor Upper Case' },
  { '<leader>xs', function() require('textcase').current_word 'to_snake_case' end, desc = 'Refactor Snake Case [alias]' },
  { '<leader>xc', function() require('textcase').current_word 'to_camel_case' end, desc = 'Refactor Camel Case [alias]' },
  { '<leader>xp', function() require('textcase').current_word 'to_pascal_case' end, desc = 'Refactor Pascal Case [alias]' },
  { '<leader>xu', function() require('textcase').current_word 'to_upper_case' end, desc = 'Refactor Upper Case [alias]' },
}

M.toggle = {
  { '<leader>tc', function() require('config.copilot').toggle_completion() end, desc = 'Toggle Copilot Completion' },
}

M.todo = {
  { '<leader>tq', '<cmd>TodoQuickFix<CR>', desc = 'Toggle Todo Quickfix' },
  { ']t', function() require('todo-comments').jump_next() end, desc = 'Todo Next' },
  { '[t', function() require('todo-comments').jump_prev() end, desc = 'Todo Previous' },
}

M.search = {
  { '<leader>s/', helpers.grep_open_files, desc = 'Search Open Files' },
}

return M
