return {
  {
    "ibhagwan/fzf-lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    lazy = true,
    keys = {
      { "<leader>ff" },
      { "<leader>fr" },
    },
    config = function()
      require("fzf-lua").setup({ "telescope" })

      local keymap_opts = { noremap = true, silent = true }
      vim.keymap.set("n", "<leader>ff", ":FzfLua files<CR>", keymap_opts)
      vim.keymap.set("n", "<leader>fr", ":FzfLua grep_project<CR>", keymap_opts)
    end,
  },
}
