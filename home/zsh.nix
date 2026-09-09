{ ... }:

{
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "aliases"
        "colored-man-pages"
        "copypath"
        "copyfile"
        "web-search"
      ];
    };

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      path = "$HOME/.zsh_history";
      size = 10000;
      save = 10000;
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
      append = true;
    };

    shellAliases = {
      cc = "convco commit -i";
      c = "clear";
      cat = "bat -p";
      glf = ''git log --oneline | fzf --preview="git show {1} | bat --color=always -l diff" | awk "{print \\$1}" | xargs -r git show'';
      n = "clear ; fastfetch";
      o = "opencode";
      py = "python3";
      size = "du -sh";
      szsh = "source ~/.zshrc";
      v = "nvim";
      y = "yazi";
    };

    initContent = ''
      setopt HIST_VERIFY
      eval "$(tv init zsh)"

      # Auto-load the homelab key into the SSH agent. Runs on every new shell,
      # but only prompts (once per agent session) when the key isn't loaded yet.
      if [[ -S "$SSH_AUTH_SOCK" ]] && [[ -f "$HOME/.ssh/id_ed25519_homelab" ]]; then
        _homelab_fp="$(ssh-keygen -lf "$HOME/.ssh/id_ed25519_homelab" 2>/dev/null | awk '{print $2}')"
        if [[ -n "$_homelab_fp" ]] && ! ssh-add -l 2>/dev/null | grep -qF "$_homelab_fp"; then
          ssh-add "$HOME/.ssh/id_ed25519_homelab"
        fi
        unset _homelab_fp
      fi
    '';
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    icons = "always";
    extraOptions = [
      "--group-directories-first"
      "--time-style=long-iso"
      "--git"
    ];
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
