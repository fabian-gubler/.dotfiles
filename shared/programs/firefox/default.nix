{ config, pkgs, lib, ... }:
{

	imports = [
./bookmarks.nix
	];

  # nixpkgs.config.firefox = {
  #   enableTridactylNative = true;
  # };

  # home-manager.users."${user}" = {
  programs.firefox = {
    enable = true;
    profiles.default = {
      search.engines = {
        "Nix Packages" = {
          urls = [{
            template = "https://search.nixos.org/packages";
            params = [
              { name = "type"; value = "packages"; }
              { name = "query"; value = "{searchTerms}"; }
            ];
          }];

          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "np" ];
        };
        "YouTube" = {
          urls = [{
            template = "https://www.youtube.com/results?search_query={searchTerms}";
          }];
          definedAliases = [ "y" ];
        };
      };
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

  # TODO: Firefox Touchscreen not working
  home.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
  };

  # TODO: Tridactyl not working
  # xdg.configFile."tridactyl/tridactylrc".source = ./tridactylrc;
  # };
}
