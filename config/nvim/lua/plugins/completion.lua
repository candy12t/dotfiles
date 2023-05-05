return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-document-symbol',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-cmdline',
      'onsails/lspkind.nvim',
      {
        'hrsh7th/cmp-copilot',
        dependencies = {
          'github/copilot.vim'
        }
      },
      {
        'saadparwaiz1/cmp_luasnip',
        dependencies = {
          'L3MON4D3/LuaSnip',
          version = '1.*'
        }
      }
    },
    lazy = true,
    event = {
      'InsertEnter',
      'CmdlineEnter'
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-l>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<C-y>'] = cmp.mapping.confirm({ select = true })
        }),
        formatting = {
          format = require('lspkind').cmp_format()
        },
        sources = cmp.config.sources({
          { name = 'buffer' },
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'path' },
          { name = 'nvim_lua' },
          { name = 'copilot' },
          { name = 'luasnip' }
        })
      })
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'nvim_lsp_document_symbol' },
          { name = 'buffer' }
        })
      })
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
          {
            name = 'cmdline',
            option = {
              ignore_cmds = { 'Man', '!' }
            }
          }
        })
      })
    end
  },
  {
    'windwp/nvim-autopairs',
    lazy = true,
    event = {
      'InsertEnter'
    },
    config = function()
      require('nvim-autopairs').setup()
    end
  },
  {
    'kylechui/nvim-surround',
    version = '2.*',
    lazy = true,
    event = { 'BufRead' },
    config = function()
      require('nvim-surround').setup()
    end
  }
}
