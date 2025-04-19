{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  _1passwordPerPlatform = {
    "x86_64-linux" = {
      home.packages = [ pkgs._1password pkgs._1password-gui ];
    };
    "aarch64-linux" = {
      home.packages = [ pkgs._1password pkgs._1password-gui ];
    };
    "x86_64-darwin" = {
      homebrew.casks = [ "1password" ];
    };
    "aarch64-darwin" = {
      homebrew.casks = [ "1password" ];
    };
  };

  _1passwordConfig = lib.attrByPath [ system ] { } _1passwordPerPlatform;
in {
  options._1password.enable = lib.mkEnableOption "Enable 1Password";

  config = lib.mkIf config._1password.enable _1passwordConfig;
}