{ config, pkgs, lib, ... }: {

  imports = [
    ./hardware-configuration.nix
	./configuration.nix
	./environment.nix
	./overlays.nix
	./timers
  ];

}
