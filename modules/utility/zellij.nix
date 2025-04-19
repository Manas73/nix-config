{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  zellijPerPlatform = {
    "x86_64-linux" = {
      home.packages = [ pkgs.zellij ];
    };
    "aarch64-linux" = {
      home.packages = [ pkgs.zellij ];
    };
    "x86_64-darwin" = {
      environment.systemPackages = [ pkgs.zellij ];
    };
    "aarch64-darwin" = {
      environment.systemPackages = [ pkgs.zellij ];
    };
  };

  zellijConfig = lib.attrByPath [ system ] { } zellijPerPlatform;
in {
  options.zellij.enable = lib.mkEnableOption "Enable Zellij terminal multiplexer";

  config = lib.mkIf config.zellij.enable zellijConfig;
}