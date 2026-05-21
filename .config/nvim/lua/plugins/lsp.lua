-- Set capabilities for ALL servers via the '*' wildcard
vim.lsp.config('*', {
    capabilities = require('blink.cmp').get_lsp_capabilities(),
})

-- Per-server overrides (merged on top of nvim-lspconfig defaults)
vim.lsp.config('gopls', {
    settings = { gopls = { buildFlags = { '-tags=wiremock' } } },
})

-- Install server binaries via Mason
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { 'clangd', 'gopls', 'lua_ls', 'ts_ls', 'svelte' },
    automatic_enable = true,
})

-- Completion
require('blink.cmp').setup({
    keymap = {
        preset = 'none',
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<CR>']      = { 'accept', 'fallback' },
        ['<Tab>']     = { 'select_next', 'snippet_forward', 'fallback' },
        ['<S-Tab>']   = { 'select_prev', 'snippet_backward', 'fallback' },
        ['<C-b>']     = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>']     = { 'scroll_documentation_down', 'fallback' },
    },
    appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
    },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 0 },
        list = { selection = { preselect = false, auto_insert = true } },
    },
})

-- Lua LSP enhancements (vim API types, uv types)
require('lazydev').setup({
    library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
    },
})

-- Nvim 0.12 built-in LSP keymaps (no need to redefine these):
--   K          → hover documentation
--   gra        → code action
--   grn        → rename symbol
--   grr        → references
--   gri        → implementations
--   grt        → type definition
--   gO         → document symbols
--   C-s (ins)  → signature help
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local opts = { buffer = ev.buf }
        -- Go to definition (not a 0.12 default)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        -- Open diagnostic float for current line
        vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
        -- Jump to previous diagnostic
        vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
        -- Jump to next diagnostic
        vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count =  1, float = true }) end, opts)
    end,
})

vim.diagnostic.config({
    virtual_lines = { current_line = true},
    float = { border = 'rounded' },
})
