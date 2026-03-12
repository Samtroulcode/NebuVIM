-- Godot editor integration for GDScript buffers.
-- Only bind commands that are officially exposed by vim-godot.

return {
  'habamax/vim-godot',
  ft = { 'gdscript', 'gdshader', 'godot_resource' },
  config = function()
    local keymaps = require('options.keybinds').keys
    local group = vim.api.nvim_create_augroup('nebuvim-godot-keymaps', { clear = true })

    vim.api.nvim_create_autocmd('FileType', {
      group = group,
      pattern = 'gdscript',
      desc = 'Attach Godot keymaps',
      callback = function(event)
        keymaps.godot_attach(event.buf)
      end,
    })

    if vim.bo.filetype == 'gdscript' then
      keymaps.godot_attach(vim.api.nvim_get_current_buf())
    end
  end,
}
