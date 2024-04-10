# nixos starter configurationflake
# https://github.com/Misterio77/nix-starter-configs
{
  description = "Personal NixOS Configuration Flake";

  inputs = {
    #	nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # additional
    hosts.url = "github:StevenBlack/hosts";
    hyprland.url = "github:hyprwm/Hyprland";
    nixgl.url = "github:guibou/nixGL";
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , hosts
    , nixgl
    , ...
    } @ inputs:
    let
      inherit (self) outputs;

      # Supported systems for your flake packages, shell, etc.
      system = "x86_64-linux";
      lib = nixpkgs.lib;

    in
    {

      # Your custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs; };

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#'
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            # > Our main nixos configuration file <
            ./system

            hosts.nixosModule
            {
              networking.stevenBlackHosts = {
                enable = true;
                blockFakenews = true;
                blockGambling = true;
                blockPorn = true;
                blockSocial = false;
              };
            }

            # Include home-manager in nixos installations
            home-manager.nixosModules.home-manager
            {
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs outputs; };
              home-manager.users.fabian = import ./shared;
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
