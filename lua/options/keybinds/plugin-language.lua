-- Language-specific keymaps exposed to plugin specs.
-- Filetype-local helpers stay isolated so each language can evolve independently.

local plugin_helpers = require 'options.keybinds.plugin-helpers'

local rust_buffer_keys = {
  { '<leader>lra', '<cmd>RustLsp codeAction<CR>', desc = 'Rust Code Action' },
  { '<leader>lrh', '<cmd>RustLsp hover actions<CR>', desc = 'Rust Hover Actions' },
  { '<leader>lrr', '<cmd>RustLsp runnables<CR>', desc = 'Rust Runnables' },
  { '<leader>lrR', '<cmd>RustLsp! runnables<CR>', desc = 'Rust Rerun Last Runnable' },
  { '<leader>lrt', '<cmd>RustLsp testables<CR>', desc = 'Rust Testables' },
  { '<leader>lre', '<cmd>RustLsp explainError current<CR>', desc = 'Rust Explain Error' },
  { '<leader>lro', '<cmd>RustLsp openDocs<CR>', desc = 'Rust Open Docs' },
  { '<leader>lrc', '<cmd>RustLsp openCargo<CR>', desc = 'Rust Open Cargo' },
  { '<leader>lrp', '<cmd>RustLsp parentModule<CR>', desc = 'Rust Parent Module' },
  { '<leader>lrk', '<cmd>RustLsp moveItem up<CR>', desc = 'Rust Move Item Up' },
  { '<leader>lrj', '<cmd>RustLsp moveItem down<CR>', desc = 'Rust Move Item Down' },
}

local godot_buffer_keys = {
  { '<leader>lgr', '<cmd>GodotRun<CR>', desc = 'Godot Run Project' },
  { '<leader>lgc', '<cmd>GodotRunCurrent<CR>', desc = 'Godot Run Current Scene' },
  { '<leader>lgl', '<cmd>GodotRunLast<CR>', desc = 'Godot Run Last Scene' },
  { '<leader>lgf', '<cmd>GodotRunFZF<CR>', desc = 'Godot Run Scene Picker' },
}

return {
  love = {
    { '<leader>lvr', '<cmd>LoveRun<CR>', desc = 'Love Run' },
    { '<leader>lvs', '<cmd>LoveStop<CR>', desc = 'Love Stop' },
  },
  rust_attach = function(bufnr)
    plugin_helpers.set_buffer_keymaps(bufnr, rust_buffer_keys)
  end,
  godot_attach = function(bufnr)
    plugin_helpers.set_buffer_keymaps(bufnr, godot_buffer_keys)
  end,
}
