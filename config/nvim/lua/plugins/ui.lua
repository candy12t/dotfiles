return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "AndreM222/copilot-lualine",
    },
    opts = {
      theme = "tokyonight",
      options = {
        disabled_filetypes = {
          statusline = { "no-neck-pain" },
          winbar = { "no-neck-pain" },
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = {
          {
            "copilot",
            symbols = {
              status = {
                icons = {
                  enabled = require("icons").Copilot .. " ",
                  sleep = require("icons").Copilot .. " ",
                  disabled = require("icons").CopilotError .. " ",
                  warning = require("icons").CopilotWarning .. " ",
                  unknown = require("icons").Ban .. " ",
                },
              },
            },
            show_colors = true,
          },
          { "lsp_status", ignore_lsp = { "copilot" } },
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
    opts = {
      options = {
        highlights = "tokyonight",
      },
    },
  },
  {
    "utilyre/barbecue.nvim",
    version = "v1.*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      theme = "tokyonight",
    },
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
    vesion = "v1.*",
    opts = {
      numhl = true,
      current_line_blame = true,
    },
  },
  { "shortcuts/no-neck-pain.nvim", version = "v2.*", config = true },
  {
    "kevinhwang91/nvim-ufo",
    version = "v1.*",
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
