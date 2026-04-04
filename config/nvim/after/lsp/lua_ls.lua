return {
  settings = {
    Lua = {
      codeLens = { enable = false },
      format = { enable = false },
      hint = { enable = false },
      workspace = {
        library = {
          vim.fn.expand("$VIMRUNTIME/lua"),
        },
      },
      diagnostics = {
        globals = { "hs" },
      },
    },
  },
}
