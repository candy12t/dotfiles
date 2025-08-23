return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken",
    opts = function()
      local in_japanese = " In Japanese please."
      local default_prompts = require("CopilotChat.config.prompts")

      return {
        model = "claude-3.5-sonnet",
        -- model = "claude-sonnet-4",
        window = {
          layout = "vertical",
          width = 0.4,
        },
        mappings = {
          show_diff = {
            full_diff = true,
          },
        },
        prompts = {
          Explain = { prompt = default_prompts.Explain.prompt .. in_japanese },
          Review = { prompt = default_prompts.Review.prompt .. in_japanese },
          Fix = { prompt = default_prompts.Fix.prompt .. in_japanese },
          Optimize = { prompt = default_prompts.Optimize.prompt .. in_japanese },
        },
      }
    end,
  },
  {
    "greggh/claude-code.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      window = {
        split_ratio = 0.4,
        position = "rightbelow vsplit",
      },
      keymaps = {
        window_navigation = false,
      },
    },
  },
  -- {"coder/claudecode.nvim"}
  -- {"yetone/avante.nvim"},
  -- {"ravitemer/mcphub.nvim"},
  -- {"olimorris/codecompanion.nvim"},
}
