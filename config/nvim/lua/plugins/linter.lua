return {
  "mfussenegger/nvim-lint",
  lazy = true,
  event = {
    "BufWritePre",
  },
  config = function()
    require("lint").linters_by_ft = {
      go = { "golangcilint" },
    }

    local augroup = vim.api.nvim_create_augroup
    local autocmd = vim.api.nvim_create_autocmd
    augroup("__linter__", { clear = true })
    autocmd("BufWritePost", {
      group = "__linter__",
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
