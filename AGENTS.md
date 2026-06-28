# NixOS Configuration

Single-host flake config: headless devbox (`devbox`) on Proxmox. Home-manager as NixOS module.

## Commands

- **Apply config (devbox):** `nh os switch . -H devbox`
- **Test without persisting:** `nh os test . -H <host>`
- **Validate flake:** `nix flake check` — must pass before committing
- **Update all inputs:** `nix flake update`
- **Update a single input:** `nix flake lock --update-input <input>`
- **Sync engram:** `engram sync --project nixos-config && git add .engram/`

Run `nix flake check` after any `.nix` edit. New files need `git add` first (flakes use git index).

## Workflow

1. **Search engram** before editing nix files — past bugfixes, decisions, discoveries live there
2. **Edit** nix files as needed
3. **Validate** with `nix flake check`
4. **Apply** with `nh os switch . -H devbox`
5. **Save memory** (`mem_save`) for any bugfix, decision, discovery, or pattern change
6. **Sync engram** after saving memories

## Engram

Search engram **before** editing nix files. Key searchable topics: lazygit pagers/output modes, MCP SSE race conditions, engram version bumps, catppuccin theming, neovim vim.pack, openCode config pattern, custom package builds.

`engram sync --import` merges `.engram/` chunks into local DB. `engram export` / `engram import` for full JSON backup/merge across machines.

## Structure

- `flake.nix` — flake entrypoint; defines `devbox` host
- `devbox.nix` — system-level config for headless devbox
- `devbox-hardware.nix` — **auto-generated, do not edit** (devbox hardware)
- `home/devbox.nix` — home-manager entrypoint for devbox (user `talon`)
- `home/opencode.nix` — opencode config (providers, MCP, engram, tui plugins)
- `home/opencode/engram.ts` — engram plugin source (symlinked to `~/.config/opencode/plugins/`)
- `home/fastfetch.nix` — fastfetch config (xdg symlinks to JSONC + ASCII art)
- `home/fastfetch/eagle.txt` — fastfetch logo file
- `home/fastfetch/config.jsonc` — fastfetch module config
- `home/television.nix` — television config (xdg symlinks to TOML files)
- `home/television/config.toml` — main tv config
- `home/television/cable/` — custom cable channels (override built-ins by name)
- `home/tmux.nix` — tmux config (xdg symlinks to tmux.conf + gitmux.toml)
- `home/lazygit.nix` — lazygit config (Catppuccin Mocha theme, delta pager, convco custom command)
- `home/ssh.nix`, `home/starship.nix`, `home/zsh.nix` — sub-modules

## Key conventions

- Home-manager is **NixOS module** — do not run `home-manager switch`
- Flake targets: `.#devbox` — always specify explicitly
- nixpkgs tracks `nixos-unstable`
- `nixpkgs.config.allowUnfree = true` needed in **both files**: `devbox.nix`, `home/devbox.nix` (independent package sets)
- `system.stateVersion` / `home.stateVersion` pinned — don't change unless migrating release
- `home-manager.backupFileExtension = "hm-bak"` in `flake.nix` — existing dotfiles get `.hm-bak` suffix instead of clobber error
- Programs with home-manager modules (`programs.git`, `programs.bat`, etc.) use those instead of `xdg.configFile`
- Programs without home-manager modules use `xdg.configFile` for symlink-based config management
- Nix lambda patterns: remove unused params (`config`, `pkgs`, etc.) — `deadnix` linting enforced