{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  psmiscPerPlatform = {
    "x86_64-linux" = {
      home.packages = [ pkgs.psmisc ];
    };
    "aarch64-linux" = {
      home.packages = [ pkgs.psmisc ];
    };
    # psmisc is only available on Linux, so macOS platforms have empty configs
    "x86_64-darwin" = { };
    "aarch64-darwin" = { };
  };

  psmiscConfig = lib.attrByPath [ system ] { } psmiscPerPlatform;
in {
  options.psmisc.enable = lib.mkEnableOption "Enable psmisc utilities (fuser, killall, etc.)";

  config = lib.mkIf config.psmisc.enable psmiscConfig;
}