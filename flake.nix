{
  description = "System Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    agenix.url = "github:ryantm/agenix";
  };

  outputs = { self, nixpkgs, agenix, ... }@inputs: {
    nixosConfigurations.lenovo = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit agenix; };
      modules = [
        ./hosts/lenovo/configuration.nix
        ./modules
        ( { config, ... }: { 
            dwm.enable                = true;
            doas.enable               = true;
            docker.enable             = true;
            gnupg.enable              = true;
            mullvad.enable            = true;
            systemd-journal.enable    = true;
            systemd-recur-task.enable = true;
            tmux.enable               = false;
            virt-manager.enable       = true;
            zsh.enable                = true;
          })
      ];
    };

    nixosConfigurations.pc = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit agenix; };
      modules = [
        ./hosts/pc/configuration.nix
    	  ./modules
        ( { config, ... }: { 
            dwm.enable                = true;
            doas.enable               = true;
            docker.enable             = false;
            gnupg.enable              = true;
            mullvad.enable            = false;
            systemd-journal.enable    = false;
            systemd-recur-task.enable = false;
            tmux.enable               = false;
            virt-manager.enable       = true;
            zsh.enable                = true;
          })
      ];
    };

    nixosConfigurations.server = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit agenix; };
      modules = [ 
        ./hosts/server/configuration.nix
	      ./modules
      ];
    };
  };

}
