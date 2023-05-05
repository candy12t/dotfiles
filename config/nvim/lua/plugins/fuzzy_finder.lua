return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    lazy = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzf-native.nvim'
    },
    keys = {
      { '<leader>ff' },
      { '<leader>fg' },
      { '<leader>fb' }
    },
    config = function()
      local hidden_opt = '--hidden'
      local glob_pattern_opt = {
        '!.git/**',
        '!.node_modules/**'
      }
      local find_command_opt = {
        'rg',
        '--files'
      }

      table.insert(find_command_opt, hidden_opt)
      for _, pattern in ipairs(glob_pattern_opt) do
        table.insert(find_command_opt, '--glob')
        table.insert(find_command_opt, pattern)
      end

      local actions = require('telescope.actions')
      local fb_actions = require('telescope').extensions.file_browser.actions

      require('telescope').setup({
        defaults = {
          mappings = {
            i = {
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
              ['<C-o>'] = actions.select_default,
              ['<CR>'] = actions.select_default,
              ['<esc>'] = actions.close
            }
          },
        },
        pickers = {
          find_files = {
            find_command = find_command_opt
          },
          live_grep = {
            additional_args = { hidden_opt },
            glob_pattern = glob_pattern_opt
          }
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case'
          },
          file_browser = {
            hidden = true,
            grouped = true,
            mappings = {
              i = {
                ['<C-a>'] = fb_actions.create,
                ['<C-m>'] = fb_actions.rename,
                ['<C-d>'] = fb_actions.remove,
                ['<C-y>'] = fb_actions.copy,
                ['<C-f>'] = fb_actions.toggle_browser
              }
            }
          }
        }
      })

      local builtin = require('telescope.builtin')
      local keymap_opts = { noremap = true, silent = true }
      vim.keymap.set('n', '<leader>ff', builtin.find_files, keymap_opts)
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, keymap_opts)
      vim.keymap.set('n', '<leader>fb', ':Telescope file_browser<CR>', {})

      require('telescope').load_extension('fzf')
      require('telescope').load_extension('file_browser')
    end
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    lazy = true
  },
  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons'
    },
    lazy = true
  }
}
