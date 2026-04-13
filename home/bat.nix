{ tokyonightSrc, ... }:
{
  programs.bat = {
    enable = true;
    config = {
      theme = "tokyonight_moon";
    };
    themes = {
      tokyonight_moon = {
        src = tokyonightSrc;
        file = "extras/sublime/tokyonight_moon.tmTheme";
      };
    };
  };
}
