local opt = vim.opt

-- Disable netrw in favour of nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Disable unused providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs & indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Search
opt.hlsearch = false
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Appearance
opt.termguicolors = true
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.colorcolumn = "100"

-- Splits open below and to the right
opt.splitbelow = true
opt.splitright = true

-- Behaviour
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.breakindent = true
opt.completeopt = "menuone,noselect"

-- Files
opt.swapfile = false
opt.backup = false
opt.undodir = vim.fn.expand("~/.vim/undodir")
opt.undofile = true

-- Performance
opt.updatetime = 50
opt.timeoutlen = 300
