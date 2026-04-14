{ pkgs, tokyonightSrc, ... }:

let
  fromYaml =
    path:
    builtins.fromJSON (
      builtins.readFile (
        pkgs.runCommand "yaml-to-json" { }
          "${pkgs.remarshal}/bin/remarshal -i ${path} -if yaml -of json > $out"
      )
    );
  theme = fromYaml "${tokyonightSrc}/extras/eza/tokyonight_moon.yml";
in
{
  home.sessionVariables = {
    EZA_CONFIG_DIR = "$HOME/.config/eza";
  };

  programs.eza = {
    enable = true;
    theme = theme;
    enableZshIntegration = false;
  };
}
