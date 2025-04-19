{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  ghqPerPlatform = {
    "x86_64-linux" = {
      home.packages = [ pkgs.ghq ];
    };
    "aarch64-linux" = {
      home.packages = [ pkgs.ghq ];
    };
    "x86_64-darwin" = {
      environment.systemPackages = [ pkgs.ghq ];
    };
    "aarch64-darwin" = {
      environment.systemPackages = [ pkgs.ghq ];
    };
  };

  ghqConfig = lib.attrByPath [ system ] { } ghqPerPlatform;
in {
  options.ghq.enable = lib.mkEnableOption "Enable ghq repository manager";

  config = lib.mkIf config.ghq.enable ghqConfig;
}