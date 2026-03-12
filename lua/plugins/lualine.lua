-- NebuVim statusline configuration.
-- Lualine exposes high-signal context while keeping note-taking and coding states visible.

return {
  'nvim-lualine/lualine.nvim',
  event = 'VimEnter',
  dependencies = {
    {
      'linrongbin16/lsp-progress.nvim',
      event = { 'LspAttach', 'LspDetach' },
      config = function()
        require('lsp-progress').setup {}
      end,
    },
  },
  opts = function()
    -- ╔══ Dynamic Sources ══╗
    local lsp_progress = require 'lsp-progress'

    local function cwd()
      local dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
      return ' ' .. dir
    end

    local function lsp_progress_status()
      return lsp_progress.progress()
    end

    local function obsidian_status()
      return vim.b.obsidian_status or ''
    end

    local function gitsigns_diff_source()
      return vim.b.gitsigns_status_dict
    end

    local diagnostics = {
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
      update_in_insert = false,
      always_visible = false,
    }

    local git_branch = { 'branch', icon = '' }
    local git_diff = {
      'diff',
      source = gitsigns_diff_source,
      symbols = { added = ' ', modified = ' ', removed = ' ' },
    }

    local function lsp_names()
      local buf = vim.api.nvim_get_current_buf()
      local clients = vim.lsp.get_clients { bufnr = buf }
      if #clients == 0 then
        return ''
      end
      local names = {}
      for _, c in ipairs(clients) do
        table.insert(names, c.name)
      end
      return ' ' .. table.concat(names, ',')
    end

    local function ts_ok()
      local ok = pcall(vim.treesitter.get_parser, 0)
      return ok and '󰐅 TS' or ''
    end

    local function macro_rec()
      local reg = vim.fn.reg_recording()
      if reg == '' then
        return ''
      end
      return ' @' .. reg
    end

    local function searchcount()
      if vim.v.hlsearch == 0 then
        return ''
      end
      local sc = vim.fn.searchcount { maxcount = 999, timeout = 50 }
      if sc.total == 0 then
        return ''
      end
      return string.format(' %d/%d', sc.current or 0, sc.total or 0)
    end

    local function indent()
      return '␠' .. vim.api.nvim_get_option_value('shiftwidth', { scope = 'local' })
    end

    local function enc_ff()
      local e = (vim.bo.fenc ~= '' and vim.bo.fenc or vim.o.enc):lower()
      local f = vim.bo.fileformat
      local out = {}
      if e ~= 'utf-8' then
        table.insert(out, e)
      end
      if f ~= 'unix' then
        table.insert(out, f)
      end
      return #out > 0 and table.concat(out, '·') or ''
    end

    local function dap_status()
      local ok, dap = pcall(require, 'dap')
      if not ok then
        return ''
      end
      local s = dap.status()
      return (s and s ~= '') and (' ' .. s) or ''
    end

    local align = '%='

    -- ╔══ Layout ══╗
    return {
      options = {
        icons_enabled = true,
        theme = 'catppuccin',
        section_separators = { left = '', right = '' },
        component_separators = '',
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        globalstatus = true,
      },
      sections = {
        lualine_a = { { 'mode', icon = ' ', separator = { left = '' }, right_padding = 2 } },
        lualine_b = { cwd, git_branch },
        lualine_c = { git_diff, diagnostics, align, lsp_names, ts_ok, dap_status },
        lualine_x = { lsp_progress_status, obsidian_status, searchcount, macro_rec },
        lualine_y = { indent, { 'filetype', icon_only = false }, enc_ff, 'encoding', 'progress' },
        lualine_z = { { 'location', separator = { right = '' }, left_padding = 2 } },
      },
      inactive_sections = {
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { 'quickfix' },
    }
  end,
}
