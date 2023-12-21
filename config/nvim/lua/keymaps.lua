vim.g.mapleader = " "

local keymap_opts = { noremap = true, silent = true }
vim.keymap.set("n", "<ESC><ESC>", ":<C-u>set nohlsearch!<CR>", keymap_opts)

vim.keymap.set("n", "ss", ":split<CR><C-w>w", keymap_opts)
vim.keymap.set("n", "sv", ":vsplit<CR><C-w>w", keymap_opts)
vim.keymap.set("n", "sj", "<C-w>j", keymap_opts)
vim.keymap.set("n", "sk", "<C-w>k", keymap_opts)
vim.keymap.set("n", "sl", "<C-w>l", keymap_opts)
vim.keymap.set("n", "sh", "<C-w>h", keymap_opts)
vim.keymap.set("n", "sc", "<C-w>c", keymap_opts)

vim.keymap.set("n", "<Tab>", ":bnext<CR>", keymap_opts)
vim.keymap.set("n", "<S-Tab>", ":bprev<CR>", keymap_opts)
vim.keymap.set("n", "<leader>bd", ":bd<CR>", keymap_opts)

vim.keymap.set("n", "j", "gj", keymap_opts)
vim.keymap.set("n", "gj", "j", keymap_opts)
vim.keymap.set("n", "k", "gk", keymap_opts)
vim.keymap.set("n", "gk", "k", keymap_opts)

vim.keymap.set("", "x", '"_x', keymap_opts)

vim.keymap.set("i", "<C-f>", "<Right>", keymap_opts)
vim.keymap.set("i", "<C-b>", "<Left>", keymap_opts)
vim.keymap.set("i", "<C-a>", "<Home>", keymap_opts)
vim.keymap.set("i", "<C-e>", "<End>", keymap_opts)
vim.keymap.set("i", "<C-d>", "<Del>", keymap_opts)

vim.keymap.set("c", "<C-f>", "<Right>", { noremap = true })
vim.keymap.set("c", "<C-b>", "<Left>", { noremap = true })
vim.keymap.set("c", "<C-a>", "<Home>", { noremap = true })
vim.keymap.set("c", "<C-e>", "<End>", { noremap = true })
vim.keymap.set("c", "<C-d>", "<Del>", { noremap = true })

vim.keymap.set("v", ">", ">gv", keymap_opts)
vim.keymap.set("v", "<", "<gv", keymap_opts)
