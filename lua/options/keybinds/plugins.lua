-- NebuVim plugin keymap registry.
-- Domain modules keep plugin-facing mappings small while preserving one public entrypoint.

local modules = {
  'options.keybinds.plugin-code',
  'options.keybinds.plugin-navigation',
  'options.keybinds.plugin-ui',
  'options.keybinds.plugin-notes',
  'options.keybinds.plugin-language',
}

local M = {}

for _, module in ipairs(modules) do
  for key, value in pairs(require(module)) do
    M[key] = value
  end
end

return M
