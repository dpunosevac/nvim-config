local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Flash yanked region
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group = "YankHighlight",
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Quickfix buffers don't belong in the buffer list
augroup("QuickfixHide", { clear = true })
autocmd("FileType", {
  group = "QuickfixHide",
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

-- LSP keymaps (defined here to avoid being overridden by built-in server on_attach)
autocmd("LspAttach", {
  callback = function(event)
    local map = function(keys, fn, desc)
      vim.keymap.set("n", keys, fn, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    map("gd", vim.lsp.buf.definition, "Go to definition")
    map("gD", vim.lsp.buf.declaration, "Go to declaration")
    map("K", vim.lsp.buf.hover, "Hover docs")
    map("gi", vim.lsp.buf.implementation, "Go to implementation")
    map("gr", function() require("telescope.builtin").lsp_references() end, "References")
    map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
    map("<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("<leader>ls", function() require("telescope.builtin").lsp_document_symbols() end, "Document symbols")
    map("<leader>lS", function() require("telescope.builtin").lsp_workspace_symbols() end, "Workspace symbols")
    map("]d", vim.diagnostic.goto_next, "Next diagnostic")
    map("[d", vim.diagnostic.goto_prev, "Prev diagnostic")
    map("<leader>cd", vim.diagnostic.open_float, "Show diagnostic")
  end,
})

-- Restore cursor to last known position when reopening a file
augroup("RestoreCursor", { clear = true })
autocmd("BufReadPost", {
  group = "RestoreCursor",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
