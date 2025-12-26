local keymaps = require('config.keymaps')
local telescope_config = require('config.telescope')

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

    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.6',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
        },
        config = function()
            require('telescope').setup(telescope_config)
            keymaps.telescope()
        end,
    },

    -- Autopairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    }
}
