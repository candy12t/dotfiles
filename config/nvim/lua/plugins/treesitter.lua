return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = "v0.*",
    dependencies = {
      "RRethy/nvim-treesitter-endwise",
    },
    lazy = true,
    event = {
      "BufRead",
      "BufNewFile",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
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
        },
        highlight = {
          enable = true,
        },
        endwise = {
          enable = true,
        },
      })
    end,
  },
  {
    "RRethy/nvim-treesitter-endwise",
    lazy = true,
  },
}
