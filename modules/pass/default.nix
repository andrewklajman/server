{ config, pkgs, lib, ... }:

let 
  passmenulogin = pkgs.writeShellScriptBin "passmenulogin" '' ${builtins.readFile ./passmenulogin} '';
in
{
  options.pass.enable = lib.mkEnableOption "pass";
  config = lib.mkIf config.pass.enable {
    environment.systemPackages = with pkgs; [ pass passmenulogin ];
  };
}

