-- https://github.com/goolord/alpha-nvim
return {
  'goolord/alpha-nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'ibhagwan/fzf-lua',
  },
  config = function()
    local alpha = require 'alpha'
    local dash = require 'alpha.themes.dashboard'
    local zk = require 'config.notes'
    local fzf = require 'fzf-lua'

    -- Header custom
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

    -- Boutons organisés par sections avec titres
    dash.section.buttons.val = {
      { type = 'text', val = '  Explorer', opts = { hl = 'Title', position = 'center' } },
      dash.button('f', '  Files', fzf.files),
      dash.button('g', '  Grep', fzf.grep),
      dash.button('p', '  Projects', ':NeovimProjectDiscover history<CR>'),
      dash.button('r', '󰑓  Load last session', ':NeovimProjectLoadRecent<CR>'),
      dash.button('j', '󰃰  Journal du jour', zk.new_daily),
      dash.button('n', '  Nouvelle note', zk.new_note),
      dash.button('s', '󰍉  Parcourir notes', zk.browse),
      { type = 'text', val = '  Config', opts = { hl = 'Title', position = 'center' } },
      dash.button('l', '󰒲  Lazy', ':Lazy<CR>'),
      dash.button('m', '󱁤  Mason', ':Mason<CR>'),
      dash.button('h', '  Health', ':checkhealth<CR>'),
      dash.button('d', '  Dotfiles', function()
        fzf.files {
          cwd = vim.fn.expand '~/dotfiles',
        }
      end),
      dash.button('c', '  Config', function()
        fzf.files {
          cwd = vim.fn.stdpath 'config',
          -- merge avec tes fd_opts globaux si définis dans fzf.setup()
          fd_opts = [[--color=never --hidden --follow --no-ignore --exclude .git]],
        }
      end),
      dash.button('q', '󰗼  Quit', ':qa<CR>'),
      { type = 'text', val = ' Recent files', opts = { hl = 'Title', position = 'center' } },
    }

    -- MRU maison (pas de dashboard.file_button)
    local function mru_section(opts)
      opts = vim.tbl_extend('force', { max = 10, cwd = nil, title = 'Recent files' }, opts or {})

      -- helper: crée un bouton fichier
      local function file_btn(idx, path)
        local short = vim.fn.fnamemodify(path, ':.')
        short = vim.fn.pathshorten(short)
        local cmd = string.format('<cmd>e %s<CR>', vim.fn.fnameescape(path))
        local btn = dash.button(tostring(idx), short, cmd)
        btn.opts.hl_shortcut = 'Number'
        return btn
      end

      -- filtre et collecte
      local rootspec = opts.cwd and (vim.fn.fnamemodify(opts.cwd, ':p')) or nil
      local files, count = {}, 0
      for _, p in ipairs(vim.v.oldfiles or {}) do
        if vim.fn.filereadable(p) == 1 then
          if not rootspec or p:sub(1, #rootspec) == rootspec then
            count = count + 1
            table.insert(files, p)
            if count >= opts.max then
              break
            end
          end
        end
      end

      -- construit le group
      local buttons = {}
      for i, p in ipairs(files) do
        table.insert(buttons, file_btn(i, p))
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
        -- Certaines versions retournent un float, d'autres 0 si pas prêt :
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

    -- ============================================================

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

    -- --- Fix: rafraîchir le footer quand Lazy a fini + fallback ---
    local function refresh_footer()
      dash.section.footer.val = make_footer()
      pcall(vim.cmd.AlphaRedraw)
    end

    -- Quand Lazy termine son init (ou VeryLazy / LazyVimStarted)
    vim.api.nvim_create_autocmd('User', { pattern = 'LazyDone', callback = refresh_footer })
    vim.api.nvim_create_autocmd('User', { pattern = 'VeryLazy', callback = refresh_footer })
    vim.api.nvim_create_autocmd('User', { pattern = 'LazyVimStarted', callback = refresh_footer })

    -- Fallback au cas où aucun évènement ne se déclenche dans ta stack
    vim.defer_fn(refresh_footer, 200)
  end, --  ←←← fermeture de la fonction config (manquante)
}
