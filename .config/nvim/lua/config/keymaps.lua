local set = vim.keymap.set

vim.g.mapleader = ' '

-- Window Navigation
set('n', '<C-j>', '<C-w>j', { desc = 'Move to window below' })
set('n', '<C-k>', '<C-w>k', { desc = 'Move to window above' })
set('n', '<C-l>', '<C-w>l', { desc = 'Move to window right' })
set('n', '<C-h>', '<C-w>h', { desc = 'Move to window left' })

-- Plugin keymaps
local M = {}

function M.telescope()
    local builtin = require('telescope.builtin')
    set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
    set('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep' })
    set('n', '<leader>fb', builtin.buffers, { desc = 'Buffers' })
    set('n', '<leader>fh', builtin.help_tags, { desc = 'Help tags' })
end

function M.opencode()
    local oc = require("opencode")
    set({ "n", "x" }, "<C-a>", function() oc.ask("@this: ", { submit = true }) end, { desc = "Ask opencode" })
    set({ "n", "x" }, "<C-x>", function() oc.select() end, { desc = "Execute opencode" })
end

return M
