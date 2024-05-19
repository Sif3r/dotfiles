require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "clangd", "gopls", "lua_ls" },
}

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
