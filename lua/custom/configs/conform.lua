local conform = require("conform")

conform.setup({
    formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        svelte = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        lua = { "stylua" },
        python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
        go = { "gofumpt", "goimports-reviser", "golines" }
    },
    formatters = {
        -- ["goimports-reviser"] = { prepend_args = { "-rm-unused" } }, Once removed import by it cannot be imported back
        golines = { prepend_args = { "--max-len=100" } },
    },
    format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
    },
})
