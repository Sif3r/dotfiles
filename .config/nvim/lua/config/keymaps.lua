local set = vim.keymap.set

vim.g.mapleader = ' '

set('n', '<C-j>', '<C-w>j', { desc = 'Move to window below' })
set('n', '<C-k>', '<C-w>k', { desc = 'Move to window above' })
set('n', '<C-l>', '<C-w>l', { desc = 'Move to window right' })
set('n', '<C-h>', '<C-w>h', { desc = 'Move to window left' })

local M = {}

function M.snacks()
    local snacks = require("snacks")
    set('n', '<leader>ff', function() snacks.picker.files() end, { desc = 'Find files' })
    set('n', '<leader>fg', function() snacks.picker.grep() end, { desc = 'Live grep' })
    set('n', '<leader>fb', function() snacks.picker.buffers() end, { desc = 'Buffers' })
    set('n', '<leader>fh', function() snacks.picker.help() end, { desc = 'Help tags' })
end

function M.opencode()
    local oc = require("opencode")
    set({ "n", "x" }, "<C-a>", function() oc.ask("@this: ", { submit = true }) end, { desc = "Ask opencode" })
    set({ "n", "x" }, "<C-x>", function() oc.select() end, { desc = "Execute opencode" })
end

return M
