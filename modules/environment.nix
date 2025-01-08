{ config, pkgs, ... }:

{

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [ 
    neovim 
    git
    spice-vdagent 
  ];

  environment = {
    sessionVariables = {
      EDITOR = "nvim";
    };

    shellAliases = {
      ll = "ls -l";
      lla = "ls -al";
      vi = "nvim";
      vim = "nvim";
      nr = "nixos-rebuild switch --flake /etc/nixos/#server";
      nrr = "nixos-rebuild switch --flake /etc/nixos/#server && reboot";
      ts = "tailscale status";
      ms = "mullvad status";
      mc = "mullvad connect";
      md = "mullvad disconnect";
      ssh = "ssh andrew@lenovo";
      ss = "systemctl status";
      sr = "systemctl restart";
      j = "journalctl -xeu";
    };
  };

}
