{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    shellAliases = {
      ll = "exa -a";
      lg = "lazygit";
      v = "nvim";
      sv = "sudoedit";
      top = "gotop -l minimal";
      mutt = "neomutt";
      gpush = "git add . && git commit -m 'manual update' && git push";

      p = "todo.sh -d $HOME/nextcloud/todo/pers/config";
      pv = "cd $HOME/nextcloud/todo/pers; nvim -c 'sort' todo.txt";
      d = "todo.sh -d $HOME/nextcloud/todo/dev/config";
      dv = "cd $HOME/nextcloud/todo/dev; nvim -c 'sort' dev.txt";
      u = "todo.sh -d $HOME/nextcloud/todo/uni/config";
      uv = "cd $HOME/nextcloud/todo/uni; nvim -c 'sort' uni.txt";
      sc = "cd ~/.dotfiles/scripts/utils/ && exa -a";
      ".." = "cd ..";
    };

    envExtra = ''
      	  export DIRENV_LOG_FORMAT=
            export OPENAI_API_KEY=$(rbw get OPENAI_API_KEY)
    '';

    history = {
      size = 10000;
      path = "/home/fabian/.config/zsh/history";
    };

    zplug = {
      enable = true;
      plugins = [
        { name = "hlissner/zsh-autopair"; tags = [ defer:2 ]; } # fix: not working
        { name = "Aloxaf/fzf-tab"; }
        { name = "mafredri/zsh-async"; }
        { name = "chisui/zsh-nix-shell"; }
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

	t() {
		date +"%A, %d.%m.%Y   (%W)"

		if [ -z "$1" ]; then
			:
		else
			echo ""
			khal -c ~/.dotfiles/modules/files/khal/config.tasks list -a task now $@
		fi
	}

	ut (){
		todo.sh -d $HOME/nextcloud/todo/uni/config 
		if [ -z "$1" ]; then
			:
		else
			echo ""
			t $@
		fi
		}
	'';
  };
}
