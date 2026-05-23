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
      lg = "lazygit";
      szsh = "source ~/.zshrc";
    };

    initContent = ''
      setopt HIST_VERIFY
      eval "$(tv init zsh)"
    '';
  };
}
