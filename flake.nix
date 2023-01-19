{
  description = "My Home Manager flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs: {
    defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;

    homeConfigurations = {
      # TODO: Modify "your.username" below to match your username
      "fabian" = inputs.home-manager.lib.homeManagerConfiguration {
        system = "x86_64-linux"; # TODO: replace with x86_64-darwin on MacOS
        homeDirectory = "/home/fabian"; # TODO: make this match your home directory
        username = "fabian"; # TODO: Change to your username
        configuration.imports = [ ./home.nix ];
      };
    };
  };
}
