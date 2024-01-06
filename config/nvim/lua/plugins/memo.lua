return {
  "glidenote/memolist.vim",
  dependencies = {
    "ibhagwan/fzf-lua",
  },
  lazy = true,
  keys = {
    { "<leader>mg" },
    { "<leader>mn" },
  },
  build = "go install github.com/mattn/memo@latest",
  init = function()
    vim.g.memolist_path = "$HOME/.config/memo/notes/memo"
    vim.g.memolist_memo_suffix = "md"
    vim.g.memolist_memo_date = "%Y-%m-%d"
    vim.g.memolist_template_dir_path = "$HOME/.config/memo/templates"

    local augroup = vim.api.nvim_create_augroup
    local autocmd = vim.api.nvim_create_autocmd
    augroup("MemoAutoCommit", { clear = true })
    autocmd("BufWritePost", {
      group = "MemoAutoCommit",
      pattern = string.format("%s/*.md", vim.fn.expand(vim.g.memolist_path)),
      command = ":!memo commit",
    })
  end,
  config = function()
    local keymap_opts = { noremap = true, silent = true }
    vim.keymap.set("n", "<leader>mg", string.format(":FzfLua files cwd=%s<CR>", vim.g.memolist_path), keymap_opts)
    vim.keymap.set("n", "<leader>mn", ":MemoNew<CR>", keymap_opts)
  end,
}
