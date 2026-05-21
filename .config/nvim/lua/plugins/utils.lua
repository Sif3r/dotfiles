local keymaps = require('config.keymaps')

require('mini.surround').setup()
require('nvim-autopairs').setup({})

require('snacks').setup({
    picker = { enabled = true },
    input  = { enabled = true }, -- used by opencode.nvim ask()
})
keymaps.snacks()

keymaps.opencode()
