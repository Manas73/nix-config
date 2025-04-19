{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  onlyofficePerPlatform = {
    "x86_64-linux" = {
      home.packages = [ pkgs.onlyoffice-bin_latest ];
    };
    "aarch64-linux" = {
      home.packages = [ pkgs.onlyoffice-bin_latest ];
    };
    "x86_64-darwin" = {
      homebrew.casks = [ "onlyoffice" ];
    };
    "aarch64-darwin" = {
      homebrew.casks = [ "onlyoffice" ];
    };
  };

  onlyofficeConfig = lib.attrByPath [ system ] { } onlyofficePerPlatform;
in {
  options.onlyoffice.enable = lib.mkEnableOption "Enable OnlyOffice";

  config = lib.mkIf config.onlyoffice.enable onlyofficeConfig;
}