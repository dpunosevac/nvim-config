local plugins = {
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "gopls",
                "pyright",
                "ruff",
                "eslint-lsp",
                "prettier",
                "typescript-language-server"
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
            require "custom.configs.debug"
        end
    },
    {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        dependencies = "mfussenegger/nvim-dap",
        config = function()
            require('dap-python').test_runner = 'pytest'
            require("dap-python").setup("python")
            require("core.utils").load_mappings("dap_python")
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
        "nvim-telescope/telescope-dap.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
            require('telescope').load_extension('dap')
        end,
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
        cmd = "UndotreeToggle",
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
    {
        "github/copilot.vim",
    },
    {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        opts = {},
    },
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        ft = { "markdown" },
        config = function()
            vim.g.mkdp_auto_start = 0
        end,
    }
}
return plugins
