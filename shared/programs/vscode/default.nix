{ pkgs, ... }:
let
  user = "fabian";
  programs.vscode.userSettings = {

    # general
    "extensions.autoCheckUpdates" = false;
    "update.mode" = "none";

    # appearance
    "window.zoomLevel" = 1.5;
    "editor.minimap.enabled" = false;
    "breadcrumbs.enabled" = false;
    # "workbench.activityBar.visible" = false;
    "workbench.sideBar.location" = "right";
    "workbench.statusBar.visible" = false;
    "window.menuBarVisibility" = "toggle";

    editor.inlineSuggest.enabled = true;
    # vscode neovim
    "extensions.experimental.affinity" = {
      "asvetliakov.vscode-neovim" = 1;
    };

    "vscode-neovim.neovimPath" = "${pkgs.neovim}/bin/nvim";
    "editor.scrollBeyondLastLine" = false;
    "editor.lineNumbers" = "relative";
    "files.autoSave" = "afterDelay";
    "notebook.lineNumbers" = "on";



    # make shift + enter work with jupyter
    "jupyter.sendSelectionToInteractiveWindow" = true;

  };
in
{

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [

      # general
      asvetliakov.vscode-neovim
      github.copilot

      # data science
      ms-toolsai.jupyter
      ms-toolsai.jupyter-keymap
      ms-python.python

      # abap
      # larshp.vscode-abap # syntax highlighting
      # larshp.vscode-abaplint # linter
      # hudakf.cds # cds language support
      # frehu.abap-snippets # snippets
      # murbani.vscode-abap-remote-fs # connector
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
