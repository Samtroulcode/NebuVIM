-- NebuVim core editor options.
-- Keep native behavior predictable here so plugin specs only handle domain overrides.

-- Basic editing defaults.
-- Two-space indentation keeps Lua and web stacks aligned with the rest of the repo.
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- Disable unused providers to avoid startup noise and pointless health warnings.
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- UI defaults.
vim.g.have_nerd_font = true

-- `number` + `relativenumber` keeps the current line explicit while preserving jump math.
vim.o.number = true
vim.o.relativenumber = true

-- Mouse support is mainly useful for resizing and terminal panes.
vim.o.mouse = 'a'

-- Lualine already exposes mode, so the built-in indicator becomes redundant noise.
vim.o.showmode = false

-- Delay clipboard sync until after startup to keep boot cost low.
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Navigation and search ergonomics.
vim.o.breakindent = true

vim.o.undofile = true

-- Smart case keeps `/foo` forgiving while `/Foo` stays precise.
vim.o.ignorecase = true
vim.o.smartcase = true

-- Avoid text shifting when diagnostics or git signs appear.
vim.o.signcolumn = 'yes'

vim.o.updatetime = 250

-- Short timeout keeps leader chains snappy without making them hard to complete.
vim.o.timeoutlen = 300

-- New splits open in reading order so layout changes feel predictable.
vim.o.splitright = true
vim.o.splitbelow = true

-- Whitespace markers stay off by default to keep prose and notes visually calm.
-- vim.o.list = true
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions in a split so broad search/replace stays reviewable.
vim.o.inccommand = 'split'

vim.o.cursorline = true

-- Extra context reduces jumpiness when navigating diagnostics or search results.
vim.o.scrolloff = 10

-- Guardrails for destructive editor actions.
vim.o.confirm = true

-- Display and completion.
vim.opt.termguicolors = true

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.pumheight = 12

-- Preserve viewport stability when windows open or close.
vim.opt.splitkeep = 'screen'

-- Shared UI surfaces.
vim.opt.laststatus = 3

vim.opt.showtabline = 2

-- Prefer ripgrep so `:grep` matches Snacks and CLI expectations.
if vim.fn.executable 'rg' == 1 then
  vim.opt.grepprg = 'rg --vimgrep --smart-case'
  vim.opt.grepformat = '%f:%l:%c:%m'
end

vim.opt.smoothscroll = true

-- Local persistence stays in undo files instead of swap/backup clutter.
vim.opt.swapfile = false
vim.opt.backup = false

-- Folding uses Treesitter expressions but stays opt-in to avoid surprise hidden code.
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldenable = false

-- Writing defaults.
vim.opt.spell = true
vim.opt.spelllang = { 'en', 'fr' }
