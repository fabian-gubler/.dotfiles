{
  description = "Personal NixOS Configuration Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Additional Modules
    hosts.url = github:StevenBlack/hosts; # blocks inappropriate websites
    spicetify-nix.url = github:the-argus/spicetify-nix; # spotify ricing & configuration
  };

  outputs =
    inputs@{ self
    , nixpkgs
    , nixpkgs-unstable
    , home-manager
    , hosts
    , spicetify-nix
    , ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
      spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
    in
    {
      overlays = {
        # Inject 'unstable' and 'trunk' into the overridden package set, so that
        # the following overlays may access them (along with any system configs
        # that wish to do so).
        pkg-sets = (
          final: prev: {
            unstable = import inputs.unstable { system = final.system; };
            trunk = import inputs.trunk { system = final.system; };
          }
        );
        # Remaining attributes elided.
      };
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          modules = [
            ({ config, pkgs, ... }:
              let
                overlay-unstable = final: prev: {
                  unstable = nixpkgs-unstable.legacyPackages.x86_64-linux;
                };
              in
              {
                nixpkgs.overlays = [ overlay-unstable ];
                environment.systemPackages = with pkgs; [
                  # unstable.litemdview # not in stable yet
                ];
              }
            )

            ./system

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.fabian = {
                imports = [ ./modules spicetify-nix.homeManagerModules.default ];

                programs.spicetify = {
                  enable = true;

                  theme = spicePkgs.themes.catppuccin-mocha;
                  colorScheme = "Default";
                  # colorScheme = "flamingo";

                  enabledExtensions = with spicePkgs.extensions; [
                    keyboardShortcut # vim-like navigation
                    shuffle # shuffle+ (special characters are sanitized out of ext names)
                  ];
                };
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
