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
