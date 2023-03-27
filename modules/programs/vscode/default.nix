{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
	enableExtensionUpdateCheck = false;
	enableUpdateCheck = false;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
    ];
	# keybindings = [];
	# userSettings = {};
  };
}
