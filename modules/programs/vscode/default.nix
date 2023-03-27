{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
	enableExtensions = false;
	enableUpdateCheck = false;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
    ];
	# keybindings = [];
	# userSettings = {};
  };
}
