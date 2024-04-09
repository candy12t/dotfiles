local servers = {
  "gopls",
  "rust_analyzer",
  "lua_ls",
}

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "SmiteshP/nvim-navic",
      "hrsh7th/nvim-cmp",
      "williamboman/mason-lspconfig.nvim",
      "j-hui/fidget.nvim",
    },
    version = "v0.1.x",
    lazy = true,
    event = {
      "BufRead",
      "BufNewFile",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local enable_inlay_hint = true
      local on_attach = function(client, bufnr)
        if client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, bufnr)
        end
        if client.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint.enable(bufnr, enable_inlay_hint)
        end

        -- toggle inlay_hint
        vim.keymap.set("n", "<leader>lh", function()
          enable_inlay_hint = not enable_inlay_hint
          for buffer_id in pairs(vim.lsp.get_clients()[1].attached_buffers) do
            vim.lsp.inlay_hint.enable(buffer_id, enable_inlay_hint)
          end
        end)
      end

      lspconfig.gopls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          gopls = {
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          },
        },
      })

      lspconfig.rust_analyzer.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          ["rust-analyzer"] = {
            check = {
              command = "clippy",
            },
          },
        },
      })

      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            workspace = {
              library = {
                vim.fn.expand("$VIMRUNTIME/lua"),
              },
            },
            diagnostics = {
              globals = { "hs" },
            },
          },
        },
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    version = "v1.*",
    lazy = true,
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    version = "v1.*",
    dependencies = {
      "williamboman/mason.nvim",
    },
    lazy = true,
    opts = {
      ensure_installed = servers,
    },
  },
  {
    "j-hui/fidget.nvim",
    version = "v1.*",
    lazy = true,
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
}
