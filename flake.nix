{
  description = "talon's NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      vm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	modules = [
	  ./configuration.nix
	  home-manager.nixosModules.home-manager
	  {
	    home-manager.users.talon = import ./home/default.nix;
	    home-manager.backupFileExtension = "hm-bak";
	  }
	];
      };
    };
  };
}
