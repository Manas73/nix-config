{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  pyenvPerPlatform = {
    "x86_64-linux" = {
      home.packages = [ pkgs.pyenv ];
    };
    "aarch64-linux" = {
      home.packages = [ pkgs.pyenv ];
    };
    "x86_64-darwin" = {
      environment.systemPackages = [ pkgs.pyenv ];
    };
    "aarch64-darwin" = {
      environment.systemPackages = [ pkgs.pyenv ];
    };
  };

  pyenvConfig = lib.attrByPath [ system ] { } pyenvPerPlatform;
in {
  options.pyenv.enable = lib.mkEnableOption "Enable Pyenv Python version manager";

  config = lib.mkIf config.pyenv.enable pyenvConfig;
}