{ pkgs, lib, config, username, ... }: {

    options = {
        datagrip.enable = lib.mkEnableOption "enables datagrip";
    };

    config = lib.mkIf config.datagrip.enable  {
        home-manager.users.${username} = {pkgs, ... }: {
            home.packages = with pkgs; [ jetbrains.datagrip ];
        };
    };
}
