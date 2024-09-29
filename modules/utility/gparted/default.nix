{ pkgs, lib, config, username, ... }: {

    options = {
        gparted.enable = lib.mkEnableOption "enables gparted";
    };

    config = lib.mkIf config.gparted.enable  {
        home-manager.users.${username} = {pkgs, ... }: {
            home.packages = with pkgs; [ gparted ];
        };
    };
}
