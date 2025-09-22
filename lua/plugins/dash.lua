-- https://github.com/goolord/alpha-nvim
return {
  'goolord/alpha-nvim',
  event = 'VimEnter',
  config = function()
    local alpha = require 'alpha'
    local dash = require 'alpha.themes.dashboard'

    -- ⚠️ évite les require top-level qui chargent des plugins :
    -- local zk  = require 'config.notes'       -- <- si ça pull des plugins, évite
    -- local fzf = require 'fzf-lua'            -- <- force le chargement

    -- Si 'config.notes' est léger, ok. Sinon, wrappe aussi en function.
    local zk_ok, zk = pcall(require, 'config.notes')

    -- Header
    dash.section.header.val = {
      '                                 nebulix⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
      '                                              ',
      '       ████ ██████           █████      ██',
      '      ███████████             █████ ',
      '      █████████ ███████████████████ ███   ███████████',
      '     █████████  ███    █████████████ █████ ██████████████',
      '    █████████ ██████████ █████████ █████ █████ ████ █████',
      '  ███████████ ███    ███ █████████ █████ █████ ████ █████',
      ' ██████  █████████████████████ ████ █████ █████ ████ ██████',
      ' ',
    }

    -- Helpers fzf-lua lazy
    local function fzf_files(opts)
      return function()
        require('fzf-lua').files(opts)
      end
    end
    local function fzf_grep(opts)
      return function()
        require('fzf-lua').grep(opts)
      end
    end

    -- Boutons
    dash.section.buttons.val = {
      { type = 'text', val = '  Explorer', opts = { hl = 'Title', position = 'center' } },

      -- ⚠️ fzf-lua n’est require QU’AU CLIC
      dash.button('f', '  Files', fzf_files()),
      dash.button('g', '  Grep', fzf_grep()),

      -- Ces commandes ne chargent rien tant que tu ne les exécutes pas
      dash.button('p', '  Projects', ':NeovimProjectDiscover history<CR>'),
      dash.button('r', '󰑓  Load last session', ':NeovimProjectLoadRecent<CR>'),

      -- Notes (si ton module est léger, garde; sinon wrappe aussi)
      zk_ok and dash.button('j', '󰃰  Journal du jour', zk.new_daily) or nil,
      zk_ok and dash.button('n', '  Nouvelle note', zk.new_note) or nil,
      zk_ok and dash.button('s', '󰍉  Parcourir notes', zk.browse) or nil,

      { type = 'text', val = '  Config', opts = { hl = 'Title', position = 'center' } },
      dash.button('l', '󰒲  Lazy', ':Lazy<CR>'),
      dash.button('m', '󱁤  Mason', ':Mason<CR>'),
      dash.button('h', '  Health', ':checkhealth<CR>'),

      -- Dossiers ciblés → fzf-lua lazy via wrapper
      dash.button('d', '  Dotfiles', fzf_files { cwd = vim.fn.expand '~/dotfiles' }),
      dash.button(
        'c',
        '  Config',
        fzf_files {
          cwd = vim.fn.stdpath 'config',
          fd_opts = [[--color=never --hidden --follow --no-ignore --exclude .git]],
        }
      ),

      dash.button('q', '󰗼  Quit', ':qa<CR>'),
      { type = 'text', val = ' Recent files', opts = { hl = 'Title', position = 'center' } },
    }
    dash.section.buttons.val = vim.tbl_filter(function(x)
      return x ~= nil
    end, dash.section.buttons.val)

    -- MRU (inchangé)
    local function mru_section(opts)
      opts = vim.tbl_extend('force', { max = 8, cwd = nil, title = 'Recent files' }, opts or {})
      local function file_btn(idx, path)
        local short = vim.fn.pathshorten(vim.fn.fnamemodify(path, ':.'))
        local cmd = string.format('<cmd>e %s<CR>', vim.fn.fnameescape(path))
        local btn = dash.button(tostring(idx), short, cmd)
        btn.opts.hl_shortcut = 'Number'
        return btn
      end
      local rootspec = opts.cwd and (vim.fn.fnamemodify(opts.cwd, ':p')) or nil
      local files, count = {}, 0
      for _, p in ipairs(vim.v.oldfiles or {}) do
        if vim.fn.filereadable(p) == 1 and (not rootspec or p:sub(1, #rootspec) == rootspec) then
          count = count + 1
          files[#files + 1] = p
          if count >= opts.max then
            break
          end
        end
      end
      local buttons = {}
      for i, p in ipairs(files) do
        buttons[#buttons + 1] = file_btn(i, p)
      end
      return {
        type = 'group',
        val = vim.tbl_extend('force', {
          { type = 'text', val = opts.title, opts = { hl = 'SpecialComment', position = 'center' } },
          { type = 'padding', val = 1 },
        }, buttons),
        opts = { position = 'center' },
      }
    end

    local function make_footer()
      local v = vim.version()
      local ver = string.format(' v%d.%d.%d', v.major, v.minor, v.patch)
      local plugins, ms = 0, 0
      local ok_lazy, lazy = pcall(require, 'lazy')
      if ok_lazy then
        local s = lazy.stats() or {}
        plugins = s.count or 0
        local st = s.startuptime
        if type(st) == 'number' and st > 0 then
          ms = math.floor(st + 0.5)
        end
      end
      local when = os.date '%a %d %b %H:%M'
      return string.format('%s  •  %s  •  %d plugins in %dms', ver, when, plugins, ms)
    end

    dash.section.footer.val = make_footer()
    dash.section.footer.opts = { position = 'center', hl = 'Comment' }

    dash.config.layout = {
      { type = 'padding', val = 1 },
      dash.section.header,
      { type = 'padding', val = 1 },
      dash.section.buttons,
      { type = 'padding', val = 1 },
      mru_section { max = 8 },
      { type = 'padding', val = 1 },
      dash.section.footer,
    }

    alpha.setup(dash.config)

    -- rafraîchit le footer quand lazy a fini
    local function refresh_footer()
      dash.section.footer.val = make_footer()
      pcall(vim.cmd.AlphaRedraw)
    end
    vim.api.nvim_create_autocmd('User', { pattern = 'LazyDone', callback = refresh_footer })
    vim.api.nvim_create_autocmd('User', { pattern = 'VeryLazy', callback = refresh_footer })
    vim.api.nvim_create_autocmd('User', { pattern = 'LazyVimStarted', callback = refresh_footer })
    vim.defer_fn(refresh_footer, 200)
  end,
}
