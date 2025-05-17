return {
  "folke/tokyonight.nvim",
  version = "v4.*",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "moon",
      on_highlights = function(hl, _)
        hl.CmpItemKindVariable = "@constructor"
        hl.CmpItemKindFile = "Directory"
      end,
    })
    vim.cmd([[colorscheme tokyonight]])
  end,
}
