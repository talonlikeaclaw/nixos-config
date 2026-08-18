# NixOS Configuration

Single-host NixOS and Home Manager configuration for `devbox`.

## Shared Configuration

Portable user configuration lives in [dotfiles](https://github.com/talonlikeaclaw/dotfiles) and is a locked flake input. Nix installs packages and owns devbox-specific configuration; it links the shared configuration for Neovim, Fastfetch, Television, Herdr, Starship, Gitmux, and Oh My Pi.

Change shared settings in the dotfiles repository, commit them, then update this repository's pinned revision:

```sh
nix flake update dotfiles
nh os switch . -H devbox
```

Tmux, Zsh, and OpenCode remain Nix-managed because their devbox configurations differ from the portable versions.

## Commands

```sh
nix flake check
nh os test . -H devbox
nh os switch . -H devbox
```
