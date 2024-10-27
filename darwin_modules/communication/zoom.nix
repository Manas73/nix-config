{ pkgs, lib, config, system_settings, ... }: {

    options = {
        zoom.enable = lib.mkEnableOption "enables zoom";
    };

    config = lib.mkIf config.zoom.enable  {
        homebrew.casks = [ "zoom" ];
    };
}
