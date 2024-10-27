{ pkgs, lib, config, system_settings, ... }: {

    options = {
        firefox.enable = lib.mkEnableOption "enables firefox";
    };

    config = lib.mkIf config.firefox.enable {
        homebrew.casks = [ "firefox" ];
    };
}