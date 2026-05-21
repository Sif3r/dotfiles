local plugins = {
    { src = 'https://github.com/catppuccin/nvim',                   name = 'catppuccin' },
    { src = 'https://github.com/echasnovski/mini.statusline',       name = 'mini.statusline' },
    { src = 'https://github.com/folke/snacks.nvim',                 name = 'snacks.nvim' },
    { src = 'https://github.com/echasnovski/mini.surround',         name = 'mini.surround' },
    { src = 'https://github.com/windwp/nvim-autopairs',             name = 'nvim-autopairs' },
    { src = 'https://github.com/tommcdo/vim-lion',                  name = 'vim-lion' },
    { src = 'https://github.com/romainl/vim-qf',                    name = 'vim-qf' },
    { src = 'https://github.com/tpope/vim-fugitive',                name = 'vim-fugitive' },
    { src = 'https://github.com/tpope/vim-eunuch',                  name = 'vim-eunuch' },
    { src = 'https://github.com/NickvanDyke/opencode.nvim',         name = 'opencode.nvim' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter',   name = 'nvim-treesitter' },
    { src = 'https://github.com/williamboman/mason.nvim',           name = 'mason.nvim' },
    { src = 'https://github.com/williamboman/mason-lspconfig.nvim', name = 'mason-lspconfig.nvim' },
    { src = 'https://github.com/neovim/nvim-lspconfig',             name = 'nvim-lspconfig' },
    { src = 'https://github.com/folke/lazydev.nvim',                name = 'lazydev.nvim' },
    { src = 'https://github.com/Bilal2453/luvit-meta',              name = 'luvit-meta' },
    { src = 'https://github.com/saghen/blink.lib',                  name = 'blink.lib' },
    { src = 'https://github.com/saghen/blink.cmp',                  name = 'blink.cmp' },
    { src = 'https://github.com/rafamadriz/friendly-snippets',      name = 'friendly-snippets' },
    { src = 'https://github.com/mfussenegger/nvim-dap',             name = 'nvim-dap' },
    { src = 'https://github.com/rcarriga/nvim-dap-ui',              name = 'nvim-dap-ui' },
    { src = 'https://github.com/nvim-neotest/nvim-nio',             name = 'nvim-nio' },
    { src = 'https://github.com/jay-babu/mason-nvim-dap.nvim',      name = 'mason-nvim-dap.nvim' },
    { src = 'https://github.com/leoluz/nvim-dap-go',                name = 'nvim-dap-go' },
}

local ok, err = pcall(vim.pack.add, plugins)

if not ok then
    vim.g.pack_ready = false
    vim.schedule(function()
        vim.notify(
            '[vim.pack] Initial install timed out.\n' ..
            'Run  :lua vim.pack.update()  then restart nvim.\n' ..
            '(' .. (err or '') .. ')',
            vim.log.levels.WARN
        )
    end)
    return
end

vim.g.pack_ready = true

-- Build steps triggered after install or update
vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
        local name = ev.data.spec.name
        if name == 'nvim-treesitter' then
            vim.cmd('TSUpdate')
        elseif name == 'blink.cmp' then
            -- Downloads the pre-built native library for the current platform
            require('blink.cmp').build():wait(60000)
        end
    end,
})
