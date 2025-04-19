{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  chezmoiPerPlatform = {
    "x86_64-linux" = {
      home.packages = [ pkgs.chezmoi ];
    };
    "aarch64-linux" = {
      home.packages = [ pkgs.chezmoi ];
    };
    "x86_64-darwin" = {
      environment.systemPackages = [ pkgs.chezmoi ];
    };
    "aarch64-darwin" = {
      environment.systemPackages = [ pkgs.chezmoi ];
    };
  };

  chezmoiConfig = lib.attrByPath [ system ] { } chezmoiPerPlatform;
in {
  options.chezmoi.enable = lib.mkEnableOption "Enable Chezmoi dotfile manager";

  config = lib.mkIf config.chezmoi.enable chezmoiConfig;
}