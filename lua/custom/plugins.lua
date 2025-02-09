local plugins = {
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "gopls",
                "pyright",
                "ruff",
            },
        },
    },
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text"
        },
        init = function()
            require("core.utils").load_mappings("dap")
        end,
        config = function()
            require "custom.configs.debbug"
        end
    },
    {
        "leoluz/nvim-dap-go",
        ft = "go",
        dependencies = "mfussenegger/nvim-dap",
        config = function(_, opts)
            require("dap-go").setup(opts)
            require("core.utils").load_mappings("dap_go")
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "plugins.configs.lspconfig"
            require "custom.configs.lspconfig"
        end,
    },
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        config = function()
            require "custom.configs.conform"
        end,
    },
    {
        "olexsmir/gopher.nvim",
        ft = "go",
        config = function(_, opts)
            require("gopher").setup(opts)
            require("core.utils").load_mappings("gopher")
        end,
        build = function()
            vim.cmd [[silent! GoInstallDeps]]
        end,
    },
    {
        "tpope/vim-fugitive",
        event = "VeryLazy",
        dependencies = {
            "tpope/vim-rhubarb",
            "tpope/vim-obsession",
            "tpope/vim-unimpaired",
        },
        config = function()
            require("core.utils").load_mappings("fugitive")
        end
        -- init = function()
        --     require("core.utils").load_mappings("fugitive")
        -- end
    },
    {
        -- Detect tabstop and shiftwidth automatically
        'tpope/vim-sleuth',
    },
    {
        "mbbill/undotree",
        cmd = "UndoTreeToggle",
        init = function()
            require("core.utils").load_mappings("undotree")
        end
    },
    {
        -- Add indentation guides even on blank lines
        'lukas-reineke/indent-blankline.nvim',
        -- Enable `lukas-reineke/indent-blankline.nvim`
        -- See `:help ibl`
        main = 'ibl',
        commit = "29be0919b91fb59eca9e90690d76014233392bef",
        opts = {},
        config = function()
            require "custom.configs.blanklines"
        end
    },
    -- {
    --     "github/copilot.vim",
    -- }
}
return plugins
