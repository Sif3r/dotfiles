return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        -- event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},
            {'neovim/nvim-lspconfig'},

            {
                'saghen/blink.cmp',
                version = 'v0.*',
                dependencies = 'rafamadriz/friendly-snippets',
                build = 'cargo build --release',

                ---@module 'blink.cmp'
                ---@type blink.cmp.Config
                opts = {
                    keymap = {
                        preset = 'none',
                        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
                        ['<CR>'] = { 'accept', 'fallback' },
                        ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
                        ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
                        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
                        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
                    },

                    appearance = {
                        use_nvim_cmp_as_default = true,
                        nerd_font_variant = 'mono',
                    },

                    sources = {
                        default = { 'lsp', 'path', 'snippets', 'buffer' },
                    },

                    completion = {
                        documentation = {
                            auto_show = true,
                            auto_show_delay_ms = 0,
                        },
                        list = { selection = { preselect = false, auto_insert = true } },
                    },
                },
                opts_extend = { "sources.default" }
            },

            {
                "folke/lazydev.nvim",
                ft = "lua",
                opts = {
                    library = {
                        { path = "luvit-meta/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        config = function()
            local lsp_zero = require('lsp-zero')

            lsp_zero.on_attach(function(_, bufnr)
                local opts = {buffer = bufnr, remap = false}
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
                vim.keymap.set("n", "[d", function() vim.diagnostic.jump({count=-1, float=true}) end, opts)
                vim.keymap.set("n", "]d", function() vim.diagnostic.jump({count=1, float=true}) end, opts)
            end)

            local capabilities = require('blink.cmp').get_lsp_capabilities()

            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = {'clangd', 'gopls', 'lua_ls','ts_ls' },
                handlers = {
                    function(server_name)
                        require('lspconfig')[server_name].setup({ capabilities = capabilities })
                    end,
                    lua_ls = function()
                        require('lspconfig').lua_ls.setup({ capabilities = capabilities })
                    end,
                    gopls = function()
                        require('lspconfig').gopls.setup({
                            capabilities = capabilities,
                            settings = { gopls = { buildFlags = { "-tags=wiremock" } } }
                        })
                    end,
                }
            })

            vim.diagnostic.config({
                virtual_lines = true,
                float = { border = 'rounded' }
            })
        end
    }
}
