{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  firefoxPerPlatform = {
    "x86_64-linux" = {
      home.packages = [ pkgs.firefox ];
    };
    "aarch64-linux" = {
      home.packages = [ pkgs.firefox ];
    };
    "x86_64-darwin" = {
      homebrew.casks = [ "firefox" ];
    };
    "aarch64-darwin" = {
      homebrew.casks = [ "firefox" ];
    };
  };

  firefoxConfig = lib.attrByPath [ system ] { } firefoxPerPlatform;
in {
  options.firefox.enable = lib.mkEnableOption "Enable Firefox browser";

  config = lib.mkIf config.firefox.enable firefoxConfig;
}