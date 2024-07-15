{ pkgs, ... }:

{
  imports = [
    ./bookmarks.nix
    ./search.nix
  ];

  # nixpkgs.config.firefox = {
  #   enableTridactylNative = true;
  # };

  # home-manager.users."${user}" = {
  programs.firefox = {
    package = pkgs.firefox.override {
      nativeMessagingHosts = with pkgs; [
        tridactyl-native
      ];
      # TODO: this should be released in next version

      # nativeMessagingHosts.tridactyl = true;
    };
    enable = true;
    policies = {
      # FIX: More manual, but less maintained way to add extensions (might use both)

      # ExtensionSettings = {
      #   "*".installation_mode = "blocked"; # blocks all addons except the ones specified below
      #   # uBlock Origin:
      #   "uBlock0@raymondhill.net" = {
      #     install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
      #     installation_mode = "force_installed";
      #   };
      # };
    };
    profiles.default = {
      # FIX: One way to add extensions
      # TODO: Get Nur working

      # missing: 
      # - thumbnail rating bar
      # - unhook

      # extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      #   ublock-origin
      #   toolkit-for-ynab
      #   hoppscotch
      #   tridactyl
      #   bitwarden
      #   multi-account-containers
      # ];
      settings = {
        "services.sync.prefs.sync.browser.uiCustomization.state" = true;
        "browser.aboutConfig.showWarning" = false;
        "browser.uidensity" = 2;
        "browser.startup.homepage" = "about:blank";
        "browser.tabs.closeWindowWithLastTab" = false;
        "browser.toolbars.bookmarks.visibility" = "never";
        "toolkit.cosmeticAnimations.enabled" = false;

        # do not offer to save passwords = nor allow the user to enable the feature
        "signon.rememberSignons" = false;

        # remove home screen advertisements
        "extensions.pocket.enabled" = false;
        "extensions.pocket.showHome" = false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;

      };
    };
  };

  # Firefox Touchscreen Optimized
  home.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
  };

  # TODO: Tridactyl not working
  xdg.configFile."tridactyl/tridactylrc".source = ./tridactylrc;
}
