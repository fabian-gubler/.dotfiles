{
  description = "Personal NixOS Configuration Flake";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-23.05;
    unstable.url = github:nixos/nixpkgs/nixos-unstable;

    home-manager = {
      url = github:nix-community/home-manager/release-23.05;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Additional Modules
    hosts.url = github:StevenBlack/hosts; # blocks inappropriate websites
  };

  outputs =
    inputs@{ self
    , nixpkgs
    , unstable
    , home-manager
    , hosts
    , ...
    }:
    let
      system = "x86_64-linux";
      user = "fabian";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      unstable = import inputs.unstable { system = pkgs.system; };
      lib = nixpkgs.lib;
    in
    {
      overlays = {
        pkg-sets = (
          final: prev: {
            unstable = import inputs.unstable { system = final.system; };
            trunk = import inputs.trunk { system = final.system; };
          }
        );
      };
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          modules = [
            ({ config, pkgs, unstable, ... }:
              let
                overlay-unstable = final: prev: {
                  unstable = unstable.legacyPackages.x86_64-linux;
                };
              in
              {
                # unstable packages
                # Note, `${pkgs.system}` is the "architecture" of the machine evaluating and building
                nixpkgs.overlays = [ overlay-unstable ];
                environment.systemPackages = with inputs.unstable.legacyPackages.${pkgs.system}; [
                  # obsidian # Electron EOL Insecure -> Change when Secure
                ];
              }
            )

            ./system

			# Include home-manager in nixos installations
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.fabian = {
                imports = [ ./shared ];

              };
            }

            hosts.nixosModule
            {
              networking.stevenBlackHosts.enable = true;
            }

          ];
        };
      };
      # for other systems
      homeConfigurations = {
        generic = inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            {
              imports = [ ./shared ];

              home = {
                username = "${user}";
                homeDirectory = "/home/${user}";
              };

              targets.genericLinux.enable = true;

            }
          ];
        };
      };
    };
}
