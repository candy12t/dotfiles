return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'SmiteshP/nvim-navic',
      'hrsh7th/cmp-nvim-lsp',
    },
    lazy = true,
    event = {
      'BufRead'
    },
    config = function()
      local on_attach = function(client, bufnr)
        if client.server_capabilities.documentSymbolProvider then
          require('nvim-navic').attach(client, bufnr)
        end
      end

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require('lspconfig')
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
          },
        },
        capabilities = capabilities,
      })
      lspconfig.gopls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end
  },
  {
    'williamboman/mason.nvim',
    dependencies = {
      'williamboman/mason-lspconfig.nvim'
    },
    lazy = true,
    event = {
      'BufRead',
      'CmdlineEnter'
    },
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = { 'gopls', 'lua_ls'}
      })
    end
  }
}
