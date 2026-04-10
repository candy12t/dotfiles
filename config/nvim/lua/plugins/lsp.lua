return {
  {
    "mason-org/mason-lspconfig.nvim",
    version = "2.*",
    dependencies = {
      { "mason-org/mason.nvim", version = "2.*", opts = {} },
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
    },
    init = function()
      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
        on_attach = function(client, bufnr)
          local format_group = vim.api.nvim_create_augroup("LspFormat", { clear = false })
          vim.api.nvim_clear_autocmds({
            buffer = bufnr,
            group = format_group,
          })
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            group = format_group,
            callback = function()
              vim.lsp.buf.format({ async = false, timeout_ms = 1000 })
            end,
          })

          if client:supports_method("textDocument/codeLens") then
            vim.lsp.codelens.enable(not vim.lsp.codelens.is_enabled())
          end

          if client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end
        end,
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
