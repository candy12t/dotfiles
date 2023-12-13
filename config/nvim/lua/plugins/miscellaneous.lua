return {
  {
    'phaazon/hop.nvim',
    version = 'v2.*',
    lazy = true,
    event = {
      'BufRead'
    },
    config = function()
      require('hop').setup({
      })

      local hint_char1 = function(direction, current_line_only, hint_offset)
        local hop = require('hop')
        local directions = require('hop.hint').HintDirection

        return function()
          hop.hint_char1({ direction = directions[direction], current_line_only = current_line_only, hint_offset = hint_offset })
        end
      end
      local keymap_opt = { remap = true }

      vim.keymap.set('n', 'f', hint_char1('AFTER_CURSOR', true, 0), keymap_opt)
      vim.keymap.set('n', 'F', hint_char1('BEFORE_CURSOR', true, 0), keymap_opt)
      vim.keymap.set('n', 't', hint_char1('AFTER_CURSOR', true, -1), keymap_opt)
      vim.keymap.set('n', 'T', hint_char1('BEFORE_CURSOR', true, -1), keymap_opt)
    end
  },
  {
    'numToStr/Comment.nvim',
    lazy = true,
    event = {
      'BufRead'
    },
    config = true
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function ()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      })
    end
  }
}
