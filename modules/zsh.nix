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
    };
    
  };
}
