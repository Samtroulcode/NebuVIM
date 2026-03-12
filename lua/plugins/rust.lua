-- Rust tooling powered by rust-analyzer extensions.
-- Keep Rust-specific actions under the shared <leader>l language tree.

return {
  'mrcjkb/rustaceanvim',
  ft = { 'rust' },
  version = '^6', -- Recommended
  config = function()
    local keymaps = require('options.keybinds').keys
    local group = vim.api.nvim_create_augroup('nebuvim-rust-keymaps', { clear = true })

    vim.api.nvim_create_autocmd('FileType', {
      group = group,
      pattern = 'rust',
      desc = 'Attach Rust keymaps',
      callback = function(event)
        keymaps.rust_attach(event.buf)
      end,
    })

    if vim.bo.filetype == 'rust' then
      keymaps.rust_attach(vim.api.nvim_get_current_buf())
    end
  end,
}
