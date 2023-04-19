-- encoding
vim.opt.fencs = 'utf-8'
vim.opt.encoding = 'utf-8'

-- indent
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- visual
vim.opt.signcolumn = 'yes'
vim.opt.number = true
vim.opt.showmatch = true
vim.opt.cursorline = true
vim.opt.termguicolors = true

-- base
vim.opt.autoread = true
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.hidden = true

-- search
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.smartcase = true
vim.opt.wrapscan = true

-- misc
vim.opt.clipboard:append('unnamedplus')
