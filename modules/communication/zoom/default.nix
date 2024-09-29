{ pkgs, lib, config, username, ... }: {

    options = {
        zoom.enable = lib.mkEnableOption "enables zoom";
    };

    config = lib.mkIf config.zoom.enable  {
        home-manager.users.${username} = {pkgs, ... }: {
            home.packages = with pkgs; [ zoom-us ];
        };
    };
}
