{ pkgs, ... }: {
  home.stateVersion = "21.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    nordic
    blanket
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

  programs.kitty = {
    enable = true;
    theme = "Nord";
    font = {
      size = 14.0;
      name = "SF Mono";
    };
    settings = {
      enable_audio_bell = false;
      open_url_modifiers = "ctrl";
      window_margin_width = 5;
      cursor_shape = "block";
      cursor_blink_interval = 0;
      confirm_os_window_close = 0;
      listen_on = "unix:/tmp/kitty";
      allow_remote_control = "socket-only";

    };
    keybindings = {
      "ctrl+2" = "change_font_size all +1.0";
      "ctrl+1" = "change_font_size all -1.0";
      "ctrl+0" = "change_font_size all 0";
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

      initExtra = '' 
		source ${pkgs.pure-prompt}/share/zsh/site-functions/prompt_pure_setup
		source ~/nixos-config/config/misc/prompt_fix
		PURE_CMD_MAX_EXEC_TIME=99999999999999
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
