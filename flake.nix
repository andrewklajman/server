{
  description = "System Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.lenovo = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/lenovo/configuration.nix
        ./modules
        ( { config, ... }: { 
            desktop-manager           = "dwm";
            doas.enable               = true;
            docker.enable             = false;
            gnupg.enable              = true;
            mullvad = { 
              enable = true; 
              mullvadSettingsDir = "/home/andrew/Documents/notes/MULLVAD_SETTINGS_DIR";
            };
            systemd-journal.enable    = false;
            systemd-recur-task.enable = false;
            tmux.enable               = false;
            virt-manager.enable       = false;
            zsh.enable                = true;
          })
      ];
    };

    nixosConfigurations.pc = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
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

  };
}
