{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

#  services.qemuGuest.enable = true;
#  services.spice-vdagentd.enable = true;

  environment.systemPackages = with pkgs; [ 
    neovim 
    git
    spice-vdagent 
    oxker
    ranger
    firefox
    btop
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
      nr = "nixos-rebuild switch --flake ./#pc";
      nrr = "nixos-rebuild switch --flake ./#pc && reboot";
      ts = "tailscale status";
      ms = "mullvad status";
      mc = "mullvad connect";
      md = "mullvad disconnect";
      ssh = "ssh andrew@lenovo";
      ss = "systemctl status";
      sr = "systemctl restart";
      j = "journalctl -xeu";

      ssmc = "ss mullvad-conf.service";
      jmc = "j mullvad-conf.service";
    };
  };
}
