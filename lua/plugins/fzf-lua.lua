-- https://github.com/ibhagwan/fzf-lua
return {
  -- Fuzzy Finder (files, LSP, etc.) via fzf-lua
  'ibhagwan/fzf-lua',
  cmd = 'FzfLua',
  dependencies = {
    { 'echasnovski/mini.nvim', enabled = vim.g.have_nerd_font },
  },
  config = function()
    local fzf = require 'fzf-lua'

    fzf.setup {
      winopts = {
        height = 0.85,
        width = 0.85,
        preview = { default = 'bat' }, -- si bat est installé, sinon commentaire
      },
      files = {
        -- utilise fd s'il est dispo pour de meilleures perfs
        fd_opts = [[--color=never --hidden --follow --exclude .git]],
        -- fallback sur ripgrep sinon
      },
      grep = {
        rg_opts = '--hidden --no-heading --with-filename --line-number --column --smart-case',
      },
    }

    fzf.register_ui_select()

    -- === Mappings ====
    local map = vim.keymap.set
    local desc = function(d)
      return { desc = d }
    end

    local zk_ok, zk = pcall(require, 'config.notes')

    map('n', '<leader>sh', fzf.help_tags, desc '[S]earch [H]elp')
    map('n', '<leader>sk', fzf.keymaps, desc '[S]earch [K]eymaps')
    map('n', '<leader>sf', fzf.files, desc '[S]earch [F]iles')
    map('n', '<leader>ss', fzf.builtin, desc '[S]earch [S]elect (Pickers)')
    -- "current word" -> grep la cword
    map('n', '<leader>sw', function()
      fzf.grep { search = vim.fn.expand '<cword>' }
    end, desc '[S]earch current [W]ord')

    map('n', '<leader>sg', fzf.live_grep, desc '[S]earch by [G]rep')

    -- Diagnostics (workspace) ~ Telescope diagnostics
    map('n', '<leader>sd', fzf.diagnostics_workspace, desc '[S]earch [D]iagnostics')
    map('n', '<leader>sr', fzf.resume, desc '[S]earch [R]esume')
    map('n', '<leader>s.', fzf.oldfiles, desc '[S]earch Recent Files')
    map('n', '<leader><leader>', fzf.buffers, desc '[ ] Find existing buffers')

    -- Man pages
    map('n', '<leader>sm', fzf.man_pages, desc '[S]earch [M]an pages')

    -- Projects (requires 'tpope/vim-projectionist' or 'ahmedkhalf/project.nvim')
    map('n', '<leader>sp', ':NeovimProjectDiscover<CR>', desc '[S]earch [P]rojects')
    map('n', '<leader>si', function()
      fzf.oldfiles { cwd_only = true, stat_file = true }
    end, desc '[S]earch projects h[I]story')
    map('n', '<leader>/', function()
      fzf.blines {
        winopts = { preview = { hidden = 'hidden' } },
      }
    end, desc '[/] Fuzzy in current buffer')

    -- "Live Grep in Open Files" : on grep uniquement dans les buffers listés/nommés
    map('n', '<leader>s/', function()
      local bufs = vim.api.nvim_list_bufs()
      local files = {}
      for _, b in ipairs(bufs) do
        if vim.api.nvim_buf_is_loaded(b) then
          local name = vim.api.nvim_buf_get_name(b)
          if name ~= '' and vim.fn.filereadable(name) == 1 then
            table.insert(files, name)
          end
        end
      end
      if #files == 0 then
        vim.notify('No file open to search', vim.log.levels.WARN)
        return
      end
      fzf.grep {
        search = '', -- prompt vide
        prompt = 'Grep in Open Files> ',
        files = files, -- limite aux fichiers ouverts
        no_esc = true,
      }
    end, desc '[S]earch [/] in Open Files')

    -- Shortcut pour config Neovim
    map('n', '<leader>sc', function()
      fzf.files { cwd = vim.fn.stdpath 'config' }
    end, desc '[S]earch neovim [C]onfig files')

    map('n', '<leader>sj', zk.browse, desc '[S]earch [J]ournal') -- notes
  end,
}
