{ config, pkgs, ... }:
{
  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/nvim";
    recursive = false;
  };
  xdg.configFile."efm-langserver" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/efm-langserver";
    recursive = false;
  };

  home.packages = with pkgs; [
    # lsp
    efm-langserver
    gopls
    lua-language-server
    nil
    rust-analyzer

    # formatter
    gofumpt
    stylua
    nixfmt

    tree-sitter
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = pkgs.neovim-unwrapped;
    withNodeJs = false;
    withPython3 = false;
    withRuby = false;
  };
}
