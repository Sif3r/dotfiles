local function disable_large_files(_, buf)
    local max_filesize = 100 * 1024 -- 100 KB
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
    return ok and stats and stats.size > max_filesize
end

return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "typescript", "go" },
        sync_install = false,
        auto_install = true,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
            disable = disable_large_files,
        },
    },
}
