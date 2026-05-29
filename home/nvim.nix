{ pkgs, ... }:

let
  nvimSrc = ./nvim;
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    withRuby = false;
    withPython3 = false;
  };

  xdg.configFile = {
    "nvim/init.lua".source = "${nvimSrc}/init.lua";
    "nvim/lua".source = "${nvimSrc}/lua";
    "nvim/lsp".source = "${nvimSrc}/lsp";
    "nvim/indent".source = "${nvimSrc}/indent";
  };

  home.activation.setupNvimPackLock = ''
    LOCKFILE="$HOME/.config/nvim/nvim-pack-lock.json"
    if [ ! -f "$LOCKFILE" ]; then
      cp ${nvimSrc}/nvim-pack-lock.json "$LOCKFILE"
    fi
  '';

  home.packages = with pkgs; [
    # LSP servers
    lua-language-server
    rust-analyzer
    gopls
    python3Packages.python-lsp-server
    sqls
    docker-language-server
    yaml-language-server
    vscode-langservers-extracted
    taplo
    bash-language-server
    vim-language-server
    typescript-language-server
    marksman
    harper
    emmet-ls

    nil
    nixfmt
    statix
    deadnix

    # Formatters
    stylua
    ruff
    prettier
    shfmt
    tree-sitter
  ];
}