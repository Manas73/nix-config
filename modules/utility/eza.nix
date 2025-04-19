{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  ezaPerPlatform = {
    "x86_64-linux" = {
      home.packages = [ pkgs.eza ];
    };
    "aarch64-linux" = {
      home.packages = [ pkgs.eza ];
    };
    "x86_64-darwin" = {
      environment.systemPackages = [ pkgs.eza ];
    };
    "aarch64-darwin" = {
      environment.systemPackages = [ pkgs.eza ];
    };
  };

  ezaConfig = lib.attrByPath [ system ] { } ezaPerPlatform;
in {
  options.eza.enable = lib.mkEnableOption "Enable Eza (ls replacement)";

  config = lib.mkIf config.eza.enable ezaConfig;
}