-- NebuVim keymap entrypoint.
-- This module aggregates core, contextual, and plugin-facing keymap definitions.

local core = require 'options.keybinds.core'
local git = require 'options.keybinds.git'
local helpers = require 'options.keybinds.helpers'
local lsp = require 'options.keybinds.lsp'

local M = {}

M.keys = require 'options.keybinds.plugins'
M.which_key = require 'options.keybinds.which-key'

function M.setup()
  core.setup()
end

function M.close_with_q(bufnr)
  helpers.close_with_q(bufnr)
end

function M.lsp_attach(event)
  lsp.attach(event)
end

function M.gitsigns_attach(bufnr)
  git.attach(bufnr)
end

return M
