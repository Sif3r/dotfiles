require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "clangd", "gopls", "lua_ls" },
}

vim.lsp.config.clangd = {
  cmd = { 'clangd', '--background-index' },
  root_markers = { 'compile_commands.json', 'compile_flags.txt' },
  filetypes = { 'c', 'cpp' },
  -- Add any other clangd-specific settings here
}

-- gopls configuration
vim.lsp.config.gopls = {
  -- You'll need to define cmd, root_markers, and filetypes for gopls
  -- Example (adjust as needed based on gopls docs):
  cmd = { 'gopls' },
  root_markers = { 'go.mod', '.git' },
  filetypes = { 'go' },
  settings = {
    gopls = {
      -- Add any gopls-specific settings here
      buildFlags = { "-tags=wiremock" },
    },
  },
}

-- lua_ls (Lua Language Server) configuration
vim.lsp.config.lua_ls = {
  -- Example (adjust as needed):
  cmd = { 'lua-language-server' }, -- Ensure this executable is on your PATH
  root_markers = { '.git', '.luarc.json' }, -- Common Lua project roots
  filetypes = { 'lua' },
  settings = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Enable the desired LSP servers.
-- Neovim will try to start these servers when a file of their 'filetypes' is opened,
-- and a 'root_marker' is found in an ancestor directory.
vim.lsp.enable({ 'clangd', 'gopls', 'lua_ls' })

-- Built-in auto-completion (as described in the blog post)
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

-- Improved hover documentation border
vim.o.winborder = 'rounded'

-- Diagnostic configuration (virtual text and virtual lines)
vim.diagnostic.config({
--  virtual_text = true, -- Show diagnostics inline
  virtual_lines = true, -- Show diagnostics on separate virtual lines
  -- You can add current_line = true to either of the above for only the current line
})

-- You'll still need nvim-cmp if you want advanced autocompletion with snippets etc.
-- This part remains similar as it's separate from LSP server setup.
require('cmp').setup {
  sources = {
    { name = 'nvim_lsp' } -- Use Neovim's LSP source for completions
  },
  -- Add other nvim-cmp configurations here, e.g., keymaps for completion
  -- mapping = cmp.mapping.preset.insert({
  --   ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  --   ['<C-f>'] = cmp.mapping.scroll_docs(4),
  --   ['<C-Space>'] = cmp.mapping.complete(),
  --   ['<C-e>'] = cmp.mapping.abort(),
  --   ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept selected item.
  -- }),
}
