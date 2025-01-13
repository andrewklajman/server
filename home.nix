{ config, pkgs, ... }:

{
  home = {
    username = "andrew";
    homeDirectory = "/home/andrew";
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  # home.packages = with pkgs; [ ];

  programs.git = {
    enable = true;
    userName = "andrew";
    userEmail = "andrew.klajman@gmail.com";
  };

  programs.starship.enable = false;

  programs.bash = {
    enable = true;
    enableCompletion = true;

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

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
