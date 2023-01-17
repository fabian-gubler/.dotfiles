{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

# DOCS: `man home-configuration.nix`

  home-manager.users.demo = {
    home.stateVersion = "22.11";
    home.username = "demo";
    home.homeDirectory = "/home/demo";

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    # Packages that should be installed to the user profile.
    home.packages = [
      pkgs.htop
    ];

    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      shellAliases = {
        ll = "exa";
        build = "sudo nixos-rebuild switch";
      };

      history = {
        size = 10000;
        path = "/home/data/zsh/history";
      };

      zplug = {
        enable = true;
        plugins = [
          { name = "Aloxaf/fzf-tab"; }
          { name = "hlissner/zsh-autopair"; }
        ];
      };

      initExtra = '' 
		source ${pkgs.pure-prompt}/share/zsh/site-functions/prompt_pure_setup
		autoload -U promptinit; promptinit
		zstyle ':prompt:pure:prompt:*' color "#D8DEE9"

		source ~/.config/lf/lfcd.sh
		bindkey -s '^f' 'lfcd\n'
		'';
    };

    programs = {
      autojump = {
        enable = true;
        enableZshIntegration = true;
      };
    };


  };
}
