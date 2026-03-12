-- Git-local NebuVim keymaps.
-- Gitsigns maps stay buffer-local to avoid leaking Git actions outside repos.

local helpers = require 'options.keybinds.helpers'

local M = {}

function M.attach(bufnr)
  local gitsigns = require 'gitsigns'

  helpers.buf_map(bufnr, 'n', ']c', function()
    if vim.wo.diff then
      vim.cmd.normal { ']c', bang = true }
      return
    end

    gitsigns.nav_hunk 'next'
  end, 'Git Next Change')

  helpers.buf_map(bufnr, 'n', '[c', function()
    if vim.wo.diff then
      vim.cmd.normal { '[c', bang = true }
      return
    end

    gitsigns.nav_hunk 'prev'
  end, 'Git Previous Change')

  helpers.buf_map(bufnr, 'v', '<leader>gs', function()
    gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
  end, 'Git Stage Hunk')

  helpers.buf_map(bufnr, 'v', '<leader>gr', function()
    gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
  end, 'Git Reset Hunk')

  helpers.buf_map(bufnr, 'n', '<leader>gs', gitsigns.stage_hunk, 'Git Stage Hunk')
  helpers.buf_map(bufnr, 'n', '<leader>gr', gitsigns.reset_hunk, 'Git Reset Hunk')
  helpers.buf_map(bufnr, 'n', '<leader>gS', gitsigns.stage_buffer, 'Git Stage Buffer')
  helpers.buf_map(bufnr, 'n', '<leader>gu', gitsigns.undo_stage_hunk, 'Git Undo Stage Hunk')
  helpers.buf_map(bufnr, 'n', '<leader>gR', gitsigns.reset_buffer, 'Git Reset Buffer')
  helpers.buf_map(bufnr, 'n', '<leader>gp', gitsigns.preview_hunk, 'Git Preview Hunk')
  helpers.buf_map(bufnr, 'n', '<leader>gb', gitsigns.blame_line, 'Git Blame Line')
  helpers.buf_map(bufnr, 'n', '<leader>gd', gitsigns.diffthis, 'Git Diff Index')
  helpers.buf_map(bufnr, 'n', '<leader>gD', function()
    gitsigns.diffthis '@'
  end, 'Git Diff Last Commit')
  helpers.buf_map(bufnr, 'n', '<leader>gq', gitsigns.setqflist, 'Git Quickfix Hunks')
  helpers.buf_map(bufnr, 'n', '<leader>gtb', gitsigns.toggle_current_line_blame, 'Git Toggle Blame')
  helpers.buf_map(bufnr, 'n', '<leader>gtD', gitsigns.toggle_deleted, 'Git Toggle Deleted')
  helpers.buf_map(bufnr, 'n', '<leader>gtw', gitsigns.toggle_word_diff, 'Git Toggle Word Diff')
  helpers.buf_map(bufnr, 'n', '<leader>gtl', gitsigns.toggle_linehl, 'Git Toggle Line Highlight')
  helpers.buf_map(bufnr, 'n', '<leader>tb', gitsigns.toggle_current_line_blame, 'Git Toggle Blame [alias]')
  helpers.buf_map(bufnr, 'n', '<leader>tD', gitsigns.toggle_deleted, 'Git Toggle Deleted [alias]')
  helpers.buf_map(bufnr, 'n', '<leader>tw', gitsigns.toggle_word_diff, 'Git Toggle Word Diff [alias]')
  helpers.buf_map(bufnr, 'n', '<leader>tl', gitsigns.toggle_linehl, 'Git Toggle Line Highlight [alias]')
end

return M
