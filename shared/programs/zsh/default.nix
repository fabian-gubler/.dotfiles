{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    shellAliases = {

      # Shorthands
      v = "nvim";
      nv = "nix run ~/neovim-nix";
      sv = "sudoedit";
      top = "gotop -l minimal";
      mutt = "neomutt";
      gpush = "git add . && git commit -m 'manual update' && git push";
	  gl = "nix run --override-input nixpkgs nixpkgs/nixos-21.11 --impure github:guibou/nixGL -- ";
	  pandock = ''
		  docker run --rm \
		   --volume "$(pwd):/data" \
		   --user $(id -u):$(id -g) \
		   pandoc/extra example.md -o example.pdf --template eisvogel --listings
	  '';

      # Tasks
      p = "todo.sh -d /data/nextcloud/todo/pers/config";
      pv = "cd /data/nextcloud/todo/pers; nvim -c 'sort' todo.txt";
      d = "todo.sh -d /data/nextcloud/todo/dev/config";
      dv = "cd /data/nextcloud/todo/dev; nvim -c 'sort' dev.txt";
      u = "todo.sh -d /data/nextcloud/todo/uni/config";
      uv = "cd /data/nextcloud/todo/uni; nvim -c 'sort' uni.txt";
      sc = "cd /data/.dotfiles/scripts/utils/ && exa -a";
    };

    envExtra = ''
      export DIRENV_LOG_FORMAT=
      export WATSON_DIR=/data/nextcloud/todo/watson
      # export OPENAI_API_KEY=$(rbw get OPENAI_API_KEY)

	# credentials
	# export SPEECH_KEY=$(rbw get SBB_SPEECH_KEY)
	# export SPEECH_REGION=westeurope


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
	source /data/.dotfiles/shared/programs/zsh/prompt_fix
	PURE_CMD_MAX_EXEC_TIME=99999999999999
	zstyle ':prompt:pure:prompt:*' color "#D8DEE9"

	source /data/.dotfiles/shared/programs/zsh/lfcd.sh
	bindkey -e 
	bindkey -s '^f' 'lfcd\n'

	t() {
		date +"%A, %d.%m.%Y   (%W)"

		if [ -z "$1" ]; then
			:
		else
			echo ""
			khal -c /data/.dotfiles/modules/files/khal/config.tasks list -a task now $@
		fi
	}

	ut (){
		todo.sh -d /data/nextcloud/todo/uni/config 
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
