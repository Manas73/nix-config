{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  yaziPerPlatform = {
    "x86_64-linux" = {
      home.packages = [ pkgs.yazi ];
    };
    "aarch64-linux" = {
      home.packages = [ pkgs.yazi ];
    };
    "x86_64-darwin" = {
      environment.systemPackages = [ pkgs.yazi ];
    };
    "aarch64-darwin" = {
      environment.systemPackages = [ pkgs.yazi ];
    };
  };

  yaziConfig = lib.attrByPath [ system ] { } yaziPerPlatform;
in {
  options.yazi.enable = lib.mkEnableOption "Enable Yazi terminal file manager";

  config = lib.mkIf config.yazi.enable yaziConfig;
}