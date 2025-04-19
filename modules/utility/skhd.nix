{ pkgs, lib, config, user_settings, system_settings, ... }:

let
  system = system_settings.system;

  # Define config for each platform
  skhdPerPlatform = {
    # skhd is only available on macOS, so Linux platforms have empty configs
    "x86_64-linux" = { };
    "aarch64-linux" = { };
    "x86_64-darwin" = {
      environment.systemPackages = [ pkgs.skhd ];
      services.skhd.enable = true;
    };
    "aarch64-darwin" = {
      environment.systemPackages = [ pkgs.skhd ];
      services.skhd.enable = true;
    };
  };

  skhdConfig = lib.attrByPath [ system ] { } skhdPerPlatform;
in {
  options.skhd.enable = lib.mkEnableOption "Enable skhd hotkey daemon";

  config = lib.mkIf config.skhd.enable skhdConfig;
}