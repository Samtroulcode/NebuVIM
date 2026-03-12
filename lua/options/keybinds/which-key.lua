-- NebuVim which-key group registry.
-- Groups stay centralized so plugin specs follow one discoverable hierarchy.

return {
  -- Leader hierarchy
  { '<leader>a', group = 'Surround Aliases', icon = { icon = '', color = 'yellow' } },
  { '<leader>b', group = 'Buffers', icon = { icon = '󰓩', color = 'blue' } },
  { '<leader>c', group = 'Code', icon = { icon = '󰨞', color = 'cyan' } },
  { '<leader>e', group = 'Explorer', icon = { icon = '', color = 'azure' } },
  { '<leader>f', group = 'Find', icon = { icon = '󰍉', color = 'green' } },
  { '<leader>g', group = 'Git', mode = { 'n', 'v' }, icon = { icon = '󰊢', color = 'orange' } },
  { '<leader>l', group = 'Language Extras', icon = { icon = '󰒕', color = 'cyan' } },
  { '<leader>lg', group = 'Godot', icon = { icon = '', color = 'blue' } },
  { '<leader>lr', group = 'Rust', icon = { icon = '󱘗', color = 'orange' } },
  { '<leader>lv', group = 'Love', icon = { icon = '󰢱', color = 'red' } },
  { '<leader>m', group = 'Messages', icon = { icon = '󰍩', color = 'yellow' } },
  { '<leader>n', group = 'Notes', icon = { icon = '󱞁', color = 'purple' } },
  { '<leader>p', group = 'Project', icon = { icon = '󰏓', color = 'grey' } },
  { '<leader>q', group = 'Quickfix Aliases', icon = { icon = '󱖫', color = 'orange' } },
  { '<leader>r', group = 'Refactor', icon = { icon = '󱍸', color = 'orange' } },
  { '<leader>s', group = 'Search', icon = { icon = '󰍉', color = 'green' } },
  { '<leader>t', group = 'Toggle', icon = { icon = '', color = 'yellow' } },
  { '<leader>w', group = 'Windows', icon = { icon = '', color = 'blue' } },
  { '<leader>x', group = 'Diagnostics', icon = { icon = '󰅚', color = 'orange' } },
  { '<leader>gt', group = 'Toggles', icon = { icon = '', color = 'yellow' } },

  -- Contextual prefixes outside <leader>
  { 'gr', group = 'LSP', icon = { icon = '󰒕', color = 'cyan' } },
  -- `s` is now a motion namespace for Flash; surround moved to `gs*`.
  { 's', mode = { 'n', 'x', 'o' }, desc = 'Flash Jump', icon = { icon = '󰉿', color = 'green' } },
  { 'S', mode = { 'n', 'x', 'o' }, desc = 'Flash Treesitter', icon = { icon = '󰙨', color = 'green' } },
  { 'gs', group = 'Surround', mode = { 'n', 'x' }, icon = { icon = '', color = 'yellow' } },
  { 'gsa', mode = { 'n', 'x' }, desc = 'Surround Add' },
  { 'gsd', mode = { 'n', 'x' }, desc = 'Surround Delete' },
  { 'gsr', mode = { 'n', 'x' }, desc = 'Surround Replace' },
  { 'gsf', mode = { 'n', 'x' }, desc = 'Surround Find Right' },
  { 'gsF', mode = { 'n', 'x' }, desc = 'Surround Find Left' },
  { 'gsh', mode = { 'n', 'x' }, desc = 'Surround Highlight' },
  { 'gsn', mode = { 'n', 'x' }, desc = 'Surround Update N Lines' },
}
