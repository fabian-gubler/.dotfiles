{ config, pkgs, ... }:

let
  # TODO: should be imported from initial flake
  user = "fabian";

in
{

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/vda";
  # virtualisation.qemu.guestAgent.enable = true;
  # virtualisation.qemu.guestAgent.enable = true;
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;



  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    # protects nix shell against garbage collection
    extraOptions = ''
        keep-outputs = true
          keep-derivations = true
      	  '';
  };

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" "lp" "scanner" "docker" "libvirtd" ];
    initialPassword = "password";
    shell = pkgs.zsh;
  };

  # Set your time zone and locals
  time.timeZone = "Europe/Zurich";
  location.latitude = 48.1;
  location.longitude = 9.1;

  # Display Server
  services.xserver = {
    enable = true;
    layout = "ch";
    modules = [ pkgs.xf86_input_wacom ];
    libinput.enable = true;
    wacom.enable = true;
    windowManager.dwm.enable = true;
    displayManager = {
      defaultSession = "none+dwm";
      gdm.enable = true;
    };
    serverFlagsSection = ''
      Option "BlankTime" "0"
      Option "StandbyTime" "0"
      Option "SuspendTime" "0"
      Option "OffTime" "0"
    '';
  };

  # services.openvpn.servers = {
  #   homeVPN = { config = '' config /home/fabian/nextcloud/apps/openvpn/homeVPN.conf ''; };
  #   client = {
  #     config = ''
  #       client
  #       remote vpn.example.org
  #       dev tun
  #       proto tcp-client
  #       port 8080
  #       ca /root/.vpn/ca.crt
  #       cert /root/.vpn/alice.crt
  #       key /root/.vpn/alice.key
  #     '';
  #     up = "echo nameserver $nameserver | ${pkgs.openresolv}/sbin/resolvconf -m 0 -a $dev";
  #     down = "${pkgs.openresolv}/sbin/resolvconf -d $dev";
  #   };
  # };

  # Flatpak
  xdg.portal.enable = true;
  services.flatpak.enable = true;

  # TODO: System-wide GTK Theme
  qt5 = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
  };

  networking = {
    hostName = "nixos";
    # hosts = {
    #   "0.0.0.0" = [ "youtube.com" "www.youtube.com" ];
    # };
    networkmanager.enable = true;
    stevenBlackHosts = {
      blockFakenews = true;
      blockGambling = true;
      blockPorn = true;
      blockSocial = false;
    };
  };

  # Use same keyboard layout for tty
  console.useXkbConfig = true;

  # Pipewire
  services = {
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };
  };

  # Service management
  services.logind.extraConfig = ''
    # don’t shutdown when power button is short-pressed
    HandlePowerKey=ignore
  '';

  # Bluetooth
  # hardware = {
  #   keyboard.zsa.enable = true;
  #   bluetooth = {
  #     enable = true;
  #     settings = {
  #       General = {
  #         Enable = "Source,Sink,Media,Socket";
  #       };
  #     };
  #   };
  # };

  services = {
    # touchegg.enable = true;
    gnome.gnome-keyring.enable = true;
    # tlp.enable = true;
    atd.enable = true;
    # unclutter = {
    #   enable = true;
    #   timeout = 1;
    # };


    # redshift = {
    #   enable = true;
    #   temperature.day = 6500;
    #   temperature.night = 3500;
    #   brightness.day = "1";
    #   brightness.night = "0.7";
    # };


  };

  # unlock gnome keyring automatically
  security.pam.services.startx.enableGnomeKeyring = true;

  # virtualisation

  boot.kernelModules = [ "kvm-intel" "kvmfr" ];
  boot.kernelParams = [ "amd_iommu=on" "pcie_aspm=off" ];


  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];


  programs = {
    tmux.enable = true;
    slock.enable = true;
    seahorse.enable = true;
    java.enable = true;
    dconf.enable = true;

    firefox = {
      enable = true;
      # TODO: Debug 
      preferences = {
        "font.size.systemFontScale" = 130;
      };
    };


  };

  # services.postgresql = {
  #   enable = true;
  #   package = pkgs.postgresql_13;
  #   enableTCPIP = true;
  #   authentication = pkgs.lib.mkOverride 10 ''
  #     local all all trust
  #     host all all 127.0.0.1/32 trust
  #     host all all ::1/128 trust
  #   '';
  #   initialScript = pkgs.writeText "backend-initScript" ''
  #  CREATE ROLE fabian WITH LOGIN CREATEDB PASSWORD 'your_password';
  #   CREATE DATABASE your_database WITH OWNER fabian;
  #     GRANT ALL PRIVILEGES ON DATABASE nixcloud TO nixcloud;
  #   '';
  # };
}
