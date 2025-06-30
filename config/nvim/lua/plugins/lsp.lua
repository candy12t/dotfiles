return {
  {
    "mason-org/mason-lspconfig.nvim",
    version = "2.*",
    dependencies = {
      { "mason-org/mason.nvim", version = "2.*", opts = {} },
      "neovim/nvim-lspconfig",
      "lukas-reineke/lsp-format.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    init = function()
      vim.lsp.config("*", {
        on_attach = require("lsp-format").on_attach,
        capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
      })
      vim.diagnostic.config({
        virtual_text = true,
      })
    end,
    opts = {
      ensure_installed = {
        "efm",
        "gopls",
        "lua_ls",
        "rust_analyzer",
        "terraformls",
        "tsp_server",
        "yamlls",
      },
      automatic_enable = true,
    },
  },
  {
    "glepnir/lspsaga.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = true,
    event = {
      "LspAttach",
    },
    opts = {},
    init = function()
      local keymap_opts = { noremap = true, silent = true }
      vim.keymap.set("n", "gd", ":Lspsaga goto_definition<CR>", keymap_opts)
      vim.keymap.set("n", "grn", ":Lspsaga rename<CR>", keymap_opts)
      vim.keymap.set("n", "gra", ":Lspsaga code_action<CR>", keymap_opts)
      vim.keymap.set("n", "grr", ":Lspsaga finder<CR>", keymap_opts)
      vim.keymap.set("n", "grt", ":Lspsaga goto_type_definition<CR>", keymap_opts)
      vim.keymap.set("n", "gO", ":Lspsaga outline<CR>", keymap_opts)
      vim.keymap.set("n", "K", ":Lspsaga hover_doc<CR>", keymap_opts)
    end,
  },
}
