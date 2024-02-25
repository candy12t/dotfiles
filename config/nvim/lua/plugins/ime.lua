return {
  "vim-skk/eskk.vim",
  build = "$HOME/dotfiles/installer/tools/skk-jisyo/install.sh",
  config = function()
    vim.g["eskk#directory"] = "~/.eskk"
    vim.g["eskk#dictionary"] = { path = "~/.skk_jisyo", sorted = 1, encoding = "utf-8" }
    vim.g["eskk#large_dictionary"] = { path = "$HOME/.config/skk/SKK-JISYO.L", sorted = 1, encoding = "euc-jp" }
  end,
}
