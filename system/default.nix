{ config, pkgs, lib, ... }: {

  imports = [
    ./hardware-configuration.nix
	./configuration.nix
	./overlays.nix
	./services.nix
	./timers
  ];

}
