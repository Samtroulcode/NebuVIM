local M = {}

function M.luasnip_build()
  if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
    return
  end

  return 'make install_jsregexp'
end

function M.blink_opts()
  return {
    keymap = {
      preset = 'default',
    },
    appearance = {
      nerd_font_variant = 'mono',
    },
    completion = {
      documentation = { auto_show = false, auto_show_delay_ms = 500 },
    },
    sources = {
      default = {
        'lsp',
        'path',
        'snippets',
        'lazydev',
        'buffer',
      },
      providers = {
        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
      },
    },
    snippets = { preset = 'luasnip' },
    fuzzy = { implementation = 'prefer_rust_with_warning' },
    signature = { enabled = true },
  }
end

return M
