{ pkgs, lib, config, username, ... }: {

    options = {
        libreoffice.enable = lib.mkEnableOption "enables libreoffice";
    };

    config = lib.mkIf config.libreoffice.enable  {
        home-manager.users.${username} = {pkgs, ... }: {
            home.packages = with pkgs; [ libreoffice-still ];
        };
    };
}
