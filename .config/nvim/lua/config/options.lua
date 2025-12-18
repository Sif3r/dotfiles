local opt = vim.opt

-- General
opt.encoding = 'utf-8'
opt.termguicolors = true
opt.mouse = 'a'
opt.clipboard = 'unnamedplus'
opt.showmode = false -- Lightline handles this

-- Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = false

-- UI & Appearance
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.colorcolumn = "80"
opt.scrolloff = 5
opt.signcolumn = "yes" -- Prevent layout shift for diagnostics

-- Whitespace Characters
opt.list = true
opt.listchars:append({
    nbsp = '⦸',
    extends = '»',
    precedes = '«',
    trail = '•',
    tab = '▷┅'
})
opt.showbreak = '⤷ '

-- Window Splitting
opt.splitbelow = true
opt.splitright = true

-- Backup & Undo
opt.backupdir = vim.fn.expand('~/.nvim/backup//')
opt.directory = vim.fn.expand('~/.nvim/swp//')
opt.undodir = vim.fn.expand('~/.nvim/undo//')
opt.undofile = true

-- Performance
opt.lazyredraw = true
opt.updatetime = 300 -- Faster completion/diagnostics
opt.timeoutlen = 500
