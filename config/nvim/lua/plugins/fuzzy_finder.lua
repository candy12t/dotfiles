return {
  {
    "ibhagwan/fzf-lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>ff", ":FzfLua files<CR>", mode = "n", noremap = true, silent = true },
      { "<leader>fr", ":FzfLua grep_project<CR>", mode = "n", noremap = true, silent = true },
    },
    init = function()
      require("fzf-lua").register_ui_select()
    end,
    opts = {
      { "telescope", "fzf-native" },
      grep = {
        rg_opts = [[--sort-files --hidden --column --line-number --no-heading --color=always --smart-case -g "!.git"]],
      },
    },
  },
}
