return {
  {
    'mattn/vim-goimports',
    lazy = true,
    ft = 'go',
    config = function()
      vim.g.goimports = true
      vim.g.go_fmt_command = 'goimports'
      vim.g.goimports_simplify_cmd = 'gofmt'
      vim.g.goimports_show_loclist = false
    end
  }
}
