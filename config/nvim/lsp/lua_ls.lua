return {
  settings = {
    Lua = {
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
