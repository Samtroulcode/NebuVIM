-- https://github.com/ibhagwan/fzf-lua
return {
  -- Fuzzy Finder (files, LSP, etc.) via fzf-lua
  'ibhagwan/fzf-lua',
  cmd = 'FzfLua',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
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

    -- Raccourci project finder (plugin neovim-project)
    map('n', '<leader>sp', ':NeovimProjectDiscover<CR>', desc '[S]earch [P]rojects')

    -- "projects history" ~ proche de buffers/oldfiles; on choisit oldfiles cwd-only
    map('n', '<leader>si', function()
      fzf.oldfiles { cwd_only = true, stat_file = true }
    end, desc '[S]earch projects h[I]story')

    -- Equivalent de "current_buffer_fuzzy_find" (Telescope) -> blines
    map('n', '<leader>/', function()
      fzf.blines {
        -- prévisualisation sobre (tu peux la couper complètement si tu veux)
        winopts = { preview = { hidden = 'hidden' } },
      }
    end, desc '[/] Fuzzy dans le buffer courant')

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
        vim.notify('Aucun fichier ouvert lisible pour la recherche', vim.log.levels.WARN)
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
    map('n', '<leader>sn', function()
      fzf.files { cwd = vim.fn.stdpath 'config' }
    end, desc '[S]earch [N]eovim files')
  end,
}

-- return { -- Fuzzy Finder (files, lsp, etc)
--   'nvim-telescope/telescope.nvim',
--   event = 'VimEnter',
--   dependencies = {
--     'nvim-lua/plenary.nvim',
--  { -- If encountering errors, see telescope-fzf-native README for installation instructions
--       'nvim-telescope/telescope-fzf-native.nvim',
--
--       -- `build` is used to run some command when the plugin is installed/updated.
--       -- This is only run then, not every time Neovim starts up.
--       build = 'make',
--
--       -- `cond` is a condition used to determine whether this plugin should be
--       -- installed and loaded.
--       cond = function()
--         return vim.fn.executable 'make' == 1
--       end,
--     },
--     { 'nvim-telescope/telescope-ui-select.nvim' },
--
--     -- Useful for getting pretty icons, but requires a Nerd Font.
--     { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
--   },
--   config = function()
--     -- Telescope is a fuzzy finder that comes with a lot of different things that
--     -- it can fuzzy find! It's more than just a "file finder", it can search
--     -- many different aspects of Neovim, your workspace, LSP, and more!
--     --
--     -- The easiest way to use Telescope, is to start by doing something like:
--     --  :Telescope help_tags
--     --
--     -- After running this command, a window will open up and you're able to
--     -- type in the prompt window. You'll see a list of `help_tags` options and
--     -- a corresponding preview of the help.
--     --
--     -- Two important keymaps to use while in Telescope are:
--     --  - Insert mode: <c-/>
--     --  - Normal mode: ?
--     --
--     -- This opens a window that shows you all of the keymaps for the current
--     -- Telescope picker. This is really useful to discover what Telescope can
--     -- do as well as how to actually do it!
--
--     -- [[ Configure Telescope ]]
--     -- See `:help telescope` and `:help telescope.setup()`
--     require('telescope').setup {
--       -- You can put your default mappings / updates / etc. in here
--       --  All the info you're looking for is in `:help telescope.setup()`
--       --
--       -- defaults = {
--       --   mappings = {
--       --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
--       --   },
--       -- },
--       -- pickers = {}
--       extensions = {
--         ['ui-select'] = {
--           require('telescope.themes').get_dropdown(),
--         },
--       },
--     }
--
--     -- Enable Telescope extensions if they are installed
--     pcall(require('telescope').load_extension, 'fzf')
--     pcall(require('telescope').load_extension, 'ui-select')
--
--     -- See `:help telescope.builtin`
--     local builtin = require 'telescope.builtin'
--     vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
--     vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
--     vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
--     vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
--     vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
--     vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
--     vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
--     vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
--     vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
--     vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
--     vim.keymap.set('n', '<leader>sp', ':NeovimProjectDiscover<CR>', { desc = '[S]earch [P]rojects' })
--     vim.keymap.set('n', '<leader>si', builtin.buffers, { desc = '[S]earch projects h[I]story' })
--
--     -- Slightly advanced example of overriding default behavior and theme
--     vim.keymap.set('n', '<leader>/', function()
--       -- You can pass additional configuration to Telescope to change the theme, layout, etc.
--       builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
--         winblend = 10,
--         previewer = false,
--       })
--     end, { desc = '[/] Fuzzily search in current buffer' })
--
--     -- It's also possible to pass additional configuration options.
--     --  See `:help telescope.builtin.live_grep()` for information about particular keys
--     vim.keymap.set('n', '<leader>s/', function()
--       builtin.live_grep {
--         grep_open_files = true,
--         prompt_title = 'Live Grep in Open Files',
--       }
--     end, { desc = '[S]earch [/] in Open Files' })
--
--     -- Shortcut for searching your Neovim configuration files
--     vim.keymap.set('n', '<leader>sn', function()
--       builtin.find_files { cwd = vim.fn.stdpath 'config' }
--     end, { desc = '[S]earch [N]eovim files' })
--   end,
-- }
