local opt = vim.opt

-- Line numbers
opt.number         = true   -- show current line number
opt.relativenumber = true   -- relative numbers for all other lines

-- Indentation
opt.tabstop     = 2         -- tab = 2 spaces
opt.shiftwidth  = 2         -- indent = 2 spaces
opt.expandtab   = true      -- use spaces instead of tabs
opt.smartindent = true      -- auto-indent new lines

-- Search
opt.ignorecase = true       -- case-insensitive search...
opt.smartcase  = true       -- ...unless query has uppercase

-- UI
opt.signcolumn  = 'yes'     -- always show sign column (prevents layout shifts)
opt.cursorline  = true      -- highlight current line
opt.scrolloff   = 8         -- keep 8 lines above/below cursor
opt.wrap        = false     -- no line wrapping
opt.showmode    = false     -- mode already shown in statusline
opt.cmdheight   = 0         -- hide cmdline when not in use
opt.splitright  = true      -- vsplit opens to the right
opt.splitbelow  = true      -- split opens below

-- Files
opt.undofile  = true        -- persist undo history across sessions
opt.swapfile  = false       -- no swap files
opt.updatetime = 200        -- faster CursorHold (used by LSP hover, signs)

-- Clipboard
opt.clipboard = 'unnamedplus' -- use system clipboard

-- Mouse
opt.mouse = 'a'             -- enable mouse in all modes
