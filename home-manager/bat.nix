{ pkgs, ... }:
{
  programs.bat = {
    enable = true;
    config = {
      theme = "tokyonight_moon";
    };
    themes = {
      tokyonight_moon = {
        src = pkgs.fetchFromGitHub {
          owner = "folke";
          repo = "tokyonight.nvim";
          rev = "cdc07ac78467a233fd62c493de29a17e0cf2b2b6";
          sha256 = "sha256-a9iRWue7DB7s/wNdxqqB51Jya5P9X6sDftqhdmKggU0=";
        };
        file = "extras/sublime/tokyonight_moon.tmTheme";
      };
    };
  };
}
