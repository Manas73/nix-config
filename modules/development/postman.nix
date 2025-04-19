{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  postmanPerPlatform = {
    "x86_64-linux" = {
      home.packages = [ pkgs.postman ];
    };
    "aarch64-linux" = {
      home.packages = [ pkgs.postman ];
    };
    "x86_64-darwin" = {
      homebrew.casks = [ "postman" ];
    };
    "aarch64-darwin" = {
      homebrew.casks = [ "postman" ];
    };
  };

  postmanConfig = lib.attrByPath [ system ] { } postmanPerPlatform;
in {
  options.postman.enable = lib.mkEnableOption "Enable Postman";

  config = lib.mkIf config.postman.enable postmanConfig;
}