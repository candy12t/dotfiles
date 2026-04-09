{ pkgs, ... }:

let
  src = pkgs.fetchFromGitHub {
    owner = "folke";
    repo = "tokyonight.nvim";
    rev = "cdc07ac78467a233fd62c493de29a17e0cf2b2b6";
    sha256 = "sha256-a9iRWue7DB7s/wNdxqqB51Jya5P9X6sDftqhdmKggU0=";
  };

  fromYaml =
    path:
    builtins.fromJSON (
      builtins.readFile (
        pkgs.runCommand "yaml-to-json" { }
          "${pkgs.remarshal}/bin/remarshal -i ${path} -if yaml -of json > $out"
      )
    );
  theme = fromYaml "${src}/extras/eza/tokyonight_moon.yml";
in
{
  programs.eza = {
    enable = true;
    theme = theme;
    enableZshIntegration = false;
  };
}
