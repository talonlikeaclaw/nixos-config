{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
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
      c = "clear";
      cat = "bat -p";
      glf = ''git log --oneline | fzf --preview="git show {1} | bat --color=always -l diff" | awk "{print \\$1}" | xargs -r git show'';
      lg = "lazygit";
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
}
