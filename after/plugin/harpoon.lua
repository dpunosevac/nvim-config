local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-M-1>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-M-2>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-M-3>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-M-4>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-M-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-M-N>", function() harpoon:list():next() end)
