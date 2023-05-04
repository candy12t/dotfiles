return {
  'nvim-treesitter/nvim-treesitter',
  lazy = true,
  event = {
    'BufRead'
  },
  dependencies = {
    'p00f/nvim-ts-rainbow',
    'RRethy/nvim-treesitter-endwise'
  },
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        'bash',
        'c',
        'comment',
        'css',
        'diff',
        'dockerfile',
        'git_config',
        'gitcommit',
        'gitignore',
        'go',
        'gomod',
        'gosum',
        'html',
        'java',
        'javascript',
        'json',
        'lua',
        'make',
        'markdown',
        'python',
        'ruby',
        'rust',
        'sql',
        'toml',
        'tsx',
        'typescript',
        'vim',
        'yaml'
      },
      highlight = {
        enable = true
      },
      rainbow = {
        enable = true
      },
      endwise = {
        enable = true
      }
    })
  end
}
