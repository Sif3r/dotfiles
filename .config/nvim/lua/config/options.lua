local opt = vim.opt

opt.encoding = 'utf-8'
opt.termguicolors = true
opt.mouse = 'a'
opt.clipboard = 'unnamedplus'
opt.showmode = false -- statusline handles this

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = false

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.colorcolumn = "80"
opt.scrolloff = 5
opt.signcolumn = "yes" -- Prevent layout shift for diagnostics

opt.list = true
opt.listchars:append({
    nbsp = '⦸',
    extends = '»',
    precedes = '«',
    trail = '•',
    tab = '▷┅'
})
opt.showbreak = '⤷ '

opt.splitbelow = true
opt.splitright = true

opt.backupdir = vim.fn.expand('~/.nvim/backup//')
opt.directory = vim.fn.expand('~/.nvim/swp//')
opt.undodir = vim.fn.expand('~/.nvim/undo//')
opt.undofile = true

opt.lazyredraw = true
opt.updatetime = 300 -- Faster completion/diagnostics
opt.timeoutlen = 500
