{ pkgs, lib, config, user_settings, ... }: {

    options = {
        zoom.enable = lib.mkEnableOption "enables zoom";
    };

    config = lib.mkIf config.zoom.enable  {
        home.packages = with pkgs; [ zoom-us ];
    };
}
