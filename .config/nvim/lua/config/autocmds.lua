local api = vim.api

api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = "*",
    callback = function(event)
        local dir = vim.fn.fnamemodify(event.file, ":p:h")
        if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, "p")
        end
    end,
})

api.nvim_create_autocmd("FileType", {
    pattern = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
    end,
})

api.nvim_create_autocmd("FileType", {
    pattern = "go",
    callback = function()
        vim.opt_local.expandtab = false
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
    end
})

api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- C/C++ Header Guards
api.nvim_create_autocmd("BufNewFile", {
    pattern = {"*.h", "*.hpp"},
    callback = function()
        local filename = vim.fn.expand("%:t"):upper():gsub("%.", "_")
        local lines = {
            "#ifndef " .. filename .. "_",
            "#define " .. filename .. "_",
            "",
            "#endif /* !" .. filename .. "_ */"
        }
        api.nvim_buf_set_lines(0, 0, 0, false, lines)
        vim.cmd('normal! dd')
        vim.cmd('normal! k')
    end,
})

-- Enable Treesitter Highlighting & Indent
api.nvim_create_autocmd("FileType", {
    callback = function(args)
        -- 1. Guard: Stop if file is too big
        local max_filesize = 100 * 1024
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
        if ok and stats and stats.size > max_filesize then
            return
        end

        -- 2. Action: Start Treesitter
        local has_parser, _ = pcall(vim.treesitter.start, args.buf)

        -- 3. Optional: Enable Indentation
        if has_parser then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
    end,
})

-- Add custom filetypes
vim.filetype.add({
    pattern = {
        [".*%.yaml%.j2"] = "yaml",
        [".*%.yml%.j2"] = "yaml",
    },
})
