-- NebuVim keymap helpers.
-- Shared wrappers keep mapping definitions short and consistent.

local M = {}

function M.map(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end

function M.buf_map(bufnr, mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, {
    buffer = bufnr,
    desc = desc,
  })
end

function M.goto_buffer_index(index)
  local info = vim.fn.getbufinfo { buflisted = 1 }

  table.sort(info, function(a, b)
    return a.bufnr < b.bufnr
  end)

  if index >= 1 and index <= #info then
    vim.api.nvim_set_current_buf(info[index].bufnr)
    return
  end

  vim.notify(('No listed buffer at index %d'):format(index), vim.log.levels.WARN)
end

function M.next_buffer_or_index()
  local index = vim.v.count

  if index > 0 then
    M.goto_buffer_index(index)
    return
  end

  vim.cmd.bnext()
end

function M.toggle_spell()
  vim.opt.spell = not vim.opt.spell:get()

  if vim.opt.spell:get() then
    vim.notify('Spellcheck ON (' .. table.concat(vim.opt.spelllang:get(), ',') .. ')', vim.log.levels.INFO)
    return
  end

  vim.notify('Spellcheck OFF', vim.log.levels.INFO)
end

function M.grep_open_files()
  Snacks.picker.grep_buffers()
end

function M.close_with_q(bufnr)
  M.buf_map(bufnr, 'n', 'q', '<cmd>close<CR>', 'Close Window')
end

return M
