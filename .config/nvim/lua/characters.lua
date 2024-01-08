local cmd = vim.cmd
local o = vim.o
local opt = vim.opt

-- Removing trailing white space
cmd("autocmd BufWritePre * %s/\\s\\+$//e")

-- Show whitespace
o.list = true
opt.listchars:append({nbsp = '⦸'}) -- U+29B8
-- opt.listchars:append({tab = '▷┅'}) -- U+25B7 / U+2505
opt.listchars:append({extends = '»'}) -- U+00BB
opt.listchars:append({precedes = '«'}) -- U+00AB
opt.listchars:append({trail = '•'}) -- U+2022 Bullet
o.showbreak = '⤷ ' -- U+2937
