# NixOs fhs-user script
# ---------------------
#
# this is a script for NixOS users, to start Bitwig.
# It is quite similar to docker or rkt but it uses system libs
# to create a "normal" Linux environment so dynamic links can find
# everything they need.


# function header
# ---------------
{ pkgs ? import <nixpkgs> { } }:

# function call
# -------------
(pkgs.buildFHSUserEnv {

  # name it
  # -------
  name = "bitwig";

  # targetSystem packages
  # ---------------------
  # these are packages which are compiled for the target
  # system architecture
  targetPkgs = pkgs: with pkgs; [

    # bitwig dependencies
    yabridge
    yabridgectl

    # custom added (was needed for vital)
    xorg.libSM
    xorg.libICE
    xorg.libXrender
    libselinux

    # todo : check if they are needed
    coreutils
    curl
    tig
    ack
    which
    liblo
    zlib
    fftw
    minixml
    libcxx
    alsaLib

    # the following are needed for building
    #libcxxStdenv
    glibc

    # the following are needed for Sononym run
    gtk2-x11
    atk
    mesa_glu
    glib
    pango
    gdk-pixbuf
    cairo
    freetype
    fontconfig
    dbus
    xorg.libX11
    xorg.libxcb
    xorg.libXext
    xorg.libXinerama
    xorg.libXi
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXcomposite
    xorg.libXfixes
    xorg.libXrender
    xorg.libXtst
    xorg.libXScrnSaver

    nss
    nspr
    expat
    eudev

    ladspaPlugins
  ];

  # command
  # -------
  # the script which should be run right after starting this environment
  runScript = "bitwig-studio";

  # environment variables
  # ---------------------
  profile = ''
    export TERM="xterm"
  '';

}).env
