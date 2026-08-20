{
  description = "talon's NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    herdr = {
      url = "github:herdrdev/herdr/v0.8.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dotfiles = {
      url = "github:talonlikeaclaw/dotfiles";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      herdr,
      dotfiles,
      ...
    }:
    {
      nixosConfigurations = {
        # Headless Devbox
        devbox = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./devbox.nix
            home-manager.nixosModules.home-manager
            ({ pkgs, ... }:
            {
              home-manager.users.talon = import ./home/devbox.nix;
              home-manager.extraSpecialArgs = { inherit herdr dotfiles; };
              home-manager.backupCommand = pkgs.writeShellScript "home-manager-backup" ''
                target="$1"
                backup="$target.hm-bak"
                index=0

                while [ -e "$backup.$index" ]; do
                  index=$((index + 1))
                done

                mv -- "$target" "$backup.$index"
              '';
            })
          ];
        };
      };
    };
}
