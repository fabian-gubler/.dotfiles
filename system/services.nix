let
  user = "fabian";
in
{

  # Guest Agent
  services.spice-vdagentd.enable = true;
  services.qemuGuest.enable = true;

  # Display Server
  services.xserver = {
    enable = true;
    layout = "ch";
    desktopManager.gnome.enable = true;
    windowManager.dwm.enable = true;
    displayManager = {
      autoLogin.enable = true;
      autoLogin.user = "${user}";
      # defaultSession = "none+dwm";
      gdm.enable = true;
    };
  };

  services.gnome.gnome-keyring.enable = true; # required for some vs code extensions
  services.atd.enable = true;
  services.flatpak.enable = false;

  # misc applications
  services.jellyfin.enable = true;

}
