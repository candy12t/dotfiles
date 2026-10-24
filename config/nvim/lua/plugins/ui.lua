return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      theme = "tokyonight",
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = {
          "lsp_status",
          "encoding",
          { "fileformat", icons_enabled = false },
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      extensions = { "fzf", "lazy", "mason", "neo-tree" },
    },
  },
  {
    "akinsho/bufferline.nvim",
    version = "v4.*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    version = "v3.*",
    main = "ibl",
    opts = {
      scope = {
        enabled = false,
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    version = "v2.*",
    opts = {
      numhl = true,
      current_line_blame = true,
    },
  },
  {
    "kevinhwang91/nvim-ufo",
    -- version = "v1.*",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    opts = {
      provider_selector = function(_, ft, _)
        local ftMap = {
          go = { "treesitter" },
        }
        return ftMap[ft] or ""
      end,
    },
  },
  -- { "sindrets/diffview.nvim" },
}
