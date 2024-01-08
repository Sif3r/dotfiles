require("mason").setup()
require("mason-lspconfig").setup()
--require("lspconfig").lua-language-server.setup {}
--    ensure_installed = { "clangd", "css-lsp", "gopls", "html-lsp", "lua-language-server", "typescript-language-server"  },
--}

require'cmp'.setup {
    sources = {
        { name = 'nvim_lsp' }
    }
}

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- The following example advertise capabilities to `clangd`.
require'lspconfig'.clangd.setup {
    capabilities = capabilities,
}

require'lspconfig'.gopls.setup {
    capabilities = capabilities,
}

require'lspconfig'.lua_ls.setup {
    capabilities = capabilities,
}
require'lspconfig'.cssls.setup {
    capabilities = capabilities,
}

require'lspconfig'.unocss.setup {
    capabilities = capabilities,
}

require'lspconfig'.html.setup {
    capabilities = capabilities,
}

require'lspconfig'.phpactor.setup {
    capabilities = capabilities,
}

local lsp = require('lsp-zero').preset({
  name = 'minimal',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = false,
})

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()

-- Display dignostic error
vim.diagnostic.config({ virtual_text = true })
