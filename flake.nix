{
  description = "Personal NixOS Configuration Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    hosts.url = github:StevenBlack/hosts;
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, hosts, ... }:
    let
      username = "fabian";
      homeDirectory = "/home/fabian";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;

      };
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = {
        fabian = lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.fabian = {
                imports = [ ./home ];
              };
            }
            hosts.nixosModule
            {
              networking.stevenBlackHosts.enable = true;
            }
          ];
        };
      };
    };
}
