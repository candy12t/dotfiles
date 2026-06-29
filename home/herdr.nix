{ config, ... }:
{
  xdg.configFile."herdr/config.toml" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/herdr/config.toml";
  };
}
