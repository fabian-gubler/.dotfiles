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
      terminal = "xterm-256color";
      shell = "${pkgs.zsh}/bin/zsh";
      # mouse = true;
      plugins = with pkgs; [
        {

          plugin = tmuxPlugins.fzf-tmux-url;
          extraConfig = "set -g @fzf-url-bind 'V'";
        }
        {
          plugin = tmuxPlugins.resurrect;
          extraConfig = "set -g @resurrect-strategy-nvim 'session'";
        }
        {
          plugin = tmuxPlugins.continuum;
          # extraConfig = "set -g @continuum-restore 'on'";
        }
        {
          plugin = tmuxPlugins.yank;

        }
      ];
      extraConfig = ''
        		bind G run-shell "tmux neww ~/.dotfiles/scripts/tmux/sessionizer"
        		bind s display-popup -E -w 60 -h 20 "~/.dotfiles/scripts/tmux/fzf-session switch"
        		bind Y display-popup -E -w 60 -h 20 "~/.dotfiles/scripts/tmux/fzf-session kill"
        		bind T display-popup -E -w 40 -h 5 "~/.dotfiles/scripts/tmux/find-task"
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
        		set -g status-left "#[fg=#81A1C1]#S#[fg=#B0B2B6]#(/data/.dotfiles/scripts/tmux/has-session)"
        		set -g status-interval 1
        		set -g focus-events on
        		set-option -g status-style bg=#2E3440
        		set-option -g status-style bg=#2E3440
        		set-option -g status-right ""
        		set-option -g status-justify centre
        		set-option -g message-style fg=#EBCB8B
        		set-option -ga terminal-overrides ",xterm-256color:Tc"

        		set-option -s set-clipboard off
        		bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "xclip -selection clipboard -i"
                					'';
    };
}
