{ pkgs, lib, config, system_settings, ... }: {

    options = {
        vivaldi.enable = lib.mkEnableOption "enables vivaldi";
    };

    config = lib.mkIf config.vivaldi.enable {
         homebrew.casks = [ "vivaldi" ];
    };
}