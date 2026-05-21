local dap   = require('dap')
local dapui = require('dapui')

require('mason-nvim-dap').setup({
    automatic_installation = true,
    handlers = {},
    ensure_installed = {
        'delve',    -- Go
        'codelldb', -- C/C++
    },
})

dapui.setup({
    icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
    controls = {
        enabled = true,
        element = 'repl',
        icons = {
            pause      = '⏸',
            play       = '▶',
            step_into  = '⏎',
            step_over  = '⏭',
            step_out   = '⏮',
            step_back  = 'b',
            run_last   = '▶▶',
            terminate  = '⏹',
            disconnect = '⏏',
        },
    },
})
dap.listeners.after.event_initialized['dapui_config']  = dapui.open
dap.listeners.before.event_terminated['dapui_config']  = dapui.close
dap.listeners.before.event_exited['dapui_config']      = dapui.close

require('dap-go').setup({
    delve = { detached = vim.fn.has('win32') == 0 },
})

local set = vim.keymap.set
set('n', '<F5>',      function() dap.continue() end,                                             { desc = 'Debug: Start/Continue' })
set('n', '<F1>',      function() dap.step_into() end,                                            { desc = 'Debug: Step Into' })
set('n', '<F2>',      function() dap.step_over() end,                                            { desc = 'Debug: Step Over' })
set('n', '<F3>',      function() dap.step_out() end,                                             { desc = 'Debug: Step Out' })
set('n', '<leader>b', function() dap.toggle_breakpoint() end,                                    { desc = 'Debug: Toggle Breakpoint' })
set('n', '<leader>B', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = 'Debug: Set Breakpoint' })
set('n', '<F7>',      function() dapui.toggle() end,                                             { desc = 'Debug: Toggle UI' })
