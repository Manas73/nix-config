{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  btopPerPlatform = {
    "x86_64-linux" = {
      home.packages = [ pkgs.btop ];
    };
    "aarch64-linux" = {
      home.packages = [ pkgs.btop ];
    };
    "x86_64-darwin" = {
      environment.systemPackages = [ pkgs.btop ];
    };
    "aarch64-darwin" = {
      environment.systemPackages = [ pkgs.btop ];
    };
  };

  btopConfig = lib.attrByPath [ system ] { } btopPerPlatform;
in {
  options.btop.enable = lib.mkEnableOption "Enable btop system monitor";

  config = lib.mkIf config.btop.enable btopConfig;
}