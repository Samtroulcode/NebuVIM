-- NebuVim which-key group registry.
-- Groups stay centralized so plugin specs follow one discoverable hierarchy.

return {
  { '<leader>b', group = 'Buffers', icon = { icon = '󰓩', color = 'blue' } },
  { '<leader>c', group = 'Copilot', icon = { icon = '', color = 'cyan' } },
  { '<leader>e', group = 'Explorer', icon = { icon = '', color = 'azure' } },
  { '<leader>f', group = 'Format', icon = { icon = '󰉿', color = 'green' } },
  { '<leader>g', group = 'Git', mode = { 'n', 'v' }, icon = { icon = '󰊢', color = 'orange' } },
  { '<leader>l', group = 'Love', icon = { icon = '󰢱', color = 'red' } },
  { '<leader>m', group = 'Messages', icon = { icon = '󰍩', color = 'yellow' } },
  { '<leader>n', group = 'Notes', icon = { icon = '󱞁', color = 'purple' } },
  { '<leader>p', group = 'Project', icon = { icon = '󰏓', color = 'grey' } },
  { '<leader>s', group = 'Search', icon = { icon = '󰍉', color = 'green' } },
  { '<leader>t', group = 'Toggle', icon = { icon = '', color = 'yellow' } },
  { '<leader>x', group = 'Text', icon = { icon = '󰉿', color = 'azure' } },
  { 'gr', group = 'LSP', icon = { icon = '󰒕', color = 'cyan' } },
}
