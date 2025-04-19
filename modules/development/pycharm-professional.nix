{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  pycharmProfessionalPerPlatform = {
    "x86_64-linux" = {
      home.packages = [ pkgs.jetbrains.pycharm-professional ];
    };
    "aarch64-linux" = {
      home.packages = [ pkgs.jetbrains.pycharm-professional ];
    };
    "x86_64-darwin" = {
      homebrew.casks = [ "pycharm" ];
    };
    "aarch64-darwin" = {
      homebrew.casks = [ "pycharm" ];
    };
  };

  pycharmProfessionalConfig = lib.attrByPath [ system ] { } pycharmProfessionalPerPlatform;
in {
  options.pycharm-professional.enable = lib.mkEnableOption "Enable PyCharm Professional";

  config = lib.mkIf config.pycharm-professional.enable pycharmProfessionalConfig;
}