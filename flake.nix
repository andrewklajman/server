{
  description = "System Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    agenix.url = "github:ryantm/agenix";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, agenix, home-manager, ... }@inputs: {
    nixosConfigurations.lenovo = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit agenix home-manager ;  };
      modules = [
        ./hosts/lenovo/configuration.nix
        ./modules
        ({ config, ... }: { rustDev.enable = true; })
      ];
    };

    nixosConfigurations.pc = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit agenix home-manager; };
      modules = [
        ./hosts/pc/configuration.nix
    	  ./modules
      ];
    };

    nixosConfigurations.server = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit agenix home-manager;  };
      modules = [ 
        ./hosts/server/configuration.nix
	      ./modules
      ];
    };
  };

}
