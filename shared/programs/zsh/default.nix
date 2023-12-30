{ pkgs, config, ... }: {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    shellAliases = {

      # Shorthands
      sv = "sudoedit";
      v = "${pkgs.neovim}/bin/nvim";
      top = "${pkgs.gotop}/bin/gotop -l minimal";
      gpush = "${pkgs.git}/bin/git add . && git commit -m 'manual update' && git push";
      gl = "${pkgs.nixgl.nixGLIntel}/bin/nixGLIntel";
      lg = "${pkgs.lazygit}/bin/lazygit";
    };

    envExtra = ''
      export DIRENV_LOG_FORMAT=
    '';

    history = {
      size = 10000;
      path = "${config.home.homeDirectory}/.config/zsh/history";
    };

    zplug = {
      enable = true;
      plugins = [
        { name = "hlissner/zsh-autopair"; tags = [ "defer:2" ]; }
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

	  eisvogel() {
		  ${pkgs.docker}/bin/docker run --rm \
		   --volume "$(pwd):/data" \
		   --user $(id -u):$(id -g) \
		   pandoc/extra "$1".md -o "$1".pdf --template eisvogel --listings
	  }

	t() {
		date +"%A, %d.%m.%Y   (%W)"

		if [ -z "$1" ]; then
			:
		else
			echo ""
			khal -c /data/.dotfiles/shared/files/khal/config.tasks list -a task now $@
		fi
	}

	'';
  };
}
