local dap = require("dap")
local dapui = require("dapui")
local virtual_text = require("nvim-dap-virtual-text")

dapui.setup()

dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end

dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end

dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end

dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end

virtual_text.setup {
    display_callback = function(variable)
        if #variable.value > 15 then
            return " " .. string.sub(variable.value, 1, 15) .. "... "
        end

        return " " .. variable.value
    end,
}

-- Create highlight groups for DAP signs
vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#c23127', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'DapBreakpointCondition', { fg = '#ff8800', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'DapBreakpointRejected', { fg = '#888ca6', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'DapLogPoint', { fg = '#61afef', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'DapStopped', { fg = '#00ff00', bg = '#2e4d3d' })

-- Optional: highlight the whole line when stopped
vim.api.nvim_set_hl(0, 'DapStoppedLine', { bg = '#2e4d3d' })


vim.fn.sign_define('DapBreakpoint', {
    text = '●', texthl = 'DapBreakpoint', linehl = '', numhl = ''
})
vim.fn.sign_define('DapBreakpointCondition', {
    text = 'ﳁ', texthl = 'DapBreakpointCondition', linehl = '', numhl = ''
})
vim.fn.sign_define('DapBreakpointRejected', {
    text = '', texthl = 'DapBreakpointRejected', linehl = '', numhl = ''
})
vim.fn.sign_define('DapLogPoint', {
    text = '', texthl = 'DapLogPoint', linehl = '', numhl = ''
})
vim.fn.sign_define('DapStopped', {
    text = '', texthl = 'DapStopped', linehl = 'DapStoppedLine', numhl = ''
})


vim.api.nvim_create_augroup("dap_colors", {})
vim.api.nvim_create_autocmd("ColorScheme", {
    group = "dap_colors",
    pattern = "*",
    desc = "Set DAP marker colors and prevent color theme from resetting them",
    callback = function()
        vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#c23127', bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'DapBreakpointCondition', { fg = '#ff8800', bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'DapBreakpointRejected', { fg = '#888ca6', bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'DapLogPoint', { fg = '#61afef', bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'DapStopped', { fg = '#00ff00', bg = '#2e4d3d' })
        vim.api.nvim_set_hl(0, 'DapStoppedLine', { bg = '#2e4d3d' })
    end
})
-- Apply immediately
vim.api.nvim_exec_autocmds("ColorScheme", { group = "dap_colors" })
