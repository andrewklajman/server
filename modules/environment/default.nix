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
      PROMPT = "%n@%m %~> ";
      EDITOR = "nvim";
    };

  };
}
