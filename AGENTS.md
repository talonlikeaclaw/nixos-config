# NixOS Configuration

Flake-based NixOS config for QEMU/KVM VM on Proxmox. Home-manager as NixOS module. Remote desktop via XRDP over SSH tunnel.

## Commands

- **Apply config:** `sudo nixos-rebuild switch --flake .#vm`
- **Test without persisting:** `sudo nixos-rebuild test --flake .#vm`
- **Validate flake:** `nix flake check` — must pass before committing
- **Update all inputs:** `nix flake update`
- **Update a single input:** `nix flake lock --update-input <input>`

Run `nix flake check` after any `.nix` edit. New files need `git add` first (flakes use git index).

## Structure

- `flake.nix` — flake entrypoint; defines `vm` host
- `configuration.nix` — system-level NixOS config
- `hardware-configuration.nix` — **auto-generated, do not edit** (`nixos-generate-config` to regenerate)
- `home/default.nix` — home-manager entrypoint (user `talon`)
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
- `home/ssh.nix`, `home/starship.nix`, `home/zsh.nix` — sub-modules

## Key conventions

- Home-manager is **NixOS module** — do not run `home-manager switch`
- Flake target `.#vm` — always specify explicitly
- nixpkgs tracks `nixos-unstable`
- `nixpkgs.config.allowUnfree = true` needed in **both** `configuration.nix` and `home/default.nix` (independent package sets)
- `system.stateVersion` / `home.stateVersion` pinned — don't change unless migrating release
- `home-manager.backupFileExtension = "hm-bak"` in `flake.nix` — existing dotfiles get `.hm-bak` suffix instead of clobber error
- Programs with home-manager modules (`programs.git`, `programs.bat`, etc.) use those instead of `xdg.configFile`
- Programs without home-manager modules use `xdg.configFile` for symlink-based config management
- `hardware-configuration.nix` can be edited for deadnix fixes despite being auto-generated
- Nix lambda patterns: remove unused params (`config`, `pkgs`, etc.) — `deadnix` linting enforced
- Lazygit custom command output modes: `terminal` (works for interactive tools like convco), `popup` (breaks TTY), `log`, `logWithPty`, `none`
- Lazygit pagers config uses `pagers` array format (not `paging` object — lazygit auto-migrates and fails on read-only nix-managed configs)

## XRDP remote desktop

- Access via Remmina (any RDP client) over SSH tunnel — port 3389 **not** exposed to network
- Must log out of console session before connecting via XRDP (Proxmox noVNC/SPICE), otherwise black screen
- `security.polkit.enable = true` — helps with concurrent session authorization
- `defaultWindowManager = "startplasma-x11"` — use X11, not Wayland (XRDP Wayland support unreliable)
- `openFirewall = false` — RDP tunneled through SSH, no need to expose 3389

## Building custom packages from source

`engram` built via `pkgs.buildGoModule` + `fetchFromGitHub` in `home/default.nix`. Version bump steps:

1. Update `rev` (tag) and `hash` fields
2. Set `hash` and `vendorHash` to `""`, run `nix flake check` — Nix fails with correct hashes
3. Replace placeholder hashes with real ones
4. Update ldflags version string (`-X main.version=vX.Y.Z`) to match tag
5. `doCheck = false` intentional — sandbox has no `git` binary

## OpenCode config pattern

`home/opencode.nix` uses `xdg.configFile` for `~/.config/opencode/`:

- Config JSONs are nix-managed symlinks — **do not edit manually**
- `package.json`, `package-lock.json`, `node_modules/` stay mutable for `bun install`
- `engram.ts` sourced from `home/opencode/engram.ts`, symlinked into place
- Activation script runs `bun install` if `node_modules/` missing
- Add MCP servers/config in `builtins.toJSON` blocks in `home/opencode.nix`
- Docker SSE gateway (`docker/mcp-gateway`) has session init race conditions — context7 + time moved to local stdio (`npx` commands)
- Weather + dockerhub MCPs use different transports, work fine as-is
- Zed extensions via `auto_install_extensions` in settings.json — auto-installs on launch