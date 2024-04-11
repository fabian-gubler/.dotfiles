{inputs, pkgs, ...}: {
  wayland.windowManager.hyprland = {
    enable = false;
    # ...
    # plugins = [
    #   inputs.hyprland-plugins.packages.${pkgs.system}.hycov
    #   # ...
    # ];
  };
}
