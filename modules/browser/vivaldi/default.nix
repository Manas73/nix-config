{ pkgs, lib, config, username, ... }: {

    options = {
        vivaldi.enable = lib.mkEnableOption "enables vivaldi";
    };

    config = lib.mkIf config.vivaldi.enable {
        home-manager.users.${username} = {pkgs, ... }: {
            home.packages = with pkgs; [ vivaldi ];
        };
    };
}