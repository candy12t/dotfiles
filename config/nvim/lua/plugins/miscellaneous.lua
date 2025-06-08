return {
  {
    "smoka7/hop.nvim",
    version = "v2.*",
    lazy = true,
    event = {
      "BufRead",
      "BufNewFile",
    },
    config = function()
      require("hop").setup({})

      local hint_char1 = function(direction, current_line_only, hint_offset)
        local hop = require("hop")
        local directions = require("hop.hint").HintDirection

        return function()
          hop.hint_char1({
            direction = directions[direction],
            current_line_only = current_line_only,
            hint_offset = hint_offset,
          })
        end
      end
      local keymap_opt = { remap = true }

      vim.keymap.set("n", "f", hint_char1("AFTER_CURSOR", true, 0), keymap_opt)
      vim.keymap.set("n", "F", hint_char1("BEFORE_CURSOR", true, 0), keymap_opt)
      vim.keymap.set("n", "t", hint_char1("AFTER_CURSOR", true, -1), keymap_opt)
      vim.keymap.set("n", "T", hint_char1("BEFORE_CURSOR", true, -1), keymap_opt)
    end,
  },
  {
    "candy12t/github-link.nvim",
    lazy = true,
    event = {
      "BufRead",
    },
    config = true,
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    config = function()
      vim.o.foldcolumn = "1"
      vim.o.foldenable = true

      require("ufo").setup({
        provider_selector = function(_, ft, _)
          local ftMap = {
            go = { "treesitter" },
          }
          return ftMap[ft] or ""
        end,
      })
    end,
  },
}
