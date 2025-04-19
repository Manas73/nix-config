{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  libreofficePerPlatform = {
    "x86_64-linux" = {
      home.packages = [ pkgs.libreoffice-still ];
    };
    "aarch64-linux" = {
      home.packages = [ pkgs.libreoffice-still ];
    };
    "x86_64-darwin" = {
      homebrew.casks = [ "libreoffice" ];
    };
    "aarch64-darwin" = {
      homebrew.casks = [ "libreoffice" ];
    };
  };

  libreofficeConfig = lib.attrByPath [ system ] { } libreofficePerPlatform;
in {
  options.libreoffice.enable = lib.mkEnableOption "Enable LibreOffice";

  config = lib.mkIf config.libreoffice.enable libreofficeConfig;
}