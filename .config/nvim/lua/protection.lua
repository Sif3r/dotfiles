local a = vim.api
local f = vim.fn

local function insert_gates()
    local filename = f.expand("%:t"):upper():gsub("%.", "_")
    local lines = {
        "#ifndef " .. filename .. "_",
        "#define " .. filename .. "_",
        "",
        "#endif /* !" .. filename .. "_ */"
    }
    a.nvim_buf_set_lines(0, 0, 0, false, lines)
    a.nvim_command('normal! dd')
    a.nvim_command('normal! k')
end

a.nvim_create_autocmd("BufNewFile", {
    pattern = {"*.h", "*.hpp"},
    callback = insert_gates,
})
