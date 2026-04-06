return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "lukas-reineke/lsp-format.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local servers = { "efm", "gopls", "lua_ls", "nil_ls", "rust-analyzer" }

      local opt = {
        capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
        on_attach = function(client, bufnr)
          require("lsp-format").on_attach(client, bufnr)

          if client:supports_method("textDocument/codeLens") then
            vim.lsp.codelens.enable(not vim.lsp.codelens.is_enabled())
          end

          if client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end
        end,
      }

      vim.diagnostic.config({
        virtual_text = true,
      })

      for _, server in ipairs(servers) do
        vim.lsp.config(server, opt)
        vim.lsp.enable(server)
      end
    end,
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
