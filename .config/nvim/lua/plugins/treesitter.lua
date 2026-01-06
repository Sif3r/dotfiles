return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local ts = require("nvim-treesitter")

        ts.install({
            -- Core & Vim
            "lua", "vim", "vimdoc", "query", "regex", "luadoc",

            -- Web (Frontend)
            "html", "css", "javascript", "typescript", "tsx", "json", "vue",

            -- Backend & Systems
            "c", "cpp", "go", "python", "rust", "php", "sql",

            -- Config, Ops & Tools
            "bash", "dockerfile", "yaml", "toml", "make", "git_config", "gitcommit",

            -- Markup
            "markdown", "markdown_inline",
        })
    end,
}
