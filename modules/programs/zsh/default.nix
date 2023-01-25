{ pkgs, ... }: {
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
      path = "/home/fabian/.config/zsh/history";
    };

    zplug = {
      enable = true;
      plugins = [
        { name = "Aloxaf/fzf-tab"; }
        { name = "hlissner/zsh-autopair"; tags = [ "defer:2" ]; }
        { name = "mafredri/zsh-async"; }
      ];
    };

    # TODO: prompt_fix & lfcd.sh impure (e.g. with basedir)
    initExtra = '' 
	source ${pkgs.pure-prompt}/share/zsh/site-functions/prompt_pure_setup
	source ~/.dotfiles/modules/programs/zsh/prompt_fix
	PURE_CMD_MAX_EXEC_TIME=99999999999999
	zstyle ':prompt:pure:prompt:*' color "#D8DEE9"

	source ~/.dotfiles/modules/programs/zsh/lfcd.sh
	bindkey -e 
	bindkey -s '^f' 'lfcd\n'
	'';
  };
}
