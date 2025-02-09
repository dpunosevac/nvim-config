local M = {}

M.lspconfig = {
    n = {
        ["<leader>rn"] = {
            function()
                require("nvchad.renamer").open()
            end,
            "LSP rename",
        },
    }
}

M.dap = {
    plugin = true,
    n = {
        ["<leader>dc"] = {
            function()
                require("dap").continue()
            end,
            "Debug continue"
        },
        ["<leader>dt"] = {
            function()
                require("dap").terminate()
            end,
            "Debug Terminate session"
        },
        ["<leader>db"] = {
            function()
                require("dap").toggle_breakpoint()
            end,
            "Debug Add Breakpoint at line"
        },
        ["<leader>dB"] = {
            function()
                require("dap").clear_breakpoints()
            end,
            "Debug clear all Breakpoints"
        },
        ["<leader>dso"] = {
            function()
                require("dap").step_over()
            end,
            "Debug Step Over"
        },
        ["<leader>dsi"] = {
            function()
                require("dap").step_into()
            end,
            "Debug Step Into"
        },
        ["<leader>de"] = {
            function()
                require("dapui").eval(nil, { enter = true })
            end,
            "Debug Evaluate current line"
        }
    }
}

M.dap_go = {
    plugin = true,
    n = {
        ["<leader>dgt"] = {
            function()
                require("dap-go").debug_test()
            end,
            "Debug go test"
        },
    }
}

M.gopher = {
    plugin = true,
    n = {
        ["<leader>gsj"] = {
            "<cmd> GoTagAdd json <CR>",
            "Add json struct tags"
        },
        ["<leader>gsy"] = {
            "<cmd> GoTagAdd yaml <CR>",
            "Add yaml struct tags"
        }
    }
}

M.undotree = {
    plugin = true,
    n = {
        ["<leader>u"] = {
            "<cmd> UndotreeToggle <CR>",
            "Toggle Undotree"
        }
    }
}

M.fugitive = {
    plugin = true,
    n = {
        ["<leader>gs"] = {
            "<cmd> Git <CR>",
            "Git Status "
        },
        ["<leader>gb"] = {
            "<cmd> Git blame <CR>",
            "Git Blame"
        },
        ["<leader>dv"] = {
            "<cmd> Gvdiff <CR>",
            "Git Diff"
        }
    }
}

return M
