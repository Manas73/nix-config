{ pkgs, pkgs-unstable, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  ramboxPerPlatform = {
    "x86_64-linux" = {
      home.packages = [ pkgs-unstable.rambox ];
    };
    "aarch64-linux" = {
      home.packages = [ pkgs-unstable.rambox ];
    };
    "x86_64-darwin" = {
      homebrew.casks = [ "rambox" ];
    };
    "aarch64-darwin" = {
      homebrew.casks = [ "rambox" ];
    };
  };

  ramboxConfig = lib.attrByPath [ system ] { } ramboxPerPlatform;
in {
  options.rambox.enable = lib.mkEnableOption "Enable Rambox";

  config = lib.mkIf config.rambox.enable ramboxConfig;
}