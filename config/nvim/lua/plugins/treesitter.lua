return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  dependencies = {
    "RRethy/nvim-treesitter-endwise",
  },
  config = function()
    require("nvim-treesitter").setup({})
    require("nvim-treesitter").install({
      "bash",
      "c",
      "comment",
      "css",
      "diff",
      "dockerfile",
      "git_config",
      "gitcommit",
      "gitignore",
      "go",
      "gomod",
      "gosum",
      "html",
      "java",
      "javascript",
      "json",
      "lua",
      "make",
      "markdown",
      "markdown_inline",
      "proto",
      "python",
      "ruby",
      "rust",
      "sql",
      "toml",
      "tsx",
      "typescript",
      "typespec",
      "vim",
      "yaml",
    })
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}
