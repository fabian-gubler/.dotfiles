{ pkgs, ... }: {
    home.stateVersion = "21.11";

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    # Packages that should be installed to the user profile.
    home.packages = [
      pkgs.htop
    ];

    gtk = {
      enable = true;
      theme = {
        # TODO: Change to Nord
        name = "Materia-dark";
        package = pkgs.materia-theme;
      };
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

        t = "todo.sh -d $HOME/nextcloud/todo/config";
        d = "todo.sh -d $HOME/nextcloud/todo/dev/config";
        dv = "nvim -c 'sort' $HOME/nextcloud/todo/dev/dev.txt";
        tv = "nvim -c 'sort' $HOME/nextcloud/todo/todo.txt";
        uv = "nvim -c 'sort' $HOME/nextcloud/todo/uni/uni.txt";
        sc = "cd ~/.dotfiles/scripts/utils/ && exa -a";
      };

      history = {
        size = 10000;
        path = "/home/demo/zsh/history";
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
		source ${pkgs.pure-prompt}/share/zsh/site-functions/prompt_pure_setup
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

    # xdg.configFile."alacritty/alacritty.yml" = {
    #   source = "/home/demo/.dotfiles/config/alacritty/alacritty.yml";
    # };
}
