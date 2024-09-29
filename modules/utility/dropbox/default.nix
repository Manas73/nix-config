{ pkgs, lib, config, username, ... }: {

    options = {
        dropbox.enable = lib.mkEnableOption "enables dropbox";
    };

    config = lib.mkIf config.dropbox.enable  {
        home-manager.users.${username} = {pkgs, ... }: {
            home.packages = with pkgs; [ dropbox ];
        };
    };
}
