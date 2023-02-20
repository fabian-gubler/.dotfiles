{ pkgs, ... }: {
  programs.tmux =
    {
      enable = true;
      baseIndex = 1;
      clock24 = true;
      disableConfirmationPrompt = true;
      escapeTime = 0;
      sensibleOnTop = false;
      keyMode = "vi";
      terminal = "screen-256color";
      mouse = true;
      prefix = "C-M-B";
      plugins = with pkgs; [
        {

          plugin = tmuxPlugins.fzf-tmux-url;
          extraConfig = "set -g @fzf-url-bind 'V'";
        }
      ];
      extraConfig = ''
		# Key bindings
		bind G run-shell "tmux neww ~/.dotfiles/scripts/tmux/sessionizer"
		bind s display-popup -E -w 60 -h 20 "$HOME/.dotfiles/scripts/tmux/fzf-session switch"
		bind Y display-popup -E -w 60 -h 20 "$HOME/.dotfiles/scripts/tmux/fzf-session kill"
		bind T display-popup -E -w 40 -h 5 "$HOME/.dotfiles/scripts/tmux/find-task"
		bind r source ~/.tmux.conf\; display "~/.tmux.conf sourced!"
		bind R set -g status
		bind C-n swap-window -t +1\; next-window
		bind C-p swap-window -t -1\; previous-window
		bind & kill-pane 
		bind , command-prompt "rename-window '%%'"
		bind C new-window -c "#{pane_current_path}"
		bind X kill-window -a
		bind g respawn-pane -k

		# Colors
		NORD0=#2E3440
		NORD1=#3B4252
		NORD2=#434C5E
		NORD3=#4C566A
		NORD4=#D8DEE9
		NORD5=#E5E9F0
		NORD6=#ECEFF4
		NORD9=#81A1C1
		NORD10=#5E81AC
		GREY=#B0B2B6

		# Visual
		set -g window-status-current-format " #[fg=$NORD2]#[bg=$NORD2, fg=$NORD5]#I #W#[fg=$NORD2, bg=$NORD0]"
		set -g window-status-format " #[bg=$NORD0, fg=$GREY] #I #W "
		set -g status-interval 1
		set -g status-left "#[fg=$NORD9]#S#[fg=$GREY]#($HOME/.dotfiles/scripts/tmux/has-session)"
		set-option -g status-style bg=$NORD0
		set-option -g status-right ""
		set-option -g status-justify centre
		set-option -g message-style fg=#EBCB8B
		set -g pane-border-style fg=$NORD3
		set -g pane-active-border-style fg=$NORD3
					'';
    };
}
