{
  inputs,
  username,
  homeDir,
  ...
}:
{
  imports = [
    inputs.home-manager.darwinModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs username homeDir;
    };
    users.${username}.imports = [
      ../home
    ];
  };
}
