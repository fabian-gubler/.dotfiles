{ pkgs, ... }: {
  home.stateVersion = "21.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    nordic
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Nordic";
    };
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
	style.name = "adwaita-dark";
	style.package = pkgs.adwaita-qt;
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    shellAliases = {
      build = "sudo nixos-rebuild switch";
      ll = "exa -a";
      v = "nvim";
      sv = "sudoedit";
      top = "gotop -l minimal";
      mutt = "mbsync protonmail && neomutt";
      gpush = "git add . && git commit -m 'manual update' && git push";
      lg = "lazygit";

      t = "todo.sh -d $HOME/nextcloud/todo/config";
      d = "todo.sh -d $HOME/nextcloud/todo/dev/config";
      dv = "nvim -c 'sort' $HOME/nextcloud/todo/dev/dev.txt";
      tv = "nvim -c 'sort' $HOME/nextcloud/todo/todo.txt";
      uv = "nvim -c 'sort' $HOME/nextcloud/todo/uni/uni.txt";
      sc = "cd ~/.dotfiles/scripts/utils/ && exa -a";
      ".." = "cd ..";

    };

    history = {
      size = 10000;
      path = "/home/fabian/zsh/history";
    };

    zplug = {
      enable = true;
      plugins = [
        { name = "Aloxaf/fzf-tab"; }
        { name = "hlissner/zsh-autopair"; }
        { name = "mafredri/zsh-async"; }
      ];
    };

    # envExtra = ''
    #   MANPAGER='nvim +Man!'
    # '';

    initExtra = '' 
		source ~/.dotfiles/config/zsh/pure_fix
		source ${pkgs.pure-prompt}/share/zsh/site-functions/prompt_pure_setup
		PURE_CMD_MAX_EXEC_TIME=99999999999999
		autoload -U promptinit; promptinit
		zstyle ':prompt:pure:prompt:*' color "#D8DEE9"

		source ~/.config/lf/lfcd.sh
		bindkey -e 
		bindkey -s '^f' 'lfcd\n'
		'';
  };

  programs = {

    autojump = {
      enable = true;
      enableZshIntegration = true;
    };

    git = {
      enable = true;
      userEmail = "fabian.gubler@protonmail.com";
      userName = "Fabian Gubler";
      extraConfig = {
        core = {
          editor = "nvim";
        };
        color = {
          ui = true;
        };
        pull = {
          ff = "only";
        };
        init = {
          defaultBranch = "main";
        };
      };
    };
  };

  #  programs.mpv = {
  #    enable = true;
  #    scripts = [ pkgs.mpvScripts.mpris ];
  #    config = { };
  # bindings = { };
  #  };

  # GUIDE: Manage Dotfiles 
  # https://rgoulter.com/blog/posts/programming/2022-02-20-using-home-manager-to-manage-symlinks-to-dotfiles.html

}
