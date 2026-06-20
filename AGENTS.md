# NixOS Configuration

Dual-host flake config: GUI VM (`vm`) and headless devbox (`devbox`) on Proxmox. Home-manager as NixOS module.

## Commands

- **Apply config (VM):** `sudo nixos-rebuild switch --flake .#vm`
- **Apply config (devbox):** `sudo nixos-rebuild switch --flake .#devbox`
- **Test without persisting:** `sudo nixos-rebuild test --flake .#<host>`
- **Validate flake:** `nix flake check` — must pass before committing
- **Update all inputs:** `nix flake update`
- **Update a single input:** `nix flake lock --update-input <input>`
- **Sync engram:** `engram sync --project nixos-config && git add .engram/`

Run `nix flake check` after any `.nix` edit. New files need `git add` first (flakes use git index).

## Workflow

1. **Search engram** before editing nix files — past bugfixes, decisions, discoveries live there
2. **Edit** nix files as needed
3. **Validate** with `nix flake check`
4. **Apply** with `sudo nixos-rebuild switch --flake .#vm`
5. **Save memory** (`mem_save`) for any bugfix, decision, discovery, or pattern change
6. **Sync engram** after saving memories

## Engram

Search engram **before** editing nix files. Key searchable topics: lazygit pagers/output modes, XRDP black screen, MCP SSE race conditions, engram version bumps, catppuccin theming, neovim vim.pack, openCode config pattern, custom package builds, plasma-manager KDE config.

`engram sync --import` merges `.engram/` chunks into local DB. `engram export` / `engram import` for full JSON backup/merge across machines.

## Structure

- `flake.nix` — flake entrypoint; defines `vm` and `devbox` hosts
- `configuration.nix` — system-level NixOS config (GUI VM)
- `hardware-configuration.nix` — **auto-generated, do not edit** (`nixos-generate-config` to regenerate)
- `devbox.nix` — system-level config for headless devbox
- `devbox-hardware.nix` — **auto-generated, do not edit** (devbox hardware)
- `home/default.nix` — home-manager entrypoint for GUI VM (user `talon`)
- `home/devbox.nix` — home-manager entrypoint for devbox (user `talon`)
- `home/opencode.nix` — opencode config (providers, MCP, engram, tui plugins)
- `home/opencode/engram.ts` — engram plugin source (symlinked to `~/.config/opencode/plugins/`)
- `home/wezterm.nix` — wezterm config (xdg symlinks to lua files)
- `home/wezterm/wezterm.lua` — main wezterm config (leader keys, colors, keybindings)
- `home/wezterm/sessions/mainframe.lua` — wezterm session spawn function
- `home/fastfetch.nix` — fastfetch config (xdg symlinks to JSONC + ASCII art)
- `home/fastfetch/eagle.txt` — fastfetch logo file
- `home/fastfetch/config.jsonc` — fastfetch module config
- `home/television.nix` — television config (xdg symlinks to TOML files)
- `home/television/config.toml` — main tv config
- `home/television/cable/` — custom cable channels (override built-ins by name)
- `home/zed.nix` — zed editor config (xdg symlinks, font, env var)
- `home/zed/settings.json` — zed settings (theme, extensions, keybindings)
- `home/zed/keymap.json` — zed vim keybindings
- `home/zed/tasks.json` — zed task definitions
- `home/lazygit.nix` — lazygit config (Catppuccin Mocha theme, delta pager, convco custom command)
- `home/kde.nix` — KDE Plasma config (plasma-manager: dark theme, panel, pinned task manager apps)
- `home/ssh.nix`, `home/starship.nix`, `home/zsh.nix` — sub-modules

## Key conventions

- Home-manager is **NixOS module** — do not run `home-manager switch`
- Flake targets: `.#vm` or `.#devbox` — always specify explicitly
- nixpkgs tracks `nixos-unstable`
- `nixpkgs.config.allowUnfree = true` needed in **all 4 files**: `configuration.nix`, `devbox.nix`, `home/default.nix`, `home/devbox.nix` (independent package sets)
- `system.stateVersion` / `home.stateVersion` pinned — don't change unless migrating release
- `home-manager.backupFileExtension = "hm-bak"` in `flake.nix` — existing dotfiles get `.hm-bak` suffix instead of clobber error
- Programs with home-manager modules (`programs.git`, `programs.bat`, etc.) use those instead of `xdg.configFile`
- Programs without home-manager modules use `xdg.configFile` for symlink-based config management
- `hardware-configuration.nix` can be edited for deadnix fixes despite being auto-generated
- Nix lambda patterns: remove unused params (`config`, `pkgs`, etc.) — `deadnix` linting enforced
- plasma-manager module: use `homeModules.plasma-manager` (not `homeManagerModules` — was renamed)
- Desktop file names: use exact filenames from `/nix/store/.../share/applications/` (e.g. `systemsettings.desktop`, not `org.kde.systemsettings.desktop`)