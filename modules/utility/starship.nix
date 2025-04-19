{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  starshipPerPlatform = {
    "x86_64-linux" = {
      home.packages = [ pkgs.starship ];
    };
    "aarch64-linux" = {
      home.packages = [ pkgs.starship ];
    };
    "x86_64-darwin" = {
      environment.systemPackages = [ pkgs.starship ];
    };
    "aarch64-darwin" = {
      environment.systemPackages = [ pkgs.starship ];
    };
  };

  starshipConfig = lib.attrByPath [ system ] { } starshipPerPlatform;
in {
  options.starship.enable = lib.mkEnableOption "Enable Starship prompt";

  config = lib.mkIf config.starship.enable starshipConfig;
}