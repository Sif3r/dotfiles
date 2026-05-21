vim.cmd.colorscheme('catppuccin')

local statusline = require('mini.statusline')
statusline.setup({
    use_icons = false,
    content = {
        active = function()
            local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })

            -- Git branch — read .git/HEAD directly so it works
            -- regardless of whether fugitive is lazy-loaded yet
            local git = ""
            local head = vim.fn.findfile('.git/HEAD', vim.fn.expand('%:p:h') .. ';') --[[@as string]]
            if head ~= '' then
                local f = io.open(head, 'r')
                if f then
                    local content = f:read('*l')
                    f:close()
                    -- normal branch  → "ref: refs/heads/main"
                    -- detached HEAD  → raw commit hash, show first 7 chars
                    git = content:match('^ref: refs/heads/(.+)$') or content:sub(1, 7)
                end
            end

            local file = vim.fn.expand('%:t')
            if vim.bo.modified then file = file .. '[+]' end
            if vim.bo.readonly then file = file .. '[-]' end

            local git_file_group = {}
            if git ~= '' then
                table.insert(git_file_group, git)
                table.insert(git_file_group, '|')
            end
            table.insert(git_file_group, file)

            local info_str = string.format(
                '%s | %s | %s',
                vim.bo.fileformat,
                vim.bo.fileencoding or vim.o.encoding,
                vim.bo.filetype
            )

            -- LSP progress / diagnostics (new in Nvim 0.12)
            local lsp_str  = vim.lsp.status()       or ""
            local diag_str = vim.diagnostic.status() or ""
            local right_str = lsp_str  ~= "" and lsp_str
            or diag_str ~= "" and diag_str
            or info_str

            local line  = vim.fn.line('.')
            local col   = vim.fn.col('.')
            local total = vim.fn.line('$')
            local loc_str = string.format('%d%%%%  %d:%d', math.floor(line / total * 100), line, col)

            return statusline.combine_groups({
                { hl = mode_hl,                  strings = { mode:upper() } },
                { hl = 'MiniStatuslineDevinfo',  strings = git_file_group },
                '%=',
                { hl = 'MiniStatuslineFileinfo', strings = { right_str } },
                { hl = mode_hl,                  strings = { loc_str } },
            })
        end
    }
})
