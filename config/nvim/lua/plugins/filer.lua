return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "v3.*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<C-e>", ":Neotree toggle<CR>", mode = "n", noremap = true, silent = true, desc = "Neotree" },
  },
  opts = {
    sources = {
      "filesystem",
    },
    use_default_mappings = false,
    window = {
      mappings = {
        ["o"] = "open",
        ["<esc>"] = "cancel",
        ["P"] = { "toggle_preview", config = {
          use_float = true,
          use_image_nvim = false,
        } },
        ["<C-f>"] = { "scroll_preview", config = { direction = -10 } },
        ["<C-b>"] = { "scroll_preview", config = { direction = 10 } },
        ["l"] = "focus_preview",
        ["S"] = "open_split",
        ["s"] = "open_vsplit",
        ["t"] = "open_tabnew",
        ["C"] = "close_node",
        ["z"] = "close_all_nodes",
        ["R"] = "refresh",
        ["a"] = {
          "add",
          -- some commands may take optional config options, see `:h neo-tree-mappings` for details
          config = {
            show_path = "none", -- "none", "relative", "absolute"
          },
        },
        ["A"] = "add_directory", -- also accepts the config.show_path and config.insert_as options.
        ["d"] = "delete",
        ["r"] = "rename",
        ["y"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
        ["c"] = "copy", -- takes text input for destination, also accepts the config.show_path and config.insert_as options
        ["m"] = "move", -- takes text input for destination, also accepts the config.show_path and config.insert_as options
        ["e"] = "toggle_auto_expand_width",
        ["q"] = "close_window",
        ["?"] = "show_help",
        ["<"] = "prev_source",
        [">"] = "next_source",
      },
    },
    filesystem = {
      filtered_items = {
        visible = true,
      },
    },
  },
}
