{ pkgs, ... }:
{
  programs.firefox.profiles.default.search = {
    # Override the existing search configuration
    force = true;
    engines = {
      "YouTube" = {
        urls = [{
          template = "https://www.youtube.com/results?search_query={searchTerms}";
        }];
        definedAliases = [ "y" ];
      };
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
      "Nix Options" = {
        urls = [{
          template = "https://search.nixos.org/options";
          params = [
            { name = "type"; value = "packages"; }
            { name = "query"; value = "{searchTerms}"; }
          ];
        }];

        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = [ "no" ];
      };
    };
  };
}
