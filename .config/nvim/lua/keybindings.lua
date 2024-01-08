local api = vim.api
local o = vim.o

-- Modif command for switch
api.nvim_set_keymap('n', '<C-j>', '<C-w><C-j>', { noremap = true })
api.nvim_set_keymap('n', '<C-k>', '<C-w><C-k>', { noremap = true })
api.nvim_set_keymap('n', '<C-l>', '<C-w><C-l>', { noremap = true })
api.nvim_set_keymap('n', '<C-h>', '<C-w><C-h>', { noremap = true })
o.splitbelow = true
o.splitright = true

-- autoclose
api.nvim_set_keymap('i', '"', '""<left>', { noremap = true })
api.nvim_set_keymap('i', "'", "''<left>", { noremap = true })
api.nvim_set_keymap('i', '(', '()<left>', { noremap = true })
api.nvim_set_keymap('i', '[', '[]<left>', { noremap = true })
api.nvim_set_keymap('i', '{', '{}<left>', { noremap = true })
-- api.nvim_set_keymap('i', '{', '{<CR><BS>}<Esc>ko', { noremap = true })
