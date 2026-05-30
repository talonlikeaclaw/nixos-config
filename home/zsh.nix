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
    '';
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    icons = "always";
    extraOptions = [
      "--group-directories-first"
      "--time-style=long-iso"
    ];
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
