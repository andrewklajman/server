{
  description = "System Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    agenix.url = "github:ryantm/agenix";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
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
