{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    agenix.url = "github:ryantm/agenix";
  };

  outputs = { self, nixpkgs, agenix, ... }@inputs: {
    nixosConfigurations.server = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ 
        agenix.nixosModules.default
        ./configuration.nix 
	./modules
      ];
    };
  };

}
