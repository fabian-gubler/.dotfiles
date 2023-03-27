{ pkgs, ... }:
let
  user = "fabian";
  programs.vscode.userSettings = {
    "window.zoomLevel" = 2;
    "extensions.autoCheckUpdates" = false;
    "update.mode" = "none";

    "extensions.experimental.affinity" = {
      "asvetliakov.vscode-neovim" = 1;
    };

    # vscode neovim
    "vscode-neovim.neovimPath" = "${pkgs.neovim}/bin/nvim";
    "editor.scrollBeyondLastLine" = false;
    "editor.lineNumbers" = "relative";

    };
    in
    {

    programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        # vscodevim.vim
        ms-toolsai.jupyter
        asvetliakov.vscode-neovim
      ];
      # keybindings = [];
    };

    home.activation.boforeCheckLinkTargets = {
      after = [ ];
      before = [ "checkLinkTargets" ];
      data = ''
        userDir=/home/${user}/.config/Code/User
        rm -rf $userDir/settings.json
      '';
    };

    home.activation.afterWriteBoundary = {
      after = [ "writeBoundary" ];
      before = [ ];
      data = ''
        userDir=/home/${user}/.config/Code/User
        rm -rf $userDir/settings.json
        cat \
          ${(pkgs.formats.json {}).generate "blabla"
            programs.vscode.userSettings} \
          > $userDir/settings.json
      '';
    };


  }
