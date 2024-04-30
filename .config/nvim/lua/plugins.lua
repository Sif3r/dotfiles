local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
-- 'ludovicchabant/vim-gutentags',
local plugins = {
    'itchyny/lightline.vim',
    'tpope/vim-fugitive',
    'tpope/vim-commentary',
    'romainl/vim-qf',
    'romainl/vim-qlist',
    'tommcdo/vim-lion',
    'tpope/vim-eunuch',
    'tpope/vim-surround',
    'MaxMEllon/vim-jsx-pretty',
    'ellisonleao/gruvbox.nvim',
    'mfussenegger/nvim-jdtls',
    {'catppuccin/nvim', name = 'catppuccin', priority = 1000},
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.6',
        dependencies = {
            {'nvim-lua/plenary.nvim'},
            {'nvim-treesitter/nvim-treesitter'}
        }
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},         -- Required
            {'hrsh7th/cmp-nvim-lsp'},     -- Required
            {'hrsh7th/cmp-buffer'},       -- Optional
            {'hrsh7th/cmp-path'},         -- Optional
            {'saadparwaiz1/cmp_luasnip'}, -- Optional
            {'hrsh7th/cmp-nvim-lua'},     -- Optional

            -- Snippets
            {'L3MON4D3/LuaSnip'},             -- Required
            {'rafamadriz/friendly-snippets'}, -- Optional
        }
    }
}

local opts = {}

require("lazy").setup(plugins, opts)
