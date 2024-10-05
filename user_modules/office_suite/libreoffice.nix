{ pkgs, lib, config, user_settings, ... }: {

    options = {
        libreoffice.enable = lib.mkEnableOption "enables libreoffice";
    };

    config = lib.mkIf config.libreoffice.enable  {
        home.packages = with pkgs; [ libreoffice-still ];
    };
}
