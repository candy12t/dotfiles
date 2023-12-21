return {
  "folke/tokyonight.nvim",
  version = "v2.*",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "moon",
    })
    vim.cmd([[colorscheme tokyonight]])
  end,
}
