{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  vivaldiPerPlatform = {
    "x86_64-linux" = {
      home.packages = [
        (pkgs.vivaldi.override {
          proprietaryCodecs = true;
          enableWidevine = true;
        })
      ];
    };
    "aarch64-linux" = {
      home.packages = [
        (pkgs.vivaldi.override {
          proprietaryCodecs = true;
          enableWidevine = true;
        })
      ];
    };
    "x86_64-darwin" = {
      homebrew.casks = [ "vivaldi" ];
    };
    "aarch64-darwin" = {
      homebrew.casks = [ "vivaldi" ];
    };
  };

  vivaldiConfig = lib.attrByPath [ system ] { } vivaldiPerPlatform;
in {
  options.vivaldi.enable = lib.mkEnableOption "Enable Vivaldi browser";

  config = lib.mkIf config.vivaldi.enable vivaldiConfig;
}