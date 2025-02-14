{ config, pkgs, agenix, home-manager, nixvim, ... }:

{
  imports = [ 
    agenix.nixosModules.default 
    home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {inherit nixvim;};
        home-manager.users.andrew = import ./home-manager.andrew.nix;
    }
  ];

# --------------------------------------------------------------------- #
# ---- Global Configuration ------------------------------------------- #
# --------------------------------------------------------------------- #

#  # Enable the X11 windowing system.
#  services.xserver.enable = true;
#  # Enable the GNOME Desktop Environment.
#  services.xserver.displayManager.gdm.enable = true;
#  services.xserver.desktopManager.gnome.enable = true;

  dwm.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Reducing disk space usage
      boot.loader.systemd-boot.configurationLimit = 10;
      nix.settings.auto-optimise-store = true;
      nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 1w";
      };

  programs.tmux = {
    enable = true;
    shortcut = "a";
    keyMode = "vi";
    customPaneNavigationAndResize = true;
  };

  networking.networkmanager.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [ 
    alsa-utils
    autorandr
    btop
    firefox ungoogled-chromium
    git
    ledger
    mpv
    oxker
    qbittorrent
    ranger
    yt-dlp
  ];

  environment = {
    sessionVariables = {
      PROMPT = "%n@%m %~> ";
      EDITOR = "nvim";
    };
  };

  documentation = {
    enable = true;
    man.enable = true;
    dev.enable = true;
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-qt;
  };

# --------------------------------------------------------------------- #
# ---- zsh ------------------------------------------------------------ #
# --------------------------------------------------------------------- #
    users.defaultUserShell = pkgs.zsh;

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autosuggestions.enable = true;
      interactiveShellInit = '' bindkey '^ ' autosuggest-accept '';

      promptInit = ''
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' max-errors 1
autoload -Uz compinit
compinit
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
bindkey -v
bindkey '^ ' autosuggest-accept
      '';

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
      };
    };
}
