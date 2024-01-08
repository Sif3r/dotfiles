local o = vim.o

-- Search option
o.ignorecase = true -- Ignore case on search
o.smartcase = true -- Ignore case unless there is an uppercase letter in the pattern
o.incsearch = true -- Move cursor to the matched string
o.hlsearch = false -- Don't highlight matched strings
