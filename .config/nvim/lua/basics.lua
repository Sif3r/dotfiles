local o = vim.o
local opt = vim.opt
local g = vim.g
local cmd = vim.cmd

-- Set local value
local file_types = { 'html', 'css', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' }

-- Basics options
o.encoding = 'utf-8'
o.termguicolors = true
g.python3_host_prog = '/usr/bin/python3'
g.mapleader = ' '

-- Indent and line formatting
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true
cmd('autocmd FileType ' .. table.concat(file_types, ',') .. ' setlocal tabstop=2 shiftwidth=2')
cmd('autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4')

-- Line numbers and column
o.number = true
o.relativenumber = true
opt.colorcolumn = {80}

-- Path and search
o.path = o.path .. '**'
opt.path:append("**")

-- Clipboard and cursorline
o.clipboard = 'unnamedplus'
o.cursorline = true

-- Create folder if doesn't exist
vim.api.nvim_create_autocmd({"BufWritePre", "FileWritePre"}, {
  pattern = "*",
  callback = function()
    local dir = vim.fn.expand("<afile>:p:h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
})

-- Miscellaneous options
o.mouse = 'a' -- integer the mouse management
o.showmode = false -- as we got the status through lightline don't need to display twice
o.autowrite = true -- autosaves before changing buffers
o.autoread = true -- Reload a file when it is changed from the outside
o.lazyredraw = true -- attempts to kill vim lag
o.ttimeoutlen = 0 -- no timeout when switching modes
o.scrolloff = 5

-- lightline config
g.lightline = {
  colorscheme = 'seoul256',
  active = {
    left = {
      { 'mode', 'paste' },
      { 'gitbranch', 'readonly', 'filename', 'modified' },
    },
  },
  component_function = {
    gitbranch = 'FugitiveHead',
  },
}

-- Colorscheme
cmd('syntax on')
o.background = "dark"
cmd.colorscheme "catppuccin"
