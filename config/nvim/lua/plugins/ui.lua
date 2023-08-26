return {
  {
    'nvim-lualine/lualine.nvim',
    lazy = true,
    event = {
      'BufEnter'
    },
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    opts = {
      options = {
        theme = 'tokyonight'
      }
    }
  },
  {
    'akinsho/bufferline.nvim',
    lazy = true,
    event = {
      'BufEnter'
    },
    version = '4.*',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    opts = {
      options = {
        highlights = 'tokyonight'
      }
    }
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    lazy = true,
    event = {
      'BufRead'
    },
    config = true
  },
  {
    'utilyre/barbecue.nvim',
    lazy = true,
    event = {
      'BufRead'
    },
    name = 'barbecue',
    version = '*',
    dependencies = {
      'SmiteshP/nvim-navic',
      'nvim-tree/nvim-web-devicons'
    },
    opts = {
      theme = 'tokyonight'
    }
  },
  {
    'lewis6991/gitsigns.nvim',
    lazy = true,
    event = {
      'BufRead'
    },
    config = function()
      require('gitsigns').setup({
        numhl = true
      })

      local gitsigns = require('gitsigns')
      local keymap_opts = { noremap = true, silent = true }
      vim.keymap.set('n', '<leader>gb', gitsigns.toggle_current_line_blame, keymap_opts)
      vim.keymap.set('n', '<leader>gd', gitsigns.toggle_deleted, keymap_opts)
    end
  },
  {
    'norcalli/nvim-colorizer.lua',
    lazy = true,
    event = {
      'BufRead'
    },
    config = true,
  },
  {
    'j-hui/fidget.nvim',
    tag = 'legacy',
    lazy = true,
    event = {
      'BufRead'
    },
    config = true,
  },
  {
    'glepnir/lspsaga.nvim',
    event = {
      'LspAttach'
    },
    config = function()
      require('lspsaga').setup()

      local keymap_opts = { noremap = true, silent = true }
      vim.keymap.set('n', '<leader>lf', ':Lspsaga lsp_finder<CR>', keymap_opts)
      vim.keymap.set('n', '<leader>lr', ':Lspsaga rename<CR>', keymap_opts)
      vim.keymap.set('n', '<leader>ld', ':Lspsaga goto_definition<CR>', keymap_opts)
      vim.keymap.set('n', '<leader>lt', ':Lspsaga goto_type_definition<CR>', keymap_opts)
      vim.keymap.set('n', '<leader>lh', ':Lspsaga hover_doc<CR>', keymap_opts)
      vim.keymap.set('n', '<leader>lo', ':Lspsaga outline<CR>', keymap_opts)
      vim.keymap.set('n', '<leader><C-t>', ':Lspsaga term_toggle<CR>', keymap_opts)
    end,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'nvim-treesitter/nvim-treesitter'
    }
  }
}
