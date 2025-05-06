return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    lazy = true,
    event = {
      "BufEnter",
    },
    opts = {
      options = {
        theme = "tokyonight",
      },
    },
    config = function()
      local skkmode = function()
        if vim.call("eskk#is_enabled") == 1 then
          return vim.g["eskk#statusline_mode_strings"][vim.call("eskk#get_mode")]
        else
          return ""
        end
      end

      vim.api.nvim_create_autocmd("user", {
        pattern = "eskk-initialize-post",
        callback = function()
          require("lualine").setup({
            sections = {
              lualine_c = { "filename", skkmode },
            },
          })
        end,
      })

      require("lualine").setup()
    end,
  },
  {
    "akinsho/bufferline.nvim",
    version = "v4.*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    lazy = true,
    event = {
      "BufEnter",
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
    lazy = true,
    event = {
      "BufRead",
      "BufNewFile",
    },
    opts = {
      theme = "tokyonight",
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    version = "v3.*",
    main = "ibl",
    lazy = true,
    event = {
      "BufRead",
      "BufNewFile",
    },
    opts = {
      scope = {
        enabled = false,
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    vesion = "v1.*",
    lazy = true,
    event = {
      "BufRead",
      "BufNewFile",
    },
    opts = {
      numhl = true,
      current_line_blame = true,
    },
  },
  {
    "shortcuts/no-neck-pain.nvim",
    version = "v2.*",
    enabled = false,
    config = true,
  },
  {
    "MeanderingProgrammer/markdown.nvim",
    version = "v8.*",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    enabled = false,
    config = true,
  },
}
