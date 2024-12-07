local api = vim.api
local fn = vim.fn
local bo = vim.bo

function Header()
    local filetype = bo.filetype
    local filename = fn.expand('%:t')
    local author = "Aurélien Aoustin (aurelien.aoustin@supinfo.com)"
    local created_date = os.date("%d/%m/%Y")
    local comType = {
        asm = {s = ';', c = '; ', e = ';'},
        c = {s = '/*', c = '** ', e = '*/'},
        cpp = {s = '/*', c = '** ', e = '*/'},
        css = {s = '/*', c = '** ', e = '*/'},
        go = {s = '/*', c = '** ', e = '*/'},
        typescript = {s = '/*', c = '** ', e = '*/'},
        typescriptreact = {s = '/*', c = '** ', e = '*/'},
        javascript = {s = '/*', c = '** ', e = '*/'},
        javascriptreact = {s = '/*', c = '** ', e = '*/'},
        pov = {s = '//', c = '// ', e = '//'},
        java = {s = '//', c = '// ', e = '//'},
        latex = {s = '%%', c = '%% ', e = '%%'},
        lisp = {s = ';;', c = ';; ', e = ';;'},
        xdefault = {s = '!!', c = '!! ', e = '!!'},
        pascal = {s = '{ ', c = '   ', e = '}'},
        make = {s = '##', c = '## ', e = '##'},
        text = {s = '##', c = '## ', e = '##'},
        lua = {s = '##', c = '## ', e = '##'},
        html = {s = '<!--', c = '  -- ', e = '-->'},
        haskell = {s = '{-', c = '-- ', e = '-}'},
        php = {s = '#!/usr/bin/env php\n/*', c = '** ', e = '*/\n<?php'},
        sh = {s = '#!/usr/bin/env bash', c = '## ', e = '##'},
        perl = {s = '#!/usr/bin/env perl', c = '## ', e = '##'},
        python = {s = '#!/usr/bin/env python3', c = '# ', e = '#'},
        ruby = {s = '#!/usr/bin/env ruby', c = '## ', e = '##'},
        node = {s = '#!/usr/bin/env node\n/*', c = '** ', e = '*/'},
    }
    local comment_style = comType[filetype]
    if comment_style then
        local header = {
            comment_style.s,
            comment_style.c..'File: '..filename,
            comment_style.c..'Author: '..author,
            comment_style.c..'Created: '..created_date,
            comment_style.c..'Description: This is a brief description of what this file is for and what',
            comment_style.c..'it does. For example, it could be a class definition, a set of functions,',
            comment_style.c..'etc. This should be a couple of sentences long at most.',
            comment_style.e
        }
        api.nvim_buf_set_lines(0, 0, 0, false, header)
    end
end
vim.cmd('nnoremap <F5> :lua Header()<CR>')
