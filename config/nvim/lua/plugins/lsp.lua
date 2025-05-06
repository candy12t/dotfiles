return {
  {
    "williamboman/mason.nvim",
    version = "v1.*",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    version = "v1.*",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      automatic_installation = true,
      ensure_installed = {
        "efm",
        "gopls",
        "lua_ls",
        "rust_analyzer",
        "tsp_server",
      },
    },
    init = function()
      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        on_attach = function(client, bufnr)
          require("lsp-format").on_attach(client, bufnr)

          if client.server_capabilities.documentSymbolProvider then
            require("nvim-navic").attach(client, bufnr)
          end

          if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(vim.lsp.inlay_hint.is_enabled({}), { bufnr = bufnr })
            -- toggle inlay_hint keymap
            vim.keymap.set("n", "<leader>lh", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
            end)
          end
        end,
      })
      vim.lsp.enable(require("mason-lspconfig").get_installed_servers())
    end,
  },
  {
    "j-hui/fidget.nvim",
    version = "v1.*",
    config = true,
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
    config = function()
      require("lspsaga").setup({})

      local keymap_opts = { noremap = true, silent = true }
      vim.keymap.set("n", "<leader>lf", ":Lspsaga finder<CR>", keymap_opts)
      vim.keymap.set("n", "<leader>lr", ":Lspsaga rename<CR>", keymap_opts)
      vim.keymap.set("n", "<leader>ld", ":Lspsaga goto_definition<CR>", keymap_opts)
      vim.keymap.set("n", "<leader>lt", ":Lspsaga goto_type_definition<CR>", keymap_opts)
      vim.keymap.set("n", "<leader>lh", ":Lspsaga hover_doc<CR>", keymap_opts)
      vim.keymap.set("n", "<leader>lo", ":Lspsaga outline<CR>", keymap_opts)
      vim.keymap.set("n", "<leader><S-t>", ":Lspsaga term_toggle<CR>", keymap_opts)
    end,
  },
  {
    "lukas-reineke/lsp-format.nvim",
    config = true,
  },
}
