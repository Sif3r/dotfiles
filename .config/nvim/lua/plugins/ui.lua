return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme "catppuccin"
        end
    },
    { 'ellisonleao/gruvbox.nvim' },
    {
        'itchyny/lightline.vim',
        init = function()
            -- Variables for Vim script plugins often go in 'init'
            vim.g.lightline = {
                colorscheme = 'seoul256',
                active = {
                    left = {
                        { 'mode', 'paste' },
                        { 'gitbranch', 'readonly', 'filename', 'modified' },
                    },
                },
                component_function = {
                    gitbranch = 'FugitiveHead',
                },
            }
        end
    }
}
