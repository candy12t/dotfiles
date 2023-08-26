return {
  {
    'ibhagwan/fzf-lua',
    lazy = true,
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    keys = {
      { '<leader>ff' },
      { '<leader>fr' }
    },
    config = function()
      require('fzf-lua').setup({
      })
      local fzf_lua = require('fzf-lua')
      local keymap_opts = { noremap = true, silent = true }
      vim.keymap.set('n', '<leader>ff', fzf_lua.files, keymap_opts)
      vim.keymap.set('n', '<leader>fr', fzf_lua.grep_project, keymap_opts)
    end
  }
}
