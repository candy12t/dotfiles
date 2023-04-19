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
      vim.keymap.set('n', '<leader>gb', gitsigns.toggle_current_line_blame, {})
      vim.keymap.set('n', '<leader>gd', gitsigns.toggle_deleted, {})
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
    lazy = true,
    event = {
      'BufRead'
    },
    config = true,
  }
}
