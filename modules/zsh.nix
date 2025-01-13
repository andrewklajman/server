{ config, lib, pkgs, ... }:

{
  options.zsh.enable = lib.mkEnableOption "zsh";

  config = lib.mkIf config.zsh.enable {
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

        ssmc = "ss mullvad-conf.service";
        jmc = "j mullvad-conf.service";
      };
    };
  };
}
