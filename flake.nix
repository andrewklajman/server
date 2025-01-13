# TODO: Implement proper flake
# TODO: DNS Server
# TODO: zsh module
# TDOD: tor module

# TODO: Instagram type server
# TODO: Link to cloudflare

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
    nixosConfigurations.pc = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit agenix home-manager;  };
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

        {
          audiobookshelf.enable = true;
          metube.enable = true;
          microsocks.enable = true;
          mullvad.enable = true;
          password-manager.enable = true;
          qbittorrent-nox.enable = true;
          tailscale.enable = true;

          virtualisation.oci-containers.backend = "docker"; # Podman: localhost:XXXX works; nixos:XXXX fails
        }
      ];
    };
  };

}
