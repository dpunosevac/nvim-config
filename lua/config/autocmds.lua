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
