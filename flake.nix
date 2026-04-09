{
  description = "My dotfiles";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    llm-agents = {
      url = "github:numtide/llm-agents.nix";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-darwin,
      llm-agents,
      nix-index-database,
      ...
    }@inputs:
    let
      mkDarwinSystem =
        hostConfig:
        nix-darwin.lib.darwinSystem {
          system = hostConfig.system;
          specialArgs = {
            inherit inputs;
            inherit (hostConfig) username homeDir hostname;
          };
          modules = [
            ./darwin
            ./darwin/system.nix
            nix-index-database.darwinModules.nix-index
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit inputs;
                inherit (hostConfig) username homeDir;
              };
              home-manager.users.${hostConfig.username} = ./home/default.nix;
            }
            {
              environment.systemPackages = [
                llm-agents.packages.${hostConfig.system}.claude-code
              ];
            }
          ];
        };
    in
    {
      darwinConfigurations =
        let
          hosts = [ (import ./hosts/MacBookAir.nix) ];
        in
        builtins.listToAttrs (
          map (h: {
            name = h.hostname;
            value = mkDarwinSystem h;
          }) hosts
        );
    };
}
