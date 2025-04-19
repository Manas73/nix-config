{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  atuinPerPlatform = {
    "x86_64-linux" = {
      home.packages = [ pkgs.atuin ];
    };
    "aarch64-linux" = {
      home.packages = [ pkgs.atuin ];
    };
    "x86_64-darwin" = {
      environment.systemPackages = [ pkgs.atuin ];
    };
    "aarch64-darwin" = {
      environment.systemPackages = [ pkgs.atuin ];
    };
  };

  atuinConfig = lib.attrByPath [ system ] { } atuinPerPlatform;
in {
  options.atuin.enable = lib.mkEnableOption "Enable Atuin shell history tool";

  config = lib.mkIf config.atuin.enable atuinConfig;
}