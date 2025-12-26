local keymaps = require('config.keymaps')

return {
    { 'tpope/vim-fugitive', cmd = { "Git", "G" } },
    { 'tpope/vim-eunuch', cmd = { "Remove", "Delete", "Move", "Chmod" } },
    { 'tommcdo/vim-lion', event = "VeryLazy" },
    { 'romainl/vim-qf', ft = "qf" },
    {
        'echasnovski/mini.surround',
        version = '*',
        event = "VeryLazy",
        config = function()
            require('mini.surround').setup()
        end,
    },

    {
        'NickvanDyke/opencode.nvim',
        event = "VeryLazy",
        config = keymaps.opencode,
    },

    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            picker = { enabled = true },
        },
        config = function(_, opts)
            require("snacks").setup(opts)
            keymaps.snacks()
        end,
    },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    }
}
