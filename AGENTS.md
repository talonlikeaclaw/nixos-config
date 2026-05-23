# NixOS Configuration

Flake-based NixOS config targeting a QEMU/KVM virtual machine with home-manager integrated as a NixOS module.

## Commands

- **Apply config:** `sudo nixos-rebuild switch --flake .#vm`
- **Test without persisting:** `sudo nixos-rebuild test --flake .#vm`
- **Validate flake:** `nix flake check`
- **Update all inputs:** `nix flake update`
- **Update a single input:** `nix flake lock --update-input <input>`

## Structure

- `flake.nix` — flake entrypoint; defines the `vm` host
- `configuration.nix` — system-level NixOS config
- `hardware-configuration.nix` — **auto-generated, do not edit manually** (regenerate with `nixos-generate-config` if needed)
- `home/default.nix` — home-manager entrypoint for user `talon`
- `home/ssh.nix`, `home/zsh.nix` — home-manager sub-modules

## Key conventions

- Home-manager is used as a **NixOS module** (`home-manager.nixosModules.home-manager`), not standalone. Do not run `home-manager switch`.
- The flake output target is `.#vm` — always specify it explicitly.
- nixpkgs tracks `nixos-unstable`.
- `programs.git.settings` is used (not `userName`/`userEmail`) because of home-manager's newer module API.