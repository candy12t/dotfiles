return {
  settings = {
    Lua = {
      format = {
        enable = false,
      },
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
