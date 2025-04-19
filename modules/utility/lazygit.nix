{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  lazygitPerPlatform = {
    "x86_64-linux" = {
      home.packages = [ pkgs.lazygit ];
    };
    "aarch64-linux" = {
      home.packages = [ pkgs.lazygit ];
    };
    "x86_64-darwin" = {
      environment.systemPackages = [ pkgs.lazygit ];
    };
    "aarch64-darwin" = {
      environment.systemPackages = [ pkgs.lazygit ];
    };
  };

  lazygitConfig = lib.attrByPath [ system ] { } lazygitPerPlatform;
in {
  options.lazygit.enable = lib.mkEnableOption "Enable Lazygit git TUI";

  config = lib.mkIf config.lazygit.enable lazygitConfig;
}