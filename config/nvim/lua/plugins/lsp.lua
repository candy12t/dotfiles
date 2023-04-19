return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'SmiteshP/nvim-navic'
    },
    lazy = true,
    event = {
      'BufRead'
    },
    config = function()
      local on_attach = function(client, bufnr)
        if client.server_capabilities.documentSymbolProvider then
          require('navic').attach(client, bufnr)
        end
      end

      require('lspconfig')['lua_ls'].setup({
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
          },
        },
      })
      require('lspconfig')['gopls'].setup({
        on_attach = on_attach
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
        ensure_installed = { 'gopls', 'solargraph', 'lua_ls'}
      })
    end
  }
}
