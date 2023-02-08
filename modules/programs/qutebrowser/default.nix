{ pkgs, config, lib, ... }: {

  imports = [
    ./nord.nix
  ];

  # Config Inspiration: 
  # https://github.com/somasis/nixos/tree/87a3c03a76ecfefa8e7380fed8c6c44a052b4fc8/users/somasis/desktop/qutebrowser

  nixpkgs.overlays = [
    (final: prev: { qutebrowser = prev.qutebrowser.override { enableWideVine = true; }; })
  ];

  xdg.desktopEntries.qutebrowser = {
    name = "qutebrowser";
    exec = "qutebrowser";
    mimeType = [ "text/html" "x-scheme-handler/http" "x-scheme-handler/https" ];
  };

  programs.qutebrowser = {
    enable = true;

    searchEngines = {
      w = "https://en.wikipedia.org/wiki/Special:Search?search={}&amp;go=Go&amp;ns0=1";
      g = "https://www.google.com/search?hl=en&amp;q={}";
      y = "https://yewtu.be/search?q={}";
      x = "https://1337x.unblockit.pet/search/{}/1/";
      de = "https://www.deepl.com/translator#en/de/{}";
      en = "https://www.deepl.com/translator#de/en/{}";
      p = "https://www.powerthesaurus.org/{}/synonyms";
      k = "https://www.merriam-webster.com/dictionary/{}";
    };

    keyBindings = {
      normal = {
        "<ctrl-o>" = "back";
        "<ctrl-i>" = "forward";
        ";m" = "hint links spawn mpv {hint-url}";
        "xx" = "config-cycle tabs.show always never;; config-cycle statusbar.show always never";
        "gd" = "download-open";
        "b" = "spawn --userscript ~/.dotfiles/modules/programs/qutebrowser/files/rofi-menu marks";
        "B" = "spawn --userscript ~/.dotfiles/modules/programs/qutebrowser/files/rofi-menu marks-tab";
      };

    };

    extraConfig = ''
      config.set('input.mode_override', 'passthrough', 'localhost:8888')
      config.set('input.mode_override', 'passthrough', 'https://www.overleaf.com')
    '';

    settings = {
      hints.chars = "arstdhneio";
      content.autoplay = false;
      tabs.show = "always";
      statusbar.show = "always";
      auto_save.session = true;

      url = {
        default_page = "about:blank";
        start_pages = "about:blank";
      };

      fonts = {
        default_family = "SFMono";
        default_size = "10pt";
      };

      content = {
        blocking.method = "hosts";
        blocking.adblock.lists = [
          "https://easylist.to/easylist/easylist.txt"
          "https://easylist.to/easylist/easyprivacy.txt"
          "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt"
        ];
      };

      colors = {
        webpage = {
          bg = "#2E3440";
          preferred_color_scheme = "dark";
          darkmode = {
            enabled = true;
            algorithm = "lightness-cielab";
            threshold.text = 150;
            threshold.background = 100;
            policy.images = "always";
            grayscale.images = 0.35;
          };
        };
      };
    };
  };
}
