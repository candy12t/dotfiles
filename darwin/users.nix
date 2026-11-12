{ username, homeDir, ... }:
{
  system = {
    primaryUser = username;
  };

  users.users.${username} = {
    home = homeDir;
    name = username;
  };

  nixpkgs.config.allowUnfree = true;
}
