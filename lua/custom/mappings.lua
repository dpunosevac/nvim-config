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

M.telescope = {
    plugin = true,

    n = {
        ["<leader>sf"] = { "<cmd> Telescope find_files <CR>", "Search Files" },
        ["<leader>sw"] = { "<cmd> Telescope grep_string <CR>", "Search current Word" },
        ["<leader>so"] = {
            function()
                require("custom.configs.telescope").live_grep_open_files()
            end,
            "Search in Open files"
        },
        ["<leader>sh"] = {
            function()
                require("custom.configs.telescope").live_grep_hidden()
            end,
            "Search files (including Hidden)"
        }
        -- ["<leader>sh"] = { "<cmd> ", "Search Hidden files"}
    }
}

M.dap = {
    plugin = true,
    n = {
        ["<F1>"] = {
            function()
                require("dap").continue()
            end,
            "Debug continue"
        },
        ["<F2>"] = {
            function()
                require("dap").step_into()
            end,
            "Debug Step Into"
        },
        ["<F3>"] = {
            function()
                require("dap").step_over()
            end,
            "Debug Step Over"
        },
        ["<F4>"] = {
            function()
                require("dap").step_out()
            end,
            "Step Out",
        },
        ["<F5>"] = {
            function()
                require("dap").step_back()
            end,
            "Debug Step Back",
        },
        ["<F6>"] = {
            function()
                require("dap").run_to_cursor()
            end
        },
        ["<F7>"] = {
            function()
                require("dap").restart()
            end,
            "Debug Restart"
        },
        ["<leader>db"] = {
            function()
                require("dap").toggle_breakpoint()
            end,
            "Debug Add Breakpoint at line"
        },
        ["<leader>de"] = {
            function()
                require("dapui").eval(nil, { enter = true })
            end,
            "Debug Evaluate current line"
        },
    }
}

M.dap_python = {
    plugin = true,
    n = {
        ["<leader>dt"] = {
            function()
                require("dap-python").test_method()
            end,
            "Debug python test"
        },
    }
}

M.dap_go = {
    plugin = true,
    n = {
        ["<leader>dt"] = {
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
