{ pkgs, ... }:
let
  user = "fabian";
  programs.vscode.userSettings = {

    # general
    "extensions.autoCheckUpdates" = false;
    "update.mode" = "none";

    # appearance
    "window.zoomLevel" = 1;
    "editor.minimap.enabled" = false;
      "editor.fontSize" = 14;
    "breadcrumbs.enabled" = false;
      "editor.cursorBlinking" = "solid";
        "workbench.editor.showTabs" = "single";
    "workbench.sideBar.location" = "right";
    "workbench.statusBar.visible" = true;
    "window.menuBarVisibility" = "toggle";
      "workbench.colorTheme" = "Catppuccin Mocha";
      "window.titleBarStyle" = "custom";
        "workbench.activityBar.location" = "hidden";

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

    # editor association
    "workbench.editorAssociations" = {
      "*.sql" = "databricks-notebook";
      "*.scala" = "databricks-notebook";
      "*.r" = "databricks-notebook";
    };

    "databricks.connection.default.exportFormats" = {
      "Scala" = ".scala";
      "Python" = ".py.ipynb";
      "SQL" = ".sql";
      "R" = ".r";
    };


  };
in
{

  programs.vscode = {
    enable = true;
  #   extensions = with pkgs.vscode-extensions; [
  #
  #     # general
  #     asvetliakov.vscode-neovim
  #     github.copilot
  #     catppuccin.catppuccin-vsc
  #
  #     # lsp
  #     ms-python.python
  #
  #   ];
  # };
  #
  # home.activation.boforeCheckLinkTargets = {
  #   after = [ ];
  #   before = [ "checkLinkTargets" ];
  #   data = ''
  #     userDir=/home/${user}/.config/Code/User
  #     rm -rf $userDir/settings.json
  #   '';
  # };
  #
  # home.activation.afterWriteBoundary = {
  #   after = [ "writeBoundary" ];
  #   before = [ ];
  #   data = ''
  #     userDir=/home/${user}/.config/Code/User
  #     rm -rf $userDir/settings.json
  #     cat \
  #       ${(pkgs.formats.json {}).generate "blabla"
  #         programs.vscode.userSettings} \
  #       > $userDir/settings.json
  #   '';
  };


}
