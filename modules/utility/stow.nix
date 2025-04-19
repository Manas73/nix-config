{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  stowPerPlatform = {
    "x86_64-linux" = {
      home.packages = [ pkgs.stow ];
    };
    "aarch64-linux" = {
      home.packages = [ pkgs.stow ];
    };
    "x86_64-darwin" = {
      environment.systemPackages = [ pkgs.stow ];
    };
    "aarch64-darwin" = {
      environment.systemPackages = [ pkgs.stow ];
    };
  };

  stowConfig = lib.attrByPath [ system ] { } stowPerPlatform;
in {
  options.stow.enable = lib.mkEnableOption "Enable GNU Stow symlink manager";

  config = lib.mkIf config.stow.enable stowConfig;
}