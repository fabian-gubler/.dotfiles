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
      plugins = with pkgs; [
        {

          plugin = tmuxPlugins.fzf-tmux-url;
          extraConfig = "set -g @fzf-url-bind 'V'";
        }
      ];
      extraConfig = ''
		bind G run-shell "tmux neww ~/.dotfiles/scripts/tmux/sessionizer"
		bind s display-popup -E -w 60 -h 20 "$HOME/.dotfiles/scripts/tmux/fzf-session switch"
		bind Y display-popup -E -w 60 -h 20 "$HOME/.dotfiles/scripts/tmux/fzf-session kill"
		bind T display-popup -E -w 40 -h 5 "$HOME/.dotfiles/scripts/tmux/find-task"
		bind r source ~/.config/tmux/tmux.conf\; display "~/.tmux.conf sourced!"
		bind R set -g status
		bind C-n swap-window -t +1\; next-window
		bind C-p swap-window -t -1\; previous-window
		bind , command-prompt "rename-window '%%'"
		bind C new-window -c "#{pane_current_path}"
		bind X kill-window -a
		bind g respawn-pane -k

		set -g window-status-current-format " #[fg=#434C5E]#[bg=#434C5E, fg=#E5E9F0]#I #W#[fg=#434C5E, bg=#2E3440]"
		set -g window-status-format " #[bg=#2E3440, fg=#B0B2B6] #I #W "
		set -g pane-border-style fg=#4C566A
		set -g pane-active-border-style fg=#4C566A
		set -g status-left "#[fg=#81A1C1]#S#[fg=#B0B2B6]#($HOME/.dotfiles/scripts/tmux/has-session)"
		set -g status-interval 1
		set-option -g status-style bg=#2E3440
		set-option -g status-right ""
		set-option -g status-justify centre
		set-option -g message-style fg=#EBCB8B
					'';
    };
}
