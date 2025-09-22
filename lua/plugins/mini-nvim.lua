-- Collection of various small independent plugins/modules
return {
  'echasnovski/mini.nvim',
  event = 'VeryLazy',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    -- Move any selection in any direction
    --
    -- <M-hjkl> to move selection
    require('mini.move').setup()

    -- Autopairs, quotes, etc.
    require('mini.pairs').setup()

    -- Notifications manager
    require('mini.notify').setup {
      -- Animation style (see `:h mini-notify-config` for more)
      stages = 'fade_in_slide_out',
      -- Function to override with your own notification (see `:h mini-notify-func` for more)
      render = 'default',
      -- Time after which notification is hidden
      timeout = 3000,
      -- Whether to render a background for the entire width of the screen
      background_colour = 'Normal',
    }

    -- dev icons
    require('mini.icons').setup() -- activating icons
    require('mini.icons').mock_nvim_web_devicons() -- compat for plugins web icons

    --[[
    ==========================================
    ========= Statusline & Tabline ===========
    ==========================================
    --]]
    -- Statusline
    require('mini.statusline').setup {
      use_icons = true,
      content = {
        active = function()
          local MS = require 'mini.statusline'

          -- built-in sections
          local mode, mode_hl = MS.section_mode { trunc_width = 120 }
          local git = MS.section_git { trunc_width = 40 }
          local diff = MS.section_diff { trunc_width = 75 }
          local diagnostics = MS.section_diagnostics { trunc_width = 75 }
          local lsp = MS.section_lsp { trunc_width = 75, icon = '' }
          -- local filename = MS.section_filename { trunc_width = 140 }
          local fileinfo = MS.section_fileinfo { trunc_width = 120 }
          local location = MS.section_location { trunc_width = 75 }
          local search = MS.section_searchcount { trunc_width = 75, options = { recompute = false } }

          -- custom extras
          local cwd = (function()
            local dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
            return dir ~= '' and (' ' .. dir) or ''
          end)()

          local macro_rec = (function()
            local reg = vim.fn.reg_recording()
            return (reg ~= '' and (' @' .. reg)) or ''
          end)()

          local indent = '␠' .. vim.api.nvim_get_option_value('shiftwidth', { scope = 'local' })

          local enc_ff = (function()
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
          end)()

          local ts_ok = (function()
            local ok = pcall(vim.treesitter.get_parser, 0)
            return ok and '󰐅 TS' or ''
          end)()

          local dap_status = (function()
            local ok, dap = pcall(require, 'dap')
            if not ok then
              return ''
            end
            local s = dap.status()
            return (s and s ~= '') and (' ' .. s) or ''
          end)()

          local copilot_status = (function()
            -- si le plugin n'est pas encore chargé (lazy), ne casse pas la ligne
            if vim.fn.exists '*copilot#Enabled' == 0 then
              return ''
            end
            if vim.fn['copilot#Enabled']() == 0 then
              return '' -- désactivé pour ce buffer
            end

            -- Certaines versions exposent copilot#Status(), d'autres juste "Enabled"
            local s = ''
            if vim.fn.exists '*copilot#Status' == 1 then
              -- renvoie souvent "Normal", "InProgress", "Disabled"…
              s = vim.fn['copilot#Status']()
            else
              s = 'On'
            end

            return ' ' .. s
          end)()

          return MS.combine_groups {
            { hl = mode_hl, strings = { ' ', mode } },
            { hl = 'MiniStatuslineDevinfo', strings = { cwd, git, diff } },
            '%<',
            { hl = 'MiniStatuslineFilename', strings = { diagnostics } },
            '%=',
            { hl = 'MiniStatuslineFilename', strings = { lsp, ts_ok, dap_status, copilot_status } },
            '%=',
            { hl = 'MiniStatuslineFileinfo', strings = { search, macro_rec, indent, enc_ff, fileinfo } },
            { hl = mode_hl, strings = { location } },
          }
        end,

        inactive = function()
          local MS = require 'mini.statusline'
          local filename = MS.section_filename { trunc_width = 140 }
          local location = MS.section_location { trunc_width = 75 }
          return MS.combine_groups {
            { hl = 'MiniStatuslineInactive', strings = { ' ' .. filename .. ' ' } },
            '%=',
            { hl = 'MiniStatuslineInactive', strings = { location } },
          }
        end,
      },
    }
    -- Tabline
    require('mini.tabline').setup {
      show_icons = true,
      tabpage_section = 'right',
      format = function(buf_id, label)
        local MT = require 'mini.tabline'
        -- format par défaut : icône (si dispo) + " label "
        local s = ' ' .. MT.default_format(buf_id, label) .. ' '

        -- suffixes façon lualine : ● si modifié, cadenas si readonly
        if vim.bo[buf_id].modified then
          s = s .. '● '
        end
        if vim.bo[buf_id].readonly or not vim.bo[buf_id].modifiable then
          s = s .. '󰌾 '
        end
        return s
      end,
    }
  end,
}
