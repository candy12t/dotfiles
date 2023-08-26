return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    version = 'v2.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('neo-tree').setup({
        filesystem = {
          filtered_items = {
            visible = true,
          }
        },
        window = {
          mappings = {
            ['o'] = 'open'
          }
        }
      })

      local keymap_opts = { noremap = true, silent = true }
      vim.keymap.set('n', '<C-e>', ':NeoTreeFocusToggle<CR>', keymap_opts)
    end
  }
}
