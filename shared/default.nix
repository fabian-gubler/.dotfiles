{ config, pkgs, ... }: {

  home.stateVersion = "23.05";

  imports = [
    ./files
    ./programs
	./environment.nix
  ];

}
