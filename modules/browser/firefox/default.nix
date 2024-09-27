{ pkgs, lib, config, username, ... }: {

    options = {
        firefox.enable = lib.mkEnableOption "enables firefox";
    };

    config = lib.mkIf config.firefox.enable {
        home-manager.users.${username} = {pkgs, ... }: {
            home.packages = with pkgs; [ firefox ];
        };
    };
}