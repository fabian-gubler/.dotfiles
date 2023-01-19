{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      username = "demo";
      homeDirectory = "/home/demo";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;

      };
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = {
        demo = lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix

            # home-manager.nixosModules.home-manager
            # {
            #   home-manager.useGlobalPkgs = true;
            #   home-manager.useUserPackages = true;
            #   home-manager.users.demo = {
            #     imports = [ ./home.nix ];
            #   };
            # }
          ];
        };
      };
    };
}
