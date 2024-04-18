local cmd = vim.cmd
local opt = vim.opt
local g = vim.g
local s = vim.s
local indent = 4

-- cmd([[ filetype plugin indent on ]])


vim.g.loaded_python3_provider = 0
vim.o.termguicolors = true
vim.opt.guicursor = "n:block"

opt.backspace = { "eol", "start", "indent" } -- allow backspacing over everything in insert mode
opt.clipboard = "unnamedplus"              -- allow neovim to access the system clipboard
vim.opt.fileencoding = "utf-8"             -- the encoding written to a file
opt.encoding = "utf-8"                     -- the encoding
opt.matchpairs = { "(:)", "{:}", "[:]", "<:>" }
opt.syntax = "enable"

-- indention
opt.autoindent = true    -- auto indentation
opt.expandtab = true     -- convert tabs to spaces
opt.shiftwidth = indent  -- the number of spaces inserted for each indentation
opt.smartindent = true   -- make indenting smarter
opt.softtabstop = indent -- when hitting <BS>, pretend like a tab is removed, even if spaces
opt.tabstop = indent     -- insert 2 spaces for a tab
opt.shiftround = true    -- use multiple of shiftwidth when indenting with "<" and ">"

-- search
opt.hlsearch = false   -- highlight all matches on previous search pattern
opt.ignorecase = true -- ignore case in search patterns
opt.smartcase = true  -- smart case
opt.wildignore = opt.wildignore + { "*/node_modules/*", "*/.git/*", "*/vendor/*" }
opt.wildmenu = true   -- make tab completion for files/buffers act like bash

-- ui
opt.cursorline = true -- highlight the current line
opt.laststatus = 2    -- only the last window will always have a status line
opt.lazyredraw = true -- don"t update the display while executing macros
opt.list = true
-- You can also add "space" or "eol", but I feel it"s quite annoying
-- opt.listchars = {
  -- tab = "┊ ",
  -- trail = "·",
  -- extends = "»",
  -- precedes = "«",
  -- nbsp = "×"
-- }

-- Hide cmd line
opt.cmdheight = 1      -- more space in the neovim command line for displaying messages

opt.mouse = "a"        -- allow the mouse to be used in neovim
opt.number = true      -- set numbered lines
opt.scrolloff = 18     -- minimal number of screen lines to keep above and below the cursor
opt.sidescrolloff = 3  -- minimal number of screen columns to keep to the left and right (horizontal) of the cursor if wrap is `false`
opt.signcolumn = "no" -- always show the sign column, otherwise it would shift the text each time
opt.splitbelow = true  -- open new split below
opt.splitright = true  -- open new split to the right
opt.wrap = false       -- display a long line

-- backups
opt.backup = false      -- create a backup file
opt.swapfile = false    -- creates a swapfile
opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

-- autocomplete
opt.completeopt = { "menu", "menuone", "noselect" } -- mostly just for cmp
opt.shortmess = opt.shortmess + {
  c = true
} -- hide all the completion messages, e.g. "-- XXX completion (YYY)", "match 1 of 2", "The only match", "Pattern not found"

-- By the way, -- INSERT -- is unnecessary anymore because the mode information is displayed in the statusline.
opt.showmode = false

-- perfomance
-- remember N lines in history
opt.history = 100    -- keep 100 lines of history
opt.redrawtime = 1500
opt.timeoutlen = 250 -- time to wait for a mapped sequence to complete (in milliseconds)
opt.ttimeoutlen = 10
opt.updatetime = 100 -- signify default updatetime 4000ms is not good for async update

-- theme
opt.termguicolors = true -- enable 24-bit RGB colors

-- persistent undo
-- Don"t forget to create folder $HOME/.local/share/nvim/undo
local undodir = vim.fn.stdpath("data") .. "/undo"
opt.undofile = true -- enable persistent undo
opt.undodir = undodir
opt.undolevels = 1000
opt.undoreload = 10000

-- fold
opt.foldmethod = "marker"
opt.foldlevel = 99


-- Disable builtin plugins
local disabled_built_ins = { "2html_plugin", "getscript", "getscriptPlugin", "gzip", "logipat", "netrw", "netrwPlugin",
  "netrwSettings", "netrwFileHandlers", "matchit", "tar", "tarPlugin", "rrhelper",
  "spellfile_plugin", "vimball", "vimballPlugin", "zip", "zipPlugin", "tutor", "rplugin",
  "synmenu", "optwin", "compiler", "bugreport", "ftplugin" }

for _, plugin in pairs(disabled_built_ins) do
  g["loaded_" .. plugin] = 1
end


opt.statusline = "%f"


-- Ignore compiled files
opt.wildignore = "__pycache__"
opt.wildignore:append { "*.o", "*~", "*.pyc", "*pycache*" }
opt.wildignore:append { "Cargo.lock", "Cargo.Bazel.lock" }

-- Cool floating window popup menu for completion on command line
-- opt.pumblend = 17
-- opt.wildmode = "longest:full"
-- opt.wildoptions = "pum"
-- maybe delete this

-- opt.showmode = false -- dunno what this does
-- opt.showcmd = true -- i dunno what this does
opt.cmdheight = 1 -- Height of the command bar
opt.incsearch = false -- maybe remove this
opt.incsearch = false -- Makes search act like search in modern browsers
-- opt.showmatch = true -- show matching brackets when text indicator is over them
opt.relativenumber = false -- Show line numbers
opt.number = true -- But show the actual number for the line we're on
opt.ignorecase = true -- Ignore case when searching...
opt.smartcase = true -- ... unless there is a capital letter in the query
opt.hidden = false
opt.hidden = true -- you can leave the file without saving
opt.hlsearch = false

-- opt.equalalways = false -- I don't like my windows changing all the time
-- opt.splitright = true -- Prefer windows splitting to the right
-- opt.splitbelow = true -- Prefer windows splitting to the bottom
-- opt.updatetime = 1000 -- Make updates happen faster
-- opt.scrolloff = 10 -- Make it so there are always ten lines below my cursor



-- Tabs
opt.autoindent = true
opt.cindent = true
opt.wrap = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true

opt.breakindent = true
opt.showbreak = string.rep(" ", 3) -- Make it so that long lines wrap smartly
opt.linebreak = true

-- opt.foldmethod = "marker"
-- opt.foldlevel = 0
-- opt.modelines = 1
-- opt.belloff = "all" -- Just turn the dang bell off
-- opt.clipboard = "unnamedplus"

opt.inccommand = "split"
opt.swapfile = false -- Living on the edge

opt.mouse = "a"

opt.formatoptions=''
-- opt.formatoptions:remove('cro')
-- command = "set fo-=c fo-=r fo-=o"
--
opt.cursorline = false


-- vim.cmd('set nohlsearch')
-- vim.cmd('set fo-=c fo-=r fo -=o')
