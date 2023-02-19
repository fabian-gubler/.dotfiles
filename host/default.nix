{ config, pkgs, lib, ... }: {

  imports = [
    ./hardware-configuration.nix
	./configuration.nix
	./environment.nix
    ./timers.nix
	./overlays.nix
  ];

}
