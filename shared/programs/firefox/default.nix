{
  imports = [
    ./bookmarks.nix
    ./search.nix
  ];

  nixpkgs.config.firefox = {
    enableTridactylNative = true;
  };

  # home-manager.users."${user}" = {
  programs.firefox = {
    enable = true;
    profiles.default = {
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
