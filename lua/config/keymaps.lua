local map = vim.keymap.set

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })
map("n", "<C-w>v", "<C-w>v", { desc = "Vertical split" })
map("n", "<C-w>s", "<C-w>s", { desc = "Horizontal split" })
map("n", "<C-w>=", "<C-w>=", { desc = "Equalize windows" })

-- Scrolling with cursor recentered
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })

-- Search with cursor recentered
map("n", "n", "nzzzv", { desc = "Next match (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev match (centered)" })

-- Join line without moving cursor
map("n", "J", "mzJ`z", { desc = "Join line" })

-- Delete without yanking
map("n", "<leader>d", '"_d', { desc = "Delete without yanking" })
map("v", "<leader>d", '"_d', { desc = "Delete without yanking" })

-- Move selected lines up/down
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Paste without overwriting register
map("x", "<leader>p", '"_dP', { desc = "Paste without overwriting register" })

-- Copy absolute file path to system clipboard
map("n", "<leader>fc", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path)
end, { desc = "Copy file path" })
