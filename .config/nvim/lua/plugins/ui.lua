return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme "catppuccin"
        end
    },
    {
        'echasnovski/mini.statusline',
        version = '*',
        config = function()
            local statusline = require('mini.statusline')
            statusline.setup({
                use_icons = false,
                content = {
                    active = function()
                        -- 1. Mode (Upper case: NORMAL)
                        local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })

                        -- 2. Git & Filename (master | init.lua)
                        local git = statusline.section_git({ trunc_width = 40 })
                        if git == "" and vim.fn.exists("*FugitiveHead") == 1 then
                            local branch = vim.fn.FugitiveHead()
                            if branch ~= "" then
                                git = " " .. branch --
                            end
                        end
                        local file = vim.fn.expand('%:t')
                        if vim.bo.modified then file = file .. '[+]' end
                        if vim.bo.readonly then file = file .. '[-]' end

                        -- Handle separator: only show '|' if git info exists
                        local git_file_group = {}
                        if git and #git > 0 then
                            table.insert(git_file_group, git)
                            table.insert(git_file_group, '|')
                        end
                        table.insert(git_file_group, file)

                        -- 3. File Info (unix | utf-8 | lua)
                        local file_encoding = vim.bo.fileencoding or vim.o.encoding
                        local file_format = vim.bo.fileformat
                        local file_type = vim.bo.filetype
                        local info_str = string.format('%s | %s | %s', file_format, file_encoding, file_type)

                        -- 4. Location (25% 1:1)
                        local line = vim.fn.line('.')
                        local col = vim.fn.col('.')
                        local total_lines = vim.fn.line('$')
                        local percent = math.floor((line / total_lines) * 100)
                        local loc_str = string.format('%d%%%%  %d:%d', percent, line, col)

                        return statusline.combine_groups({
                            { hl = mode_hl,                 strings = { mode:upper() } },
                            { hl = 'MiniStatuslineDevinfo', strings = git_file_group },

                            '%=', -- Spacer

                            { hl = 'MiniStatuslineFileinfo', strings = { info_str } },
                            { hl = mode_hl,                 strings = { loc_str } },
                        })
                    end
                }
            })
        end
    }
}
