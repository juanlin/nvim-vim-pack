local o = vim.opt

-- Tab options
o.expandtab = true  -- turn tabs into spaces
o.tabstop = 2       -- display width of a tab
o.shiftwidth = 2    -- indent size for code
o.softtabstop = 2   -- <Tab>/<BS> over indent behavior

-- Search options
o.ignorecase = true
o.smartcase = true
o.showmatch = true  -- redundant with FileType
o.incsearch = true  -- default true
o.hlsearch = true   -- default true

-- Cursor and numbers
o.number = true
o.relativenumber = true
o.cursorline = true
o.cursorlineopt = 'screenline,number'
o.scrolloff = 2

-- Window split
o.splitright = true
o.splitbelow = true

-- Customize return messages
o.shortmess:append{ I = true } -- suppress intro message

-- Persistent Undo
local undodir = vim.fn.stdpath('cache') .. '/undo'
vim.fn.mkdir(undodir, 'p')
o.undodir = undodir
o.undofile = true
