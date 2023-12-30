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
    windowManager.dwm.enable = true;
    displayManager = {
      autoLogin.enable = true;
      autoLogin.user = "${user}";
      defaultSession = "none+dwm";
    };
  };

  services.gnome.gnome-keyring.enable = true; # required for some vs code extensions
  services.atd.enable = true;
  services.flatpak.enable = false;

  # services.mongodb.enable = true;

  # services.postgresql = {
  #   enable = true;
  #   # package = pkgs.postgresql_15; # current 15.4
  #   ensureDatabases = [ "mydatabase" ];
  #   authentication = pkgs.lib.mkOverride 10 ''
  #     local all all              trust
  #     host  all all 127.0.0.1/32 trust
  #     host  all all ::1/128      trust
  #   '';
  #   enableTCPIP = true;
  #   # port = 5432;
  # };

  # misc applications
  services.jellyfin.enable = true;

}
