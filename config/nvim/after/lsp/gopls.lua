return {
  settings = {
    gopls = {
      gofumpt = true,
      staticcheck = true,
      hints = {
        assignVariableTypes = false,
        compositeLiteralFields = true,
        compositeLiteralTypes = false,
        constantValues = true,
        functionTypeParameters = true,
        ignoredError = true,
        parameterNames = true,
        rangeVariableTypes = false,
      },
      codelenses = {
        generate = true,
        regenerate_cgo = true,
        test = true,
        run_govulncheck = false,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
        vulncheck = true,
      },
    },
  },
}
