return {
    'tpope/vim-fugitive',
    'tpope/vim-commentary',
    'tpope/vim-eunuch',
    'tpope/vim-surround',
    'tommcdo/vim-lion',
    'MaxMEllon/vim-jsx-pretty',
    'romainl/vim-qf',

    -- OpenCode
    {
        'NickvanDyke/opencode.nvim',
        config = function()
            local oc = require("opencode")
            vim.keymap.set({ "n", "x" }, "<C-a>", function() oc.ask("@this: ", { submit = true }) end, { desc = "Ask opencode" })
            vim.keymap.set({ "n", "x" }, "<C-x>", function() oc.select() end, { desc = "Execute opencode" })
        end
    },

    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        end
    },

    -- Autopairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup {}
        end
    }
}
