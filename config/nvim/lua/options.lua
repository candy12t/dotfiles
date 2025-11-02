-- encoding
vim.opt.fencs = "utf-8"
vim.opt.encoding = "utf-8"

-- indent
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.fixendofline = true

local function set_indent(ft, expandtab, size)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = ft,
    callback = function()
      vim.opt.expandtab = expandtab
      vim.opt.tabstop = size
      vim.opt.shiftwidth = size
    end,
  })
end

set_indent("go,make", false, 4)
set_indent("rust,python", true, 4)
set_indent("typescript,javascript,ruby,sh,yaml,json,lua,markdown,typespec", true, 2)
set_indent("gitconfig", false, 8)

local function trim_trailing_whitespace()
  local save = vim.fn.winsaveview()
  vim.cmd([[keeppatterns %s/\s\+$//e]])
  vim.fn.winrestview(save)
end

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    if vim.o.filetype ~= "markdown" then
      trim_trailing_whitespace()
    end
  end,
})

-- visual
vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.showmatch = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.laststatus = 3

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

-- fold
vim.opt.foldcolumn = "1"
vim.opt.foldenable = true

-- split
vim.opt.splitright = true
vim.opt.splitbelow = true

-- misc
vim.opt.clipboard:append("unnamedplus")
