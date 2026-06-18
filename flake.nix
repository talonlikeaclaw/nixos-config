{
  description = "talon's NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { nixpkgs, home-manager, plasma-manager, ... }: {
    nixosConfigurations = {
      # GUI VM
      vm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	modules = [
	  ./configuration.nix
	  home-manager.nixosModules.home-manager
	  {
	    home-manager.users.talon = import ./home/default.nix;
	    home-manager.backupFileExtension = "hm-bak";
	    home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ];
	  }
	];
      };

      # Headless Devbox
      devbox = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	modules = [
	  ./devbox.nix
	  ./devbox-hardware.nix
	  home-manager.nixosModules.home-manager
	  {
	    home-manager.users.talon = import ./home/devbox.nix;
	    home-manager.backupFileExtension = "hm-bak";
	  }
	];
      };
    };
  };
}
