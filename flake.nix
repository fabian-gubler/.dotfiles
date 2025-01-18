# nixos starter configurationflake
# https://github.com/Misterio77/nix-starter-configs
{
  description = "Personal NixOS Configuration Flake";

  inputs = {
    #	nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , ...
    } @ inputs:
    let
      inherit (self) outputs;

      # Supported systems for your flake packages, shell, etc.
      system = "x86_64-linux";
      inherit (nixpkgs) lib;

    in
    {

      # Your custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs; };

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#'
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          specialArgs.user = "fabian";
          modules = [
            # > Our main nixos configuration file <
            ./system

            # Include home-manager in nixos installations
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                backupFileExtension = "backup";
                extraSpecialArgs = { inherit inputs outputs; };
                users.fabian = import ./shared;
              };
            }

          ];
        };
      };

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#generic'
      homeConfigurations = {
        generic = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            {
              imports = [ ./shared ];
              targets.genericLinux.enable = true;

            }
          ];
        };
      };
    };
}
