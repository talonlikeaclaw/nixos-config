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
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      herdr,
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
            {
              home-manager.users.talon = import ./home/devbox.nix;
              home-manager.extraSpecialArgs = { inherit herdr; };
              home-manager.backupFileExtension = "hm-bak";
            }
          ];
        };
      };
    };
}
