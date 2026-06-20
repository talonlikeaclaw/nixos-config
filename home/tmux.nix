{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    escapeTime = 0;
    keyMode = "vi";
    mouse = true;
    prefix = "C-a";
    terminal = "tmux-256color";

    extraConfig = ''
      # True color passthrough
      set-option -sa terminal-overrides ",xterm*:Tc"

      # tmux-sensible defaults (plugin not in nixpkgs)
      set -g focus-events on
      set -g status-interval 5

      # Quick config reload
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf

      # Send prefix on double C-a (for literal C-a to apps)
      bind-key C-a send-prefix

      # Vim-style pane selection (with prefix)
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Split panes with | and -
      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind %

      # Start panes at 1 and renumber windows on close
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on

      # Alt-arrow pane navigation (no prefix)
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # Shift-arrow window navigation
      bind -n S-Left previous-window
      bind -n S-Right next-window

      # Shift+Alt+vim-keys window navigation
      bind -n M-H previous-window
      bind -n M-L next-window

      # vim-tmux-navigator (plugin not in nixpkgs — inline detection)
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
      bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h' 'select-pane -L'
      bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j' 'select-pane -D'
      bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k' 'select-pane -U'
      bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l' 'select-pane -R'

      # Copy mode vi bindings (OSC 52 clipboard replaces tmux-yank on headless)
      set -g set-clipboard on
      bind-key -T copy-mode-vi v send -X begin-selection
      bind-key -T copy-mode-vi C-v send -X rectangle-toggle
      bind-key -T copy-mode-vi y send -X copy-selection-and-cancel

      # Status bar
      set-option -g status-position top

      # tmux-continuum: auto-restore last session on tmux start
      set -g @continuum-restore 'on'

      # Catppuccin theme
      set -g @catppuccin_flavor 'mocha'
      set -g @catppuccin_status_background 'default'
      set -g @catppuccin_window_status_style 'basic'
      set -g @catppuccin_window_number_position 'left'
      set -g @catppuccin_window_flags 'icon'

      # Status bar layout (modules provided by catppuccin plugin)
      set -g status-left-length 100
      set -g status-right-length 100
      set -g status-left ""
      set -g status-right "#{E:@catppuccin_status_directory}"
      set -agF status-right "#{E:@catppuccin_status_session}"
      set -agF status-right "#{@catppuccin_status_gitmux}"

      # sesh: prefix + T opens session switcher (television as picker)
      bind-key T display-popup -E -w 80% -h 70% -d '#{pane_current_path}' -T 'Sesh' "sesh connect $(tv sesh)"
    '';

    plugins = with pkgs.tmuxPlugins; [
      catppuccin
      resurrect
      continuum
    ];
  };

  # gitmux config for catppuccin status bar git module
  home.file.".gitmux.toml".source = ./tmux/gitmux.toml;
}
