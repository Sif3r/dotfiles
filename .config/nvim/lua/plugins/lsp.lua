return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            -- LSP
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},
            {'neovim/nvim-lspconfig'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-buffer'},       -- Required for buffer suggestions
            {'hrsh7th/cmp-path'},         -- Required for file path suggestions
            {'saadparwaiz1/cmp_luasnip'}, -- Required for snippet suggestions
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},

            -- Lua Dev (Fixes "Undefined global vim")
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

            -- On Attach
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

            -- Mason Setup
            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = {'clangd', 'gopls', 'lua_ls','ts_ls' },
                handlers = {
                    lsp_zero.default_setup,
                    lua_ls = function()
                        -- lazydev handles configuration
                        require('lspconfig').lua_ls.setup({})
                    end,
                    gopls = function()
                        require('lspconfig').gopls.setup({
                            settings = {
                                gopls = { buildFlags = { "-tags=wiremock" } }
                            }
                        })
                    end,
                }
            })

            -- Autocompletion (CMP) Setup
            local cmp = require('cmp')
            local cmp_action = lsp_zero.cmp_action()

            -- Load snippets from friendly-snippets
            require('luasnip.loaders.from_vscode').lazy_load()

            cmp.setup({
                sources = {
                    {name = 'path'},
                    {name = 'nvim_lsp'},
                    {name = 'luasnip', keyword_length = 2},
                    {name = 'buffer', keyword_length = 3},
                },
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<CR>'] = cmp.mapping.confirm({select = true}),
                    ['<Tab>'] = cmp_action.tab_complete(),
                    ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
                    ['<C-Space>'] = cmp.mapping.complete(),
                }),
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                }
            })

            -- UI Polish
            vim.diagnostic.config({
                virtual_lines = true,
                float = { border = 'rounded' }
            })
        end
    }
}
