{ inputs, outputs, pkgs, ... }:

let
  user = "fabian";
in

{

  imports = [
    ./programs
    ./environment.nix
  ];

  home = {
    username = user;
    homeDirectory = "/home/${user}";
  };


  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.unstable-packages
      outputs.overlays.additions

    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  # disable unread news notification for home-manager
  news.display = "silent";

  # https://nix-community.github.io/home-manager/release-notes.html
  home.stateVersion = "23.11";

}
