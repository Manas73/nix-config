{ pkgs, lib, config, username, ... }: {

    options = {
        teams.enable = lib.mkEnableOption "enables teams";
    };

    config = lib.mkIf config.teams.enable  {
        home-manager.users.${username} = {pkgs, ... }: {
            home.packages = with pkgs; [ teams ];
        };
    };
}
