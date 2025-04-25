{ config, pkgs, agenix, home-manager, nixvim, ... }:

let 
  twe = pkgs.writeShellScriptBin "twe" '' task_id=$(task add "$@" project:health.exercise | cut -d' ' -f3 | cut -d'.' -f1); task $task_id done '';
  twl = pkgs.writeShellScriptBin "twl" '' task_id=$(task add "$@" project:health.log | cut -d' ' -f3 | cut -d'.' -f1); task $task_id done '';
  twd = pkgs.writeShellScriptBin "twd" '' task_id=$(task add "$@" project:health.diet | cut -d' ' -f3 | cut -d'.' -f1); task $task_id done '';
  twdps = pkgs.writeShellScriptBin "twdps" '' task_id=$(twd "240 Protein Shake" project:health.diet | cut -d' ' -f3 | cut -d'.' -f1); task $task_id done ''; 
  twdpos = pkgs.writeShellScriptBin "twdpos" '' task_id=$(twd "500 Protein Olive Oil Shake" project:health.diet | cut -d' ' -f3 | cut -d'.' -f1); task $task_id done ''; 
  twdpms = pkgs.writeShellScriptBin "twdpms" '' task_id=$(twd "300 Protein Morning Shake" project:health.diet | cut -d' ' -f3 | cut -d'.' -f1); task $task_id done ''; 
  twdc = pkgs.writeShellScriptBin "twdc" '' task_id=$(twd "0 Black coffee" project:health.diet | cut -d' ' -f3 | cut -d'.' -f1); task $task_id done ''; 
  twdy = pkgs.writeShellScriptBin "twdy" '' task_id=$(twd "50 Yakult lite" project:health.diet | cut -d' ' -f3 | cut -d'.' -f1); task $task_id done ''; 
  twdk = pkgs.writeShellScriptBin "twdk" '' task_id=$(twd "0 Kombucha" project:health.diet | cut -d' ' -f3 | cut -d'.' -f1); task $task_id done ''; 
  twda = pkgs.writeShellScriptBin "twda" '' task_id=$(twd "50 Apple" project:health.diet | cut -d' ' -f3 | cut -d'.' -f1); task $task_id done ''; 
  twdw = pkgs.writeShellScriptBin "twdw" '' task_id=$(twd "0 Water" project:health.diet | cut -d' ' -f3 | cut -d'.' -f1); task $task_id done ''; 

  journal = pkgs.writeShellScriptBin "journal" '' 
  python3 /home/andrew/Documents/notes/scripts/generate_journal.py >> /home/andrew/Documents/journal.md
  ''; 
in
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

  dwm.enable = true;
  mullvad.enable = true;
  systemd-journal.enable = true;
  networking.enableIPv6 = false;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  time.timeZone = "Australia/Sydney";

  security.sudo = {
    enable = true;
    extraRules = [{
      groups = [ "wheel" ];
      commands = [
        {
          command = "${pkgs.nixos-rebuild}/bin/nixos-rebuild";
          options = [ "NOPASSWD" ];
        }
      ];
    }];
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
    (pkgs.python3.withPackages (python-pkgs: with python-pkgs; [
      beautifulsoup4
      jupyter-all
      matplotlib
      pandas
      pygame
      requests
      selenium
    ]))
    chromedriver

    alsa-utils
    arandr autorandr
    btop
    firefox ungoogled-chromium
    fzf
    git
    journal
    ledger
    mpv
    ncdu
    nixos-rebuild
    oxker
    qbittorrent
    ranger
    taskwarrior3 
      twd twda twdc twdk twdps twdpms twdpos twdw twdy 
      twe twl
    yt-dlp

    vimPlugins.vimwiki
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
        led = "ledger -f main.txt --strict --pedantic --price-db prices.db --exchange $ --no-total";
        llol = "ls -1 --group-directories-first";
        ll = "ls -l --group-directories-first";
        lla = "ls -al --group-directories-first";
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
