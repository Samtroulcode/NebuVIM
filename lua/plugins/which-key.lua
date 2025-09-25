return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VeryLazy', -- Sets the loading event to 'VimEnter'
  opts = {
    preset = 'helix', -- classic, helix, modern
    -- delay between pressing a key and opening which-key (milliseconds)
    -- this setting is independent of vim.o.timeoutlen
    delay = 0,
    -- Document existing key chains
    spec = {
      { '<leader>s', group = 'Search' },
      { '<leader>t', group = 'Toggle' },
      { '<leader>d', group = 'Debug' },
      { '<leader>z', group = 'Zettelkasten', icon = { icon = '󰠮 ', color = 'blue' } },
      { '<leader>g', group = 'Git', mode = { 'n', 'v' } },
      { '<leader>b', group = 'Buffers', icon = { icon = ' ', color = 'magenta' } },
      { '<leader>bs', group = 'Sort', icon = { icon = '󰒺 ' } },
    },
    win = {
      no_overlap = true, -- Prevent the WhichKey window from overlapping with the cursor
    },
    keys = {
      scroll_down = '<C-d>', -- binding to scroll down inside the which-key popup
      scroll_up = '<C-u>', -- binding to scroll up inside the which-key popup
    },
  },
}
