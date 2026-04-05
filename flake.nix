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
  };

  outputs =
    { self, nixpkgs, home-manager, nix-darwin, llm-agents, ... }:
    {
      darwinConfigurations."MacBookAir" = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit self; };
        modules = [
          ./nix-darwin/configuration.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.candy12t = ./home-manager/home.nix;
          }
          {
            environment.systemPackages = with llm-agents.packages.aarch64-darwin; [
              claude-code
            ];
          }
        ];
      };
    };
}
