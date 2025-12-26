local keymaps = require('config.keymaps')

return {
    -- Simple plugins (no config needed)
    'tpope/vim-fugitive',
    'tpope/vim-eunuch',
    'tpope/vim-surround',
    'tommcdo/vim-lion',
    'romainl/vim-qf',

    -- OpenCode
    {
        'NickvanDyke/opencode.nvim',
        config = keymaps.opencode,
    },

    -- Snacks.nvim (Replaces Telescope)
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            picker = { enabled = true },
            -- explorer = { enabled = true }, -- Optional: Replaces file explorers like NeoTree
        },
        config = function(_, opts)
            require("snacks").setup(opts)
            keymaps.snacks()
        end,
    },

    -- Autopairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    }
}
