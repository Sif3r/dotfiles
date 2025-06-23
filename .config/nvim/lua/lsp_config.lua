-- ==============================================================================
-- Key Mapping Documentation
-- ------------------------------------------------------------------------------
-- Normal Mode (via on_attach):
--   gd        -> Go to definition
--   gD        -> Go to declaration
--   gi        -> Go to implementation
--   gr        -> List references
--   K         -> Hover documentation
--   <leader>rn -> Rename symbol
--   <leader>ca -> Code action menu
--   [d        -> Jump to previous diagnostic
--   ]d        -> Jump to next diagnostic
--   <leader>ld -> Show diagnostics in floating window
--   <leader>lq -> Populate location list with diagnostics
-- Insert & Select Mode (nvim-cmp + LuaSnip):
--   <Tab>     -> If completion menu visible: select next item;
--                elseif snippet expand/jumpable: expand or jump;
--                else fallback
--   <S-Tab>   -> If completion menu visible: select previous item;
--                elseif snippet jumpable backwards: jump;
--                else fallback
--   <CR>      -> Confirm the selected completion item (auto-select first if none chosen)
--   <C-Space> -> Trigger completion menu
--   <C-e>     -> Abort/close completion menu
--   <C-d>     -> Scroll completion docs down by 4 lines
--   <C-u>     -> Scroll completion docs up by 4 lines
-- ==============================================================================

-- 1) Mason and Mason LSPConfig: ensure servers are installed
require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = { "clangd", "gopls", "lua_ls" },
}

-- 2) Build up capabilities so that nvim-cmp can hook into each server
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

-- 3) Require lspconfig and its util helper
local lspconfig = require("lspconfig")
local util      = require("lspconfig.util")

-- 4) Common on_attach for all servers: bind LSP-related keymaps
local on_attach = function(client, bufnr)
  local buf_map = function(mode, lhs, rhs, desc)
    if desc then desc = "LSP: " .. desc end
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true, desc = desc })
  end

  -- Go-to
  buf_map("n", "gd", vim.lsp.buf.definition,       "Go to definition")
  buf_map("n", "gD", vim.lsp.buf.declaration,      "Go to declaration")
  buf_map("n", "gi", vim.lsp.buf.implementation,   "Go to implementation")
  buf_map("n", "gr", vim.lsp.buf.references,       "List references")

  -- Hover & signature
  buf_map("n", "K",  vim.lsp.buf.hover,            "Hover docs")
  buf_map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature help")

  -- Actions
  buf_map("n", "<leader>rn", vim.lsp.buf.rename,   "Rename symbol")
  buf_map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")

  -- Diagnostics
  buf_map("n", "[d", vim.diagnostic.goto_prev,     "Previous diagnostic")
  buf_map("n", "]d", vim.diagnostic.goto_next,     "Next diagnostic")
  buf_map("n", "<leader>ld", vim.diagnostic.open_float, "Line diagnostics")
  buf_map("n", "<leader>lq", vim.diagnostic.setloclist, "Diagnostics to loclist")
end

-- 5) clangd setup
lspconfig.clangd.setup {
  cmd         = { "clangd", "--background-index" },
  filetypes   = { "c", "cpp" },
  root_dir    = util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
  capabilities = capabilities,
  on_attach   = on_attach,
}

-- 6) gopls setup
lspconfig.gopls.setup {
  cmd         = { "gopls" },
  filetypes   = { "go" },
  root_dir    = util.root_pattern("go.mod", ".git"),
  capabilities = capabilities,
  on_attach   = on_attach,
  settings    = {
    gopls = {
      buildFlags = { "-tags=wiremock" },
    },
  },
}

-- 7) lua_ls (lua-language-server) setup
lspconfig.lua_ls.setup {
  cmd         = { "lua-language-server" },
  filetypes   = { "lua" },
  root_dir    = util.root_pattern(".git", ".luarc.json"),
  capabilities = capabilities,
  on_attach   = on_attach,
  settings    = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- 8) nvim-cmp setup with Tab/Shift-Tab mappings
local cmp     = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<CR>"]      = cmp.mapping.confirm { select = true },
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"]     = cmp.mapping.abort(),
    ["<C-d>"]     = cmp.mapping.scroll_docs(4),
    ["<C-u>"]     = cmp.mapping.scroll_docs(-4),
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp", priority = 1000 },
    { name = "luasnip",  priority = 750  },
    { name = "buffer",   priority = 500  },
    { name = "path",     priority = 250  },
  }),
  formatting = {
    format = function(entry, vim_item)
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip  = "[LuaSnip]",
        buffer   = "[Buffer]",
        path     = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },
  experimental = {
    ghost_text = true,
  },
})

-- 9) Optional visual tweaks
vim.o.winborder = "rounded"                                    -- nicer floating border
vim.diagnostic.config({ virtual_lines = true })                 -- inline diagnostics
require("luasnip.loaders.from_vscode").lazy_load()             -- load snippets
vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment" })  -- dim ghost text
