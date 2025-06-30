return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-path",
      { "zbirenbaum/copilot-cmp", opts = {} },
      "onsails/lspkind.nvim",
      "saadparwaiz1/cmp_luasnip",
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
    },
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
      local cmp = require("cmp")
      local icons = require("icons")

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        formatting = {
          format = require("lspkind").cmp_format({
            mode = "symbol_text",
            max_width = 50,
            symbol_map = { Copilot = icons.Copilot },
          }),
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          { name = "copilot" },
          { name = "luasnip" },
          { name = "buffer" },
        }, {
          { name = "path", trailing_slash = true },
        }),
      })

      cmp.setup.cmdline({ "/" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "buffer" },
        }),
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path", trailing_slash = true },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },
  { "windwp/nvim-autopairs", opts = {} },
}
